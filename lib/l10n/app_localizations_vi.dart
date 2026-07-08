// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Web Game';

  @override
  String welcomeMessage(Object name) {
    return 'Chào mừng, $name!';
  }

  @override
  String get navbar_home => 'Trang chủ';

  @override
  String get navbar_leaderboard => 'Bảng xếp hạng';

  @override
  String get navbar_challenges => 'Thử thách';

  @override
  String get navbar_search_placeholder => 'Tìm kiếm tựa game...';

  @override
  String get hero_tag => 'HỌC QUA TƯƠNG TÁC';

  @override
  String get hero_title => 'Chơi để lập trình.\nLàm chủ mã nguồn.';

  @override
  String get hero_description =>
      'Trải nghiệm phương pháp học tư duy lập trình hoàn toàn mới thông qua các thử thách game logic sinh động và trực quan.';

  @override
  String get hero_play_now => 'Chơi Ngay';

  @override
  String get hero_view_list => 'Xem Danh Sách';

  @override
  String get recent_played_title => 'Game đã mở gần nhất';

  @override
  String get recent_played_progress => 'Tiến trình';

  @override
  String get recent_played_continue => 'Tiếp tục';

  @override
  String get newly_added_title => 'Game mới thêm';

  @override
  String get all_games_no_results => 'Không tìm thấy tựa game nào phù hợp.';

  @override
  String get category_all => 'Tất cả';

  @override
  String get difficulty_easy => 'Dễ';

  @override
  String get difficulty_medium => 'Trung bình';

  @override
  String get difficulty_hard => 'Khó';

  @override
  String get tag_new => 'Mới';
}
