// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syntax_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyntaxLevel _$SyntaxLevelFromJson(Map<String, dynamic> json) => _SyntaxLevel(
  level: (json['level'] as num).toInt(),
  quest: json['quest'] as String,
  expected: (json['expected'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  rules: (json['rules'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, SlotRule.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$SyntaxLevelToJson(_SyntaxLevel instance) =>
    <String, dynamic>{
      'level': instance.level,
      'quest': instance.quest,
      'expected': instance.expected,
      'rules': instance.rules,
    };
