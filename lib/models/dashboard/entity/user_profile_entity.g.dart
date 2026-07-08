// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileEntity _$UserProfileEntityFromJson(Map<String, dynamic> json) =>
    _UserProfileEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarInitials: json['avatarInitials'] as String,
      totalXp: (json['totalXp'] as num).toInt(),
    );

Map<String, dynamic> _$UserProfileEntityToJson(_UserProfileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarInitials': instance.avatarInitials,
      'totalXp': instance.totalXp,
    };
