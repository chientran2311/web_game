// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syntax_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyntaxBlock _$SyntaxBlockFromJson(Map<String, dynamic> json) => _SyntaxBlock(
  id: json['id'] as String,
  text: json['text'] as String,
  type: $enumDecode(_$BlockTypeEnumMap, json['type']),
  color: $enumDecode(_$BlockColorEnumMap, json['color']),
  isCustom: json['isCustom'] as bool? ?? false,
  customValue: json['customValue'] as String?,
);

Map<String, dynamic> _$SyntaxBlockToJson(_SyntaxBlock instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': _$BlockTypeEnumMap[instance.type]!,
      'color': _$BlockColorEnumMap[instance.color]!,
      'isCustom': instance.isCustom,
      'customValue': instance.customValue,
    };

const _$BlockTypeEnumMap = {
  BlockType.keyword: 'keyword',
  BlockType.type: 'type',
  BlockType.name: 'name',
  BlockType.value: 'value',
  BlockType.operator: 'operator',
};

const _$BlockColorEnumMap = {
  BlockColor.orange: 'orange',
  BlockColor.cyan: 'cyan',
  BlockColor.yellow: 'yellow',
  BlockColor.purple: 'purple',
  BlockColor.green: 'green',
};
