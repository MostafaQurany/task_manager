import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';

class TimelineWeeklyView extends StatelessWidget {
  final List<TimelineItemModel> allItems;
  final DateTime selectedDate;
  final Function(DateTime) onSelectDay;
  final Function(TimelineItemModel) onToggleComplete;

  const TimelineWeeklyView({
    super.key,
    required this.allItems,
    required this.selectedDate,
    required this.onSelectDay,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the start of the week for the selectedDate (e.g. Monday)
    final monday = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final weekDays = List.generate(7, (i) => DateTime(monday.year, monday.month, monday.day + i));

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final day = weekDays[index];
          final dayItems = allItems.where((item) => DateUtils.isSameDay(item.date, day)).toList();
          final isToday = DateUtils.isSameDay(day, DateTime.now());
          final completed = dayItems.where((t) => t.isCompleted).length;
          final total = dayItems.length;
          final progress = total > 0 ? (completed / total) : 0.0;

          return Container(
            margin: EdgeInsets.only(bottom: 14.h),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.surfaceCard,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isToday
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.08),
                width: isToday ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isToday ? AppColors.primary : AppColors.surfaceSoft,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            DateFormat('EEEE, d MMM').format(day),
                            style: AppTextStyle.titleSmall.copyWith(
                              color: isToday ? AppColors.textDark : Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (isToday) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'TODAY',
                              style: AppTextStyle.bodySmall.copyWith(
                                color: AppColors.primary,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    // Action: Jump to this day in daily view
                    GestureDetector(
                      onTap: () => onSelectDay(day),
                      child: Row(
                        children: [
                          Text(
                            '$completed/$total Done',
                            style: AppTextStyle.bodySmall.copyWith(
                              color: completed == total && total > 0
                                  ? AppColors.activeDot
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 11.sp,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Weekly Day Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.surfaceSoft,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? AppColors.activeDot : AppColors.primary,
                    ),
                    minHeight: 4.h,
                  ),
                ),

                SizedBox(height: 10.h),

                // Sub-tasks for this day
                if (dayItems.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      'No tasks scheduled for this day.',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                else
                  ...dayItems.map((item) => GestureDetector(
                        onTap: () {
                          context.push(
                            RoutesName.taskDetailScreen,
                            extra: item.toUserTaskModel(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSoft.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.04),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => onToggleComplete(item),
                                child: Container(
                                  width: 16.r,
                                  height: 16.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: item.isCompleted
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: item.isCompleted
                                          ? AppColors.primary
                                          : AppColors.border,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: item.isCompleted
                                      ? Icon(
                                          Icons.check,
                                          size: 10.sp,
                                          color: AppColors.textDark,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: AppTextStyle.bodyMedium.copyWith(
                                    color: item.isCompleted
                                        ? AppColors.textMuted
                                        : Colors.white,
                                    fontSize: 12.sp,
                                    decoration: item.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                item.time,
                                style: AppTextStyle.bodySmall.copyWith(
                                  fontSize: 9.5.sp,
                                  color: AppColors.primaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
              ],
            ),
          );
        },
        childCount: 7,
      ),
    );
  }
}
