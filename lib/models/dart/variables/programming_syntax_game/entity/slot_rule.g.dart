// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SlotRule _$SlotRuleFromJson(Map<String, dynamic> json) => _SlotRule(
  type: $enumDecode(_$BlockTypeEnumMap, json['type']),
  val: json['val'] as String,
  errMsg: json['errMsg'] as String,
);

Map<String, dynamic> _$SlotRuleToJson(_SlotRule instance) => <String, dynamic>{
  'type': _$BlockTypeEnumMap[instance.type]!,
  'val': instance.val,
  'errMsg': instance.errMsg,
};

const _$BlockTypeEnumMap = {
  BlockType.keyword: 'keyword',
  BlockType.type: 'type',
  BlockType.name: 'name',
  BlockType.value: 'value',
  BlockType.operator: 'operator',
};
