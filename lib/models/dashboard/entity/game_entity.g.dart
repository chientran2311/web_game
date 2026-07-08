// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameEntity _$GameEntityFromJson(Map<String, dynamic> json) => _GameEntity(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$GameCategoryEnumMap, json['category']),
  difficulty: $enumDecode(_$GameDifficultyEnumMap, json['difficulty']),
  xpReward: (json['xpReward'] as num).toInt(),
  isNew: json['isNew'] as bool? ?? false,
  progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
  lastPlayedAt: json['lastPlayedAt'] == null
      ? null
      : DateTime.parse(json['lastPlayedAt'] as String),
);

Map<String, dynamic> _$GameEntityToJson(_GameEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$GameCategoryEnumMap[instance.category]!,
      'difficulty': _$GameDifficultyEnumMap[instance.difficulty]!,
      'xpReward': instance.xpReward,
      'isNew': instance.isNew,
      'progress': instance.progress,
      'lastPlayedAt': instance.lastPlayedAt?.toIso8601String(),
    };

const _$GameCategoryEnumMap = {
  GameCategory.variables: 'variables',
  GameCategory.functions: 'functions',
  GameCategory.dataTypes: 'dataTypes',
  GameCategory.realPractice: 'realPractice',
};

const _$GameDifficultyEnumMap = {
  GameDifficulty.easy: 'easy',
  GameDifficulty.medium: 'medium',
  GameDifficulty.hard: 'hard',
};
