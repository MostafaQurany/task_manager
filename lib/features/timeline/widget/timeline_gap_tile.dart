import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TimelineGapTile extends StatelessWidget {
  final String timeRange; // e.g. "11:15 AM - 01:30 PM"
  final String duration; // e.g. "2 hrs 15 mins"

  const TimelineGapTile({
    super.key,
    required this.timeRange,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Time column placeholder
          SizedBox(
            width: 72.w,
            child: Text(
              timeRange.split('-').first.trim(),
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textMuted.withValues(alpha: 0.6),
                fontSize: 9.sp,
              ),
            ),
          ),

          // Dashed / Dotted Track Line
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
              Container(
                width: 1.5,
                height: 24.h,
                color: Colors.white.withValues(alpha: 0.08),
                margin: EdgeInsets.symmetric(vertical: 2.h),
              ),
              Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),

          SizedBox(width: 12.w),

          // Free Time Card
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.04),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.coffee_rounded,
                          size: 13.sp,
                          color: AppColors.primaryLight.withValues(alpha: 0.8),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            'Free Time • $duration',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textSecondary.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () => context.push(RoutesName.createTaskScreen),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            size: 11.sp,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Schedule',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
