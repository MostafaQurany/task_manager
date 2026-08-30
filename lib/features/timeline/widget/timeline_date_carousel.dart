import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TimelineDateCarousel extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final Set<String> datesWithTasks; // Format 'yyyy-MM-dd'

  const TimelineDateCarousel({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.datesWithTasks,
  });

  @override
  State<TimelineDateCarousel> createState() => _TimelineDateCarouselState();
}

class _TimelineDateCarouselState extends State<TimelineDateCarousel> {
  late final ScrollController _scrollController;
  late final List<DateTime> _dates;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Generate dates: 7 days before today to 14 days after today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _dates = List.generate(22, (i) => today.subtract(const Duration(days: 7)).add(Duration(days: i)));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void didUpdateWidget(TimelineDateCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!DateUtils.isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      _scrollToSelectedDate();
    }
  }

  void _scrollToSelectedDate() {
    if (!_scrollController.hasClients) return;
    final index = _dates.indexWhere((d) => DateUtils.isSameDay(d, widget.selectedDate));
    if (index != -1) {
      final itemWidth = 58.w;
      final targetOffset = (index * itemWidth) - (140.w);
      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(widget.selectedDate, now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Action & Quick Today Jump
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(widget.selectedDate),
                style: AppTextStyle.titleSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                ),
              ),
              if (!isToday)
                GestureDetector(
                  onTap: () => widget.onDateSelected(now),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.replay_rounded,
                          size: 12.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Jump to Today',
                          style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        // Horizontal Dates List
        SizedBox(
          height: 74.h,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _dates.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final date = _dates[index];
              final isSelected = DateUtils.isSameDay(date, widget.selectedDate);
              final isCurrentDay = DateUtils.isSameDay(date, now);
              final dateKey = DateFormat('yyyy-MM-dd').format(date);
              final hasTasks = widget.datesWithTasks.contains(dateKey);

              return GestureDetector(
                onTap: () => widget.onDateSelected(date),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : isCurrentDay
                            ? AppColors.surfaceCard
                            : AppColors.surfaceSoft.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : isCurrentDay
                              ? AppColors.primary.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.08),
                      width: isSelected || isCurrentDay ? 1.5 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date).toUpperCase(),
                        style: AppTextStyle.bodySmall.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppColors.textDark
                              : AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${date.day}',
                        style: AppTextStyle.titleMedium.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? AppColors.textDark
                              : Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Dot indicator for days with tasks
                      Container(
                        width: 5.r,
                        height: 5.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.textDark
                              : hasTasks
                                  ? AppColors.primary
                                  : Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
