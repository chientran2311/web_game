import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/core/utils/l10n_extension.dart';

/// Configuration class to easily replace the featured game in DashboardHero
class HeroGameConfig {
  final String tag;
  final String title;
  final String description;
  final String routePath;
  final Widget visualMockup;

  const HeroGameConfig({
    required this.tag,
    required this.title,
    required this.description,
    required this.routePath,
    required this.visualMockup,
  });
}

class DashboardHero extends StatelessWidget {
  final HeroGameConfig? config;

  const DashboardHero({
    super.key,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 920;

    // Default configuration points to the Constant Quest (Programming Syntax Game)
    final activeConfig = config ?? HeroGameConfig(
      tag: context.l10n.hero_tag,
      title: 'Constant Quest: Dart Syntax',
      description: 'Lắp ghép các khối cú pháp lập trình Dart theo trật tự để biên dịch thành công. Trực quan hóa hằng số và kiểu dữ liệu sinh động!',
      routePath: '/games/constant-quest',
      visualMockup: const ConstantQuestMockup(),
    );

    return Container(
      margin: EdgeInsets.only(top: 40.h, bottom: 56.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1440.w),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            border: Border.all(color: AppTheme.border, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(width >= 600 ? 56.r : 24.r),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero Content (Left)
              Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 540.w : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeConfig.tag.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: AppTheme.accentSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      activeConfig.title,
                      style: TextStyle(
                        fontSize: width >= 600 ? 42.sp : 32.sp,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.foreground,
                        letterSpacing: -1,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      activeConfig.description,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      children: [
                        _HeroButton(
                          title: context.l10n.hero_play_now,
                          isPrimary: true,
                          onPressed: () {
                            // Navigate to the featured game using context.push to keep back navigation stack
                            context.push(activeConfig.routePath);
                          },
                        ),
                        SizedBox(width: 16.w),
                        _HeroButton(
                          title: context.l10n.hero_view_list,
                          isPrimary: false,
                          onPressed: () {
                            // Scroll down to the list section
                            // Standard behavior: find Scrollable and scroll
                            Scrollable.ensureVisible(
                              context,
                              duration: const Duration(milliseconds: 500),
                              alignment: 0.1,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (!isDesktop) SizedBox(height: 40.h),

              // Hero Visual Mockup (Right)
              Container(
                width: isDesktop ? 440.w : double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C0E1A), // cyberpunk dark background
                  border: Border.all(color: AppTheme.border, width: 1),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(0, 10),
                      blurRadius: 30,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.r),
                child: activeConfig.visualMockup,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Cyberpunk default visual mockup for Constant Quest
class ConstantQuestMockup extends StatelessWidget {
  const ConstantQuestMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mock Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _MockDot(color: const Color(0xFFFF7E40)),
                SizedBox(width: 6.w),
                _MockDot(color: const Color(0xFFFFE040)),
                SizedBox(width: 6.w),
                _MockDot(color: const Color(0xFF00FF66)),
              ],
            ),
            Text(
              'LEVEL 01 - CONSTANT DECLARATION',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        // Visual slots mockup
        Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: const Color(0xFF161A2F).withValues(alpha: 0.4),
            border: Border.all(color: AppTheme.border, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMiniBlock('const', const Color(0xFFFF7E40)),
              _buildMiniBlock('int', const Color(0xFF00F2FE)),
              _buildMiniBlock('tuoi', const Color(0xFFFFE040)),
              _buildMiniBlock('=', const Color(0xFFBD10E0)),
              _buildMiniBlock('18', const Color(0xFF00FF66)),
              _buildMiniBlock(';', const Color(0xFFBD10E0)),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Output Preview
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'const int tuoi = 18;',
                style: TextStyle(
                  fontFamily: 'FiraCode',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF00FF66),
                  shadows: [
                    Shadow(
                      color: const Color(0xFF00FF66).withValues(alpha: 0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle_outline,
                size: 16.sp,
                color: const Color(0xFF00FF66),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMiniBlock(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'FiraCode',
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _HeroButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _HeroButton({
    required this.title,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.foreground : Colors.white,
          side: BorderSide(
            color: isPrimary ? AppTheme.foreground : AppTheme.border,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isPrimary ? Colors.white : AppTheme.foreground,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _MockDot extends StatelessWidget {
  final Color color;

  const _MockDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.r,
      height: 8.r,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
