import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/slot_rule.dart';

part 'syntax_level.freezed.dart';
part 'syntax_level.g.dart';

@freezed
abstract class SyntaxLevel with _$SyntaxLevel {
  const factory SyntaxLevel({
    required int level,
    required String quest,
    required List<String> expected,
    required Map<String, SlotRule> rules,
  }) = _SyntaxLevel;

  factory SyntaxLevel.fromJson(Map<String, dynamic> json) =>
      _$SyntaxLevelFromJson(json);
}
