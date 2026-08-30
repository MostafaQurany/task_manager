import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';

class AllTasksCard extends StatelessWidget {
  final UserTaskModel task;
  final VoidCallback onToggleDone;
  final VoidCallback? onTap;

  const AllTasksCard({
    super.key,
    required this.task,
    required this.onToggleDone,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = task.status.color;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: task.blockedByTaskTitle != null
                ? AppColors.danger.withValues(alpha: 0.3)
                : task.isUrgent
                    ? AppColors.warning.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Checkbox toggle
            GestureDetector(
              onTap: onToggleDone,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 24.r,
                height: 24.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: task.isDone
                      ? AppColors.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: task.isDone
                        ? AppColors.primary
                        : AppColors.border,
                    width: 2,
                  ),
                ),
                child: task.isDone
                    ? Icon(Icons.check, size: 14.sp, color: AppColors.textDark)
                    : null,
              ),
            ),
            SizedBox(width: 12.w),

            // Title & metadata
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: AppTextStyle.titleSmall.copyWith(
                      color: Colors.white,
                      decoration: task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: task.priorityColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          task.category,
                          style: AppTextStyle.chip.copyWith(
                            color: task.priorityColor,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 11.sp,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          task.dueDate,
                          style: AppTextStyle.bodySmall.copyWith(fontSize: 10.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Waiting on chip
                  if (task.waitingOn.isWaiting) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSoft,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        task.waitingOn.label,
                        style: AppTextStyle.chip.copyWith(
                          color: task.waitingOn == WaitingOn.client
                              ? AppColors.warning
                              : AppColors.textSecondary,
                          fontSize: 8.5.sp,
                        ),
                      ),
                    ),
                  ],

                  // Blocked by alert
                  if (task.blockedByTaskTitle != null &&
                      task.blockedByTaskTitle!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 12.sp,
                          color: AppColors.danger,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            'Blocked by: ${task.blockedByTaskTitle}',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.danger,
                              fontSize: 9.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // Status Pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                task.status.label,
                style: AppTextStyle.chip.copyWith(
                  color: statusColor,
                  fontSize: 9.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
