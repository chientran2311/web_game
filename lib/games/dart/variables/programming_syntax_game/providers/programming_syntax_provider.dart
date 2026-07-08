import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_game/core/utils/logger.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/state/programming_syntax_state.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/events/programming_syntax_levels.dart';

part 'programming_syntax_provider.g.dart';

@riverpod
class ProgrammingSyntaxGameNotifier extends _$ProgrammingSyntaxGameNotifier {
  @override
  ProgrammingSyntaxState build() {
    AppLogger.i("ProgrammingSyntaxGameNotifier: building state");
    return ProgrammingSyntaxState(
      inventoryBlocks: List.from(defaultBlocks),
    );
  }

  void selectBlock(SyntaxBlock block) {
    AppLogger.d("selectBlock: text='${block.text}', type=${block.type}");
    
    final currentLevelData = gameLevels.firstWhere(
      (l) => l.level == state.currentLevel,
      orElse: () => gameLevels.first,
    );

    // 1. Tìm ô trống có cùng loại
    int targetIdx = -1;
    for (int i = 0; i < 6; i++) {
      if (i < state.slotPlacements.length && state.slotPlacements[i] == null) {
        final rule = currentLevelData.rules['slot$i'];
        if (rule != null && rule.type == block.type) {
          targetIdx = i;
          AppLogger.d("selectBlock: Found empty matching slot$i");
          break;
        }
      }
    }

    // 2. Nếu không có ô trống cùng loại, tìm ô đã có khối nhưng cùng loại để ghi đè (thay thế)
    if (targetIdx == -1) {
      for (int i = 0; i < 6; i++) {
        if (i < state.slotPlacements.length) {
          final rule = currentLevelData.rules['slot$i'];
          if (rule != null && rule.type == block.type) {
            targetIdx = i;
            AppLogger.d("selectBlock: Found filled matching slot$i to overwrite");
            break;
          }
        }
      }
    }

    if (targetIdx != -1) {
      final updatedPlacements = List<SyntaxBlock?>.from(state.slotPlacements);
      updatedPlacements[targetIdx] = block;
      state = state.copyWith(
        slotPlacements: updatedPlacements,
        isTerminalError: false,
        terminalOutput: '\$ Đã đặt khối [${block.text}] vào vị trí ô số ${targetIdx + 1}.',
      );
      AppLogger.i("selectBlock: Placed block successfully at index $targetIdx");
    } else {
      AppLogger.w("selectBlock: No matching slot for block type ${block.type}");
      state = state.copyWith(
        terminalOutput: '! Lỗi: Vị trí ô lắp ghép không hỗ trợ khối dạng [${block.type.name.toUpperCase()}].',
        isTerminalError: true,
      );
    }
  }

  void removeBlock(int slotIndex) {
    AppLogger.d("removeBlock: slotIndex=$slotIndex");
    if (slotIndex >= 0 && slotIndex < state.slotPlacements.length) {
      final updatedPlacements = List<SyntaxBlock?>.from(state.slotPlacements);
      updatedPlacements[slotIndex] = null;
      state = state.copyWith(
        slotPlacements: updatedPlacements,
      );
    } else {
      AppLogger.e("removeBlock: slotIndex $slotIndex is out of bounds [0, ${state.slotPlacements.length})");
    }
  }

  void placeBlockAt(SyntaxBlock block, int slotIndex) {
    AppLogger.d("placeBlockAt: text='${block.text}', slotIndex=$slotIndex");
    if (slotIndex >= 0 && slotIndex < state.slotPlacements.length) {
      final updatedPlacements = List<SyntaxBlock?>.from(state.slotPlacements);
      updatedPlacements[slotIndex] = block;
      state = state.copyWith(
        slotPlacements: updatedPlacements,
      );
    } else {
      AppLogger.e("placeBlockAt: slotIndex $slotIndex is out of bounds [0, ${state.slotPlacements.length})");
    }
  }

  void updateCustomValue(int slotIndex, String value) {
    AppLogger.d("updateCustomValue: slotIndex=$slotIndex, value='$value'");
    if (slotIndex >= 0 && slotIndex < state.slotPlacements.length) {
      final placedBlock = state.slotPlacements[slotIndex];
      if (placedBlock != null && placedBlock.isCustom) {
        final updatedPlacements = List<SyntaxBlock?>.from(state.slotPlacements);
        updatedPlacements[slotIndex] = placedBlock.copyWith(customValue: value);
        state = state.copyWith(
          slotPlacements: updatedPlacements,
        );
      } else {
        AppLogger.w("updateCustomValue: block at $slotIndex is null or not a custom input block");
      }
    } else {
      AppLogger.e("updateCustomValue: slotIndex $slotIndex is out of bounds [0, ${state.slotPlacements.length})");
    }
  }

  void filterInventory(InventoryFilter filter) {
    AppLogger.d("filterInventory: filter=$filter");
    state = state.copyWith(currentFilter: filter);
  }

  void toggleHelp(bool visible) {
    AppLogger.d("toggleHelp: visible=$visible");
    state = state.copyWith(showHelpOverlay: visible);
  }

