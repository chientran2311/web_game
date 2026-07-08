import 'package:flutter/material.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/models/dashboard/entity/game_entity.dart';
import 'package:web_game/core/utils/l10n_extension.dart';
import 'dashboard_enum_extensions.dart';

class DashboardRecentCard extends StatelessWidget {
  final GameEntity game;
  final VoidCallback onTap;

  const DashboardRecentCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Generate human readable played time
    final playedTimeText = _getPlayedTimeText(game.lastPlayedAt);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppTheme.border, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.category.displayName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textGrey,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  game.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.foreground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.recent_played_progress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.textGrey,
                      ),
                    ),
                    Text(
                      '${game.progress.toInt()}%',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.textGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                // Progress Bar
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: game.progress / 100.0,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.accentSecondary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playedTimeText,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppTheme.textGrey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      context.l10n.recent_played_continue,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.foreground,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10.r,
                      color: AppTheme.foreground,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getPlayedTimeText(DateTime? dateTime) {
    if (dateTime == null) return '';
    final difference = DateTime.now().difference(dateTime);

    if (difference.inMinutes < 60) {
      return 'Chơi ${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return 'Chơi ${difference.inHours} giờ trước';
    } else {
      return 'Chơi ${difference.inDays} ngày trước';
    }
  }
}
