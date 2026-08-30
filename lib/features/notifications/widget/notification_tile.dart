import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/notifications/model/notification_item_model.dart';

class NotificationTile extends StatelessWidget {
  final NotificationItemModel item;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: item.isRead
              ? AppColors.surfaceCard
              : const Color(0xFF272A35),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: item.isRead
                ? Colors.white.withValues(alpha: 0.06)
                : AppColors.primary.withValues(alpha: 0.35),
            width: item.isRead ? 1.0 : 1.2,
          ),
          boxShadow: item.isRead
              ? null
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 12.r,
                    offset: Offset(0, 4.r),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon container
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: item.iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                size: 20.sp,
                color: item.iconColor,
              ),
            ),
            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: AppTextStyle.titleSmall.copyWith(
                            color: Colors.white,
                            fontSize: 13.5.sp,
                            fontWeight: item.isRead
                                ? FontWeight.w600
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        item.time,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textMuted,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.description,
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: item.isRead
                          ? AppColors.textSecondary
                          : Colors.white.withValues(alpha: 0.9),
                      fontSize: 12.sp,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            if (!item.isRead) ...[
              SizedBox(width: 8.w),
              Container(
                width: 8.r,
                height: 8.r,
                margin: EdgeInsets.only(top: 4.h),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