  void resetCurrentLevel() {
    AppLogger.i("resetCurrentLevel: resetting level ${state.currentLevel}");
    final updatedPlacements = List<SyntaxBlock?>.filled(6, null);
    state = state.copyWith(
      slotPlacements: updatedPlacements,
      isSuccessCompleted: false,
      isTerminalError: false,
      terminalOutput: '\$ level ${state.currentLevel} loaded. Enter declarations...',
    );
  }

  bool verifySyntax() {
    AppLogger.i("verifySyntax: verifying syntax for level ${state.currentLevel}");
    final currentLevelData = gameLevels.firstWhere(
      (l) => l.level == state.currentLevel,
      orElse: () {
        AppLogger.w("verifySyntax: level ${state.currentLevel} not found in gameLevels. Falling back to first level.");
        return gameLevels.first;
      },
    );

    final errors = <String>[];
    final codeChain = <String>[];

    for (int i = 0; i < 6; i++) {
      if (i >= state.slotPlacements.length) {
        AppLogger.e("verifySyntax: index $i is out of bounds for slotPlacements of length ${state.slotPlacements.length}");
        errors.add("Lỗi cấu trúc ô lắp ghép.");
        break;
      }
      final placed = state.slotPlacements[i];
      final rule = currentLevelData.rules['slot$i'];

      if (rule == null) {
        AppLogger.v("verifySyntax: rule at slot$i is null");
        continue;
      }

      if (placed == null) {
        AppLogger.d("verifySyntax: slot$i is empty. Rule requires type: ${rule.type}");
        errors.add('Thiếu cú pháp ở vị trí số ${i + 1} (${rule.type.name.toUpperCase()}).');
        continue;
      }

      AppLogger.d("verifySyntax: checking slot$i. Placed block: text='${placed.text}', type=${placed.type}. Rule expected type: ${rule.type}");

      if (placed.type != rule.type) {
        AppLogger.d("verifySyntax: slot$i type mismatch. Placed: ${placed.type}, Expected: ${rule.type}");
        errors.add('Vị trí số ${i + 1} yêu cầu một khối dạng [${rule.type.name.toUpperCase()}].');
        continue;
      }

      if (rule.type == BlockType.name) {
        final inputVal = placed.customValue?.trim() ?? '';
        AppLogger.d("verifySyntax: slot$i custom name check. Input: '$inputVal', Expected: '${rule.val}'");
        if (inputVal.isEmpty) {
          errors.add('Bạn chưa đặt tên biến ở ô thứ 3.');
        } else if (inputVal != rule.val) {
          errors.add('Tên biến "$inputVal" chưa khớp yêu cầu. Hãy sửa lại thành "${rule.val}".');
        } else {
          codeChain.add(inputVal);
        }
      } else {
        AppLogger.d("verifySyntax: slot$i value check. Placed text: '${placed.text}', Expected: '${rule.val}'");
        if (placed.text != rule.val) {
          errors.add(rule.errMsg);
        } else {
          codeChain.add(placed.text);
        }
      }
    }

    if (errors.isNotEmpty) {
      AppLogger.w("verifySyntax: level ${state.currentLevel} verification failed with error: '${errors.first}'");
      state = state.copyWith(
        terminalOutput: 'Compilation Error:\n> ${errors.first}',
        isTerminalError: true,
      );
      return false;
    } else {
      final assembledCode = codeChain.join(' ');
      AppLogger.i("verifySyntax: level ${state.currentLevel} verification succeeded! Code: '$assembledCode'");
      state = state.copyWith(
        score: state.score + 100,
        isSuccessCompleted: true,
        isTerminalError: false,
        terminalOutput: '\$ dart compile main.dart\nCompiling...\nSuccess! Output code:\n$assembledCode\nVariable initialized correctly! +100pts',
      );
      return true;
    }
  }

  void goToNextLevel() {
    if (state.currentLevel < state.maxLevels) {
      final nextLvl = state.currentLevel + 1;
      state = state.copyWith(
        currentLevel: nextLvl,
        slotPlacements: List<SyntaxBlock?>.filled(6, null),
        isSuccessCompleted: false,
        isTerminalError: false,
        terminalOutput: '\$ level $nextLvl loaded. Enter declarations...',
      );
    } else {
      state = state.copyWith(
        terminalOutput: '\$ CHÚC MỪNG! Bạn đã hoàn thành toàn bộ ${state.maxLevels} nhiệm vụ lập trình! Tổng điểm: ${state.score}',
        isSuccessCompleted: false,
        isTerminalError: false,
      );
    }
  }

  void changeFont(String fontName) {
    state = state.copyWith(fontFamily: fontName);
  }

  void toggleSound(bool enabled) {
    state = state.copyWith(isSoundEnabled: enabled);
  }

  void toggleAmbient(bool enabled) {
    state = state.copyWith(isAmbientPlaying: enabled);
  }

  void toggleGrid(bool enabled) {
    state = state.copyWith(isGridEnabled: enabled);
  }

  void toggleTweaks() {
    state = state.copyWith(isTweakOpen: !state.isTweakOpen);
  }
}
