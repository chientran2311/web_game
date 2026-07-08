import 'package:flutter/material.dart';
import 'package:web_game/core/theme/app_theme.dart';
import 'package:web_game/core/utils/screen_utils.dart';
import 'package:web_game/models/dashboard/entity/game_entity.dart';
import 'package:web_game/models/dashboard/enums/dashboard_enums.dart';
import 'package:web_game/core/utils/l10n_extension.dart';
import 'dashboard_enum_extensions.dart';

class DashboardGameCard extends StatelessWidget {
  final GameEntity game;
  final VoidCallback onTap;

  const DashboardGameCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border.all(color: AppTheme.border, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Media / 2D Preview
            Container(
              height: 180.h,
              color: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: _buildVisualPreview(game.id),
                  ),
                  if (game.isNew)
                    Positioned(
                      top: 12.h,
                      right: 12.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppTheme.border, width: 1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          context.l10n.tag_new.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.foreground,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Divider
            Container(
              height: 1,
              color: AppTheme.border,
            ),
            // Card Body
            Expanded(
              child: Container(
                color: AppTheme.surface,
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.category.displayName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textGrey,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      game.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.foreground,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Text(
                        game.description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppTheme.textGrey,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Divider
                    Container(
                      height: 1,
                      color: AppTheme.border,
                      margin: EdgeInsets.only(bottom: 16.h),
                    ),
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Difficulty indicators
                        Row(
                          children: [
                            _buildDiffDot(1),
                            SizedBox(width: 4.w),
                            _buildDiffDot(2),
                            SizedBox(width: 4.w),
                            _buildDiffDot(3),
                            SizedBox(width: 6.w),
                            Text(
                              game.difficulty.getLocalizedName(context),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.foreground,
                              ),
                            ),
                          ],
                        ),
                        // XP Reward
                        Text(
                          '+${game.xpReward} XP',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiffDot(int dotIndex) {
    final active = (game.difficulty == GameDifficulty.easy && dotIndex == 1) ||
        (game.difficulty == GameDifficulty.medium && dotIndex <= 2) ||
        (game.difficulty == GameDifficulty.hard && dotIndex <= 3);

    return Container(
      width: 8.r,
      height: 8.r,
      decoration: BoxDecoration(
        color: active
            ? (game.difficulty == GameDifficulty.hard ? AppTheme.accentSecondary : AppTheme.foreground)
            : AppTheme.border,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildVisualPreview(String gameId) {
    switch (gameId) {
      case 'scope-detective':
        // Lens/Scope preview
        return Container(
          width: 80.r,
          height: 80.r,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.border, width: 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.all(8.r),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.accentSecondary, width: 1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(6.r),
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                color: AppTheme.foreground,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ),
        );
      case 'boolean-bridge':
        // Bridge preview
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: AppTheme.foreground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Expanded(
                child: Container(
                  height: 6.h,
                  color: AppTheme.accentSecondary,
                  child: Center(
                    child: Container(
                      width: 14.r,
                      height: 14.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppTheme.accentSecondary, width: 2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: AppTheme.foreground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        );
      case 'callback-castle':
        // Castle preview
        return Container(
          width: 80.w,
          height: 60.h,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: AppTheme.foreground, width: 2),
              left: BorderSide(color: AppTheme.foreground, width: 2),
              right: BorderSide(color: AppTheme.foreground, width: 2),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 24.w,
                height: 30.h,
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(color: AppTheme.accentSecondary, width: 2),
                    left: BorderSide(color: AppTheme.accentSecondary, width: 2),
                    right: BorderSide(color: AppTheme.accentSecondary, width: 2),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        );
      case 'array-architect':
        // Block stack preview
        return SizedBox(
          width: 60.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppTheme.accentSecondary,
                  border: Border.all(color: AppTheme.accentSecondary),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: Text('[2]', style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppTheme.foreground,
                  border: Border.all(color: AppTheme.foreground),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: Text('[1]', style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 4.h),
              Container(
                height: 18.h,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  border: Border.all(color: AppTheme.border),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: Text('[0]', style: TextStyle(color: AppTheme.foreground, fontSize: 9.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      case 'refactor-rush':
        // Refactor preview
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Transform.rotate(
                      angle: 0.785,
                      child: Container(
                        width: 30.w,
                        height: 2.h,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ),
                  Center(
                    child: Transform.rotate(
                      angle: -0.785,
                      child: Container(
                        width: 30.w,
                        height: 2.h,
                        color: AppTheme.textGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Text('➔', style: TextStyle(fontSize: 14.sp, color: AppTheme.foreground)),
            SizedBox(width: 16.w),
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.border),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 30.w,
                height: 2.h,
                color: AppTheme.accentSecondary,
              ),
            ),
          ],
        );
      case 'recursion-tower':
        // Recursion preview
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.accentSecondary),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Container(
              width: 44.r,
              height: 44.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.foreground),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.textGrey),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        );
      case 'constant-quest':
        // Quest preview
        return Container(
          width: 60.r,
          height: 60.r,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.foreground, width: 2),
            borderRadius: BorderRadius.circular(8.r),
            color: AppTheme.surface,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -16.h,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.accentSecondary, width: 2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
              ),
              Container(
                color: AppTheme.surface,
                child: Text(
                  'const',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        );
      case 'algorithm-escape':
        // Maze preview
        return SizedBox(
          width: 90.w,
          height: 90.h,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth <= 0 || constraints.maxHeight <= 0) {
                return const SizedBox.shrink();
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final isWall = index == 0 || index == 5 || index == 7;
                  final isGoal = index == 2;
                  final isPlayer = index == 4;

                  return Container(
                    decoration: BoxDecoration(
                      color: isWall
                          ? AppTheme.foreground
                          : (isGoal
                              ? Colors.white
                              : (isPlayer ? AppTheme.accentSecondary : Colors.white)),
                      border: Border.all(
                        color: isGoal ? AppTheme.accentSecondary : AppTheme.border,
                        width: isGoal ? 2 : 1,
                        style: isGoal ? BorderStyle.solid : BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    alignment: Alignment.center,
                    child: isGoal
                        ? Text('🌀', style: TextStyle(fontSize: 10.sp))
                        : (isPlayer ? Text('🤖', style: TextStyle(fontSize: 10.sp)) : null),
                  );
                },
              );
            },
          ),
        );
      default:
        return Icon(Icons.gamepad, size: 48.r, color: AppTheme.muted);
    }
  }
}
