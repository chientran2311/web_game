// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Web Game';

  @override
  String welcomeMessage(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get navbar_home => 'Home';

  @override
  String get navbar_leaderboard => 'Leaderboard';

  @override
  String get navbar_challenges => 'Challenges';

  @override
  String get navbar_search_placeholder => 'Search games...';

  @override
  String get hero_tag => 'INTERACTIVE LEARNING';

  @override
  String get hero_title => 'Play to code.\nMaster the source.';

  @override
  String get hero_description =>
      'Experience a brand new programming logic learning approach through vivid and intuitive logic game challenges.';

  @override
  String get hero_play_now => 'Play Now';

  @override
  String get hero_view_list => 'View List';

  @override
  String get recent_played_title => 'Recently Played';

  @override
  String get recent_played_progress => 'Progress';

  @override
  String get recent_played_continue => 'Continue';

  @override
  String get newly_added_title => 'Newly Added';

  @override
  String get all_games_no_results => 'No matching games found.';

  @override
  String get category_all => 'All';

  @override
  String get difficulty_easy => 'Easy';

  @override
  String get difficulty_medium => 'Medium';

  @override
  String get difficulty_hard => 'Hard';

  @override
  String get tag_new => 'New';
}
