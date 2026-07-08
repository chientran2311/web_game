import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/core/utils/l10n_extension.dart';
import 'package:web_game/games/dashboard/dashboard_provider.dart';
import 'dashboard_recent_card.dart';
import 'dashboard_game_card.dart';

class DashboardSections extends ConsumerWidget {
  const DashboardSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    final width = MediaQuery.sizeOf(context).width;

    // Calculate grid columns dynamically
    final columns3 = width >= 920 ? 3 : (width >= 600 ? 2 : 1);
    final columns4 = width >= 1200 ? 4 : (width >= 920 ? 3 : (width >= 600 ? 2 : 1));

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 0) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 1440.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. RECENTLY PLAYED SECTION
                  if (state.recentGames.isNotEmpty) ...[
                    _SectionTitle(title: context.l10n.recent_played_title),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns3,
                        crossAxisSpacing: 24.w,
                        mainAxisSpacing: 24.h,
                        childAspectRatio: width >= 600 ? 1.5 : 1.3,
                      ),
                      itemCount: state.recentGames.length,
                      itemBuilder: (context, idx) {
                        final game = state.recentGames[idx];
                        return DashboardRecentCard(
                          game: game,
                          onTap: () {
                            if (game.id == 'constant-quest') {
                              context.go('/games/constant-quest');
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 56.h),
                  ],

                  // 2. NEWLY ADDED SECTION
                  if (state.newlyAddedGames.isNotEmpty) ...[
                    _SectionTitle(title: context.l10n.newly_added_title),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns3,
                        crossAxisSpacing: 24.w,
                        mainAxisSpacing: 24.h,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: state.newlyAddedGames.length,
                      itemBuilder: (context, idx) {
                        final game = state.newlyAddedGames[idx];
                        return DashboardGameCard(
                          game: game,
                          onTap: () {
                            if (game.id == 'constant-quest') {
                              context.go('/games/constant-quest');
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 56.h),
                  ],

                  // 3. ALL GAMES SECTION (WITH TABS FILTERING)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppTheme.border, width: 1),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 56.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tabs row
                        _FilterTabs(
                          selectedCategory: state.selectedCategory,
                          onSelect: (cat) => notifier.selectCategory(cat),
                        ),
                        SizedBox(height: 32.h),

                        // Grid
                        if (state.filteredGames.isEmpty)
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 48.h),
                              child: Text(
                                context.l10n.all_games_no_results,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppTheme.textGrey,
                                ),
                              ),
                            ),
                          )
                        else
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns4,
                              crossAxisSpacing: 24.w,
                              mainAxisSpacing: 24.h,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: state.filteredGames.length,
                            itemBuilder: (context, idx) {
                              final game = state.filteredGames[idx];
                              return DashboardGameCard(
                                game: game,
                                onTap: () {
                                  if (game.id == 'constant-quest') {
                                    context.go('/games/constant-quest');
                                  }
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppTheme.foreground,
        ),
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onSelect;

  const _FilterTabs({
    required this.selectedCategory,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Variables', 'Functions', 'Data Types', 'RealPractice'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isActive = selectedCategory == cat;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ChoiceChip(
              label: Text(
                cat == 'All' ? context.l10n.category_all : cat,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: isActive ? AppTheme.foreground : AppTheme.textGrey,
                ),
              ),
              selected: isActive,
              onSelected: (_) => onSelect(cat),
              backgroundColor: Colors.transparent,
              selectedColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(
                  color: isActive ? AppTheme.border : Colors.transparent,
                  width: 1,
                ),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
