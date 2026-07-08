import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:web_game/core/storage/local_storage.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Lưu trữ cục bộ
  final localStorage = await AppLocalStorage.create();
  getIt.registerSingleton<AppLocalStorage>(localStorage);

  // 2. Logger dùng chung
  getIt.registerLazySingleton<Logger>(() => Logger());

  // 3. Register Repositories và Services khác tại đây...
}
