import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/core/utils/l10n_extension.dart';
import 'package:web_game/games/dashboard/dashboard_provider.dart';

class DashboardNavbar extends HookConsumerWidget {
  const DashboardNavbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    final width = MediaQuery.sizeOf(context).width;

    final searchController = useTextEditingController(text: state.searchQuery);

    // Sync controller with state if state changes from outside
    useEffect(() {
      if (searchController.text != state.searchQuery) {
        searchController.text = state.searchQuery;
      }
      return null;
    }, [state.searchQuery]);

    return Container(
      height: 72.h,
      decoration: const BoxDecoration(
        color: AppTheme.background,
        border: Border(
          bottom: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1440.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Logo and links
              Row(
                children: [
                  // Logo
                  Row(
                    children: [
                      Text(
                        'CODEPLAY',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.foreground,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        width: 6.r,
                        height: 6.r,
                        decoration: const BoxDecoration(
                          color: AppTheme.accentSecondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  if (width >= 920) ...[
                    SizedBox(width: 32.w),
                    // Navigation links
                    _NavLink(
                      title: context.l10n.navbar_home,
                      isActive: true,
                      onTap: () {},
                    ),
                    SizedBox(width: 24.w),
                    _NavLink(
                      title: context.l10n.navbar_leaderboard,
                      isActive: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 24.w),
                    _NavLink(
                      title: context.l10n.navbar_challenges,
                      isActive: false,
                      onTap: () {},
                    ),
                  ],
                ],
              ),

              // Right side: Search & profile
              Row(
                children: [
                  if (width >= 600) ...[
                    // Search bar
                    SizedBox(
                      width: 240.w,
                      height: 38.h,
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) => notifier.updateSearchQuery(val),
                        style: TextStyle(fontSize: 14.sp, color: AppTheme.foreground),
                        decoration: InputDecoration(
                          hintText: context.l10n.navbar_search_placeholder,
                          hintStyle: const TextStyle(color: AppTheme.muted),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16.r,
                            color: AppTheme.muted,
                          ),
                          filled: true,
                          fillColor: AppTheme.surface,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: AppTheme.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: AppTheme.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(color: AppTheme.foreground),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                  ],

                  // Profile with XP
                  Container(
                    decoration: width >= 600
                        ? const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: AppTheme.border, width: 1),
                            ),
                          )
                        : null,
                    padding: EdgeInsets.only(left: width >= 600 ? 16.w : 0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${state.userProfile?.totalXp ?? 0} XP',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.accentSecondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            color: AppTheme.foreground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            state.userProfile?.avatarInitials ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: isActive ? AppTheme.foreground : AppTheme.muted,
          ),
        ),
      ),
    );
  }
}

