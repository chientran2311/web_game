import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';

part 'slot_rule.freezed.dart';
part 'slot_rule.g.dart';

@freezed
abstract class SlotRule with _$SlotRule {
  const factory SlotRule({
    required BlockType type,
    required String val,
    required String errMsg,
  }) = _SlotRule;

  factory SlotRule.fromJson(Map<String, dynamic> json) =>
      _$SlotRuleFromJson(json);
}
