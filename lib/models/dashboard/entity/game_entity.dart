import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/dashboard/enums/dashboard_enums.dart';

part 'game_entity.freezed.dart';
part 'game_entity.g.dart';

@freezed
abstract class GameEntity with _$GameEntity {
  const factory GameEntity({
    required String id,
    required String title,
    required String description,
    required GameCategory category,
    required GameDifficulty difficulty,
    required int xpReward,
    @Default(false) bool isNew,
    @Default(0.0) double progress,
    DateTime? lastPlayedAt,
  }) = _GameEntity;

  factory GameEntity.fromJson(Map<String, dynamic> json) =>
      _$GameEntityFromJson(json);
}
