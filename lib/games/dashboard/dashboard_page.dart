import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'widgets/dashboard_navbar.dart';
import 'widgets/dashboard_hero.dart';
import 'widgets/dashboard_sections.dart';
import 'widgets/dashboard_footer.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final width = MediaQuery.sizeOf(context).width;

    if (width <= 0) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          const DashboardNavbar(),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: const [
                  DashboardHero(),
                  DashboardSections(),
                  DashboardFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
