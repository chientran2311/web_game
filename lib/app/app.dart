import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_game/app/router/router.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/l10n/app_localizations.dart';



class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Boilerplate App',
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'), // Mặc định là tiếng Việt
      builder: (context, child) {
        ScreenUtils.init(context);
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
