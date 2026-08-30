import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskDetailHeader extends StatelessWidget {
  final String title;
  final String? clientName;
  final String? serviceName;
  final TaskStatus status;

  const TaskDetailHeader({
    super.key,
    required this.title,
    this.clientName,
    this.serviceName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleParts = [
      if (clientName != null && clientName!.isNotEmpty) clientName!,
      if (serviceName != null && serviceName!.isNotEmpty) serviceName!,
    ];
    final subtitle = subtitleParts.join(' • ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),

            // Status Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: status.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: status.color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(status.icon, size: 12.sp, color: status.color),
                  SizedBox(width: 5.w),
                  Text(
                    status.label,
                    style: AppTextStyle.chip.copyWith(
                      color: status.color,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Task Title
        Text(
          title,
          style: AppTextStyle.headlineMedium.copyWith(
            color: Colors.white,
            fontSize: 22.sp,
          ),
        ),

        if (subtitle.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ],
    );
  }
}
