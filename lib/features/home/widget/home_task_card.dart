import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

import 'home_task_chip.dart';
import 'home_task_tag.dart';

class TaskCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color checkButtonColor;
  final Color checkIconColor;
  final Color dateColor;
  final String title;
  final String description;
  final String date;
  final String moreText;
  final List<TaskTag> tags;
  final TaskStatus? status;
  final WaitingOn? waitingOn;
  final String? blockedByTaskTitle;
  final VoidCallback? onTap;
  final VoidCallback? onToggleDone;

  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.checkButtonColor,
    required this.checkIconColor,
    required this.dateColor,
    required this.title,
    required this.description,
    required this.date,
    required this.moreText,
    required this.tags,
    this.status,
    this.waitingOn,
    this.blockedByTaskTitle,
    this.onTap,
    this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: borderColor.withValues(alpha: 0.8),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowDark,
              blurRadius: 22.r,
              offset: Offset(0, 14.r),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final tag in tags.take(2))
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: TaskChip(tag: tag),
                          ),
                      ],
                    ),
                  ),
                ),
                if (status != null)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      color: status!.color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      status!.label,
                      style: TextStyle(
                        color: status!.color,
                        fontSize: 8.5.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Text(
                  date,
                  style: TextStyle(
                    color: dateColor,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      color: descriptionColor,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onToggleDone,
                  child: Container(
                    width: 40.h,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: checkButtonColor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 14.r,
                          offset: Offset(0, 8.r),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: checkIconColor,
                      size: 26.sp,
                    ),
                  ),
                ),
              ],
            ),
            if (waitingOn != null && waitingOn!.isWaiting) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: (waitingOn == WaitingOn.client
                          ? AppColors.warning
                          : AppColors.primaryLight)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  waitingOn!.label,
                  style: AppTextStyle.chip.copyWith(
                    color: waitingOn == WaitingOn.client
                        ? AppColors.warning
                        : AppColors.primaryLight,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ],
            if (blockedByTaskTitle != null &&
                blockedByTaskTitle!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14.sp,
                    color: AppColors.danger,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Blocked by: $blockedByTaskTitle',
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.5.sp,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
