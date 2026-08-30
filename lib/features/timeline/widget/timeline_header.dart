import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class TimelineHeader extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onOpenCalendar;

  const TimelineHeader({
    super.key,
    required this.selectedDate,
    required this.onOpenCalendar,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
    final dateFormatted = isToday
        ? 'Today, ${DateFormat('d MMMM').format(selectedDate)}'
        : DateFormat('EEEE, d MMMM').format(selectedDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title & Selected Date Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).dailyTimeline,
                style: AppTextStyle.headlineMedium.copyWith(
                  color: Colors.white,
                  fontSize: 22.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                dateFormatted,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),

        // Action Icons: Calendar Sheet Trigger + Quick Add Task Button
        Row(
          children: [
            // Calendar icon pill
            GestureDetector(
              onTap: onOpenCalendar,
              child: Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  size: 20.sp,
                  color: AppColors.primary,
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // Add Task button
            GestureDetector(
              onTap: () => context.push(RoutesName.createTaskScreen),
              child: Container(
                height: 42.r,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(21.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 18.sp,
                      color: AppColors.textDark,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'New Task',
                      style: AppTextStyle.button.copyWith(
                        color: AppColors.textDark,
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
