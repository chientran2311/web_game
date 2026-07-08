import 'package:flutter/widgets.dart';
import 'package:web_game/models/dashboard/enums/dashboard_enums.dart';
import 'package:web_game/core/utils/l10n_extension.dart';

extension GameCategoryExtension on GameCategory {
  String get displayName {
    switch (this) {
      case GameCategory.variables:
        return 'Variables';
      case GameCategory.functions:
        return 'Functions';
      case GameCategory.dataTypes:
        return 'Data Types';
      case GameCategory.realPractice:
        return 'RealPractice';
    }
  }

  String get viDisplayName {
    switch (this) {
      case GameCategory.variables:
        return 'Biến';
      case GameCategory.functions:
        return 'Hàm';
      case GameCategory.dataTypes:
        return 'Kiểu dữ liệu';
      case GameCategory.realPractice:
        return 'Thực hành';
    }
  }
}

extension GameDifficultyExtension on GameDifficulty {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case GameDifficulty.easy:
        return context.l10n.difficulty_easy;
      case GameDifficulty.medium:
        return context.l10n.difficulty_medium;
      case GameDifficulty.hard:
        return context.l10n.difficulty_hard;
    }
  }
}
