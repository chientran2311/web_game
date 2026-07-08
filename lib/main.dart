import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_game/core/di/di.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Khởi tạo GetIt DI
  await setupLocator();

  // Khởi chạy App được bọc trong ProviderScope của Riverpod
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
