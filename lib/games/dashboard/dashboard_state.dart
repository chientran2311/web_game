import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web_game/models/normal_status_enum.dart';
import 'package:web_game/models/dashboard/entity/game_entity.dart';
import 'package:web_game/models/dashboard/entity/user_profile_entity.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(NormalStatus.initial) NormalStatus status,
    String? errorMessage,
    UserProfileEntity? userProfile,
    @Default([]) List<GameEntity> allGames,
    @Default('All') String selectedCategory,
    @Default('') String searchQuery,
  }) = _DashboardState;

  const DashboardState._();

  bool get isLoading => status == NormalStatus.loading;
  bool get hasError => status == NormalStatus.error;

  List<GameEntity> get filteredGames {
    return allGames.where((game) {
      final matchCategory = selectedCategory == 'All' ||
          game.category.name.toLowerCase() == selectedCategory.replaceAll(' ', '').toLowerCase();

      final matchSearch = searchQuery.isEmpty ||
          game.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          game.description.toLowerCase().contains(searchQuery.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  List<GameEntity> get recentGames {
    final played = allGames.where((game) => game.progress > 0 && game.lastPlayedAt != null).toList();
    played.sort((a, b) => b.lastPlayedAt!.compareTo(a.lastPlayedAt!));
    return played.take(3).toList();
  }

  List<GameEntity> get newlyAddedGames {
    return allGames.where((game) => game.isNew).take(3).toList();
  }
}
