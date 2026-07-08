import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';

part 'syntax_block.freezed.dart';
part 'syntax_block.g.dart';

@freezed
abstract class SyntaxBlock with _$SyntaxBlock {
  const factory SyntaxBlock({
    required String id,
    required String text,
    required BlockType type,
    required BlockColor color,
    @Default(false) bool isCustom,
    String? customValue,
  }) = _SyntaxBlock;

  factory SyntaxBlock.fromJson(Map<String, dynamic> json) =>
      _$SyntaxBlockFromJson(json);
}
