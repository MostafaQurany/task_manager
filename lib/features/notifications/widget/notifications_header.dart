import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class NotificationsHeader extends StatelessWidget {
  final int unreadCount;
  final VoidCallback onMarkAllAsRead;

  const NotificationsHeader({
    super.key,
    required this.unreadCount,
    required this.onMarkAllAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).notificationsTitle,
                style: AppTextStyle.titleLarge.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              if (unreadCount > 0)
                Text(
                  S.of(context).unreadNotifications(unreadCount),
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        if (unreadCount > 0)
          GestureDetector(
            onTap: onMarkAllAsRead,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                S.of(context).markAllRead,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.5.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
