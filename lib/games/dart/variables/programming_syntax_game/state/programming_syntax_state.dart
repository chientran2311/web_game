import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';

part 'programming_syntax_state.freezed.dart';

@freezed
abstract class ProgrammingSyntaxState with _$ProgrammingSyntaxState {
  const factory ProgrammingSyntaxState({
    @Default(0) int score,
    @Default(1) int currentLevel,
    @Default(3) int maxLevels,
    @Default(InventoryFilter.all) InventoryFilter currentFilter,
    @Default(true) bool isSoundEnabled,
    @Default(false) bool isAmbientPlaying,
    @Default(false) bool isTweakOpen,
    @Default('Outfit') String fontFamily,
    @Default(true) bool isGridEnabled,
    @Default([null, null, null, null, null, null]) List<SyntaxBlock?> slotPlacements,
    @Default([]) List<SyntaxBlock> inventoryBlocks,
    @Default('\$ system ready. Awaiting syntax declaration...') String terminalOutput,
    @Default(false) bool isTerminalError,
    @Default(false) bool isSuccessCompleted,
    @Default(true) bool showHelpOverlay,
  }) = _ProgrammingSyntaxState;
}
