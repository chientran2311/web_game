import 'package:flutter/material.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';

class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 600;

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.background,
        border: Border(
          top: BorderSide(color: AppTheme.border, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1440.w),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              // Footer Left (Logo and copy)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'CODEPLAY',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.foreground,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Container(
                        width: 5.r,
                        height: 5.r,
                        decoration: const BoxDecoration(
                          color: AppTheme.accentSecondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '© 2026 CODEPLAY. Được truyền cảm hứng bởi ngôn ngữ lập trình & Thiết kế bởi Behance.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),

              if (!isDesktop) SizedBox(height: 24.h),

              // Footer Right (Links)
              Wrap(
                spacing: 24.w,
                runSpacing: 12.h,
                children: [
                  _FooterLink(title: 'Giới thiệu', onTap: () {}),
                  _FooterLink(title: 'Hướng dẫn', onTap: () {}),
                  _FooterLink(title: 'Chính sách bảo mật', onTap: () {}),
                  _FooterLink(title: 'Liên hệ', onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterLink({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          color: AppTheme.textGrey,
        ),
      ),
    );
  }
}
