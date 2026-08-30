import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskDetailMetaCard extends StatelessWidget {
  final String category;
  final String dueDate;
  final WaitingOn waitingOn;
  final String? blockedByTaskTitle;
  final String? description;

  const TaskDetailMetaCard({
    super.key,
    required this.category,
    required this.dueDate,
    this.waitingOn = WaitingOn.none,
    this.blockedByTaskTitle,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Category & Due Date & Waiting On
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  category,
                  style: AppTextStyle.chip.copyWith(
                    color: AppColors.primary,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.calendar_today_rounded,
                size: 13.sp,
                color: AppColors.textMuted,
              ),
              SizedBox(width: 4.w),
              Text(
                dueDate,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11.sp,
                ),
              ),
              const Spacer(),
              if (waitingOn.isWaiting)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: (waitingOn == WaitingOn.client
                            ? AppColors.warning
                            : AppColors.primaryLight)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: (waitingOn == WaitingOn.client
                              ? AppColors.warning
                              : AppColors.primaryLight)
                          .withValues(alpha: 0.3),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.hourglass_top_rounded,
                        size: 11.sp,
                        color: waitingOn == WaitingOn.client
                            ? AppColors.warning
                            : AppColors.primaryLight,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        waitingOn.label,
                        style: AppTextStyle.chip.copyWith(
                          color: waitingOn == WaitingOn.client
                              ? AppColors.warning
                              : AppColors.primaryLight,
                          fontSize: 9.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Blocked by banner if applicable
          if (blockedByTaskTitle != null && blockedByTaskTitle!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColors.danger.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14.sp,
                    color: AppColors.danger,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      'Blocked by: $blockedByTaskTitle',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Description if available
          if (description != null && description!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              description!,
              style: AppTextStyle.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.5.sp,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
