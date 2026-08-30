import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

enum TimelineViewMode {
  daily,
  weekly,
  agenda,
}

class TimelineFilterBar extends StatelessWidget {
  final TimelineViewMode viewMode;
  final Function(TimelineViewMode) onViewModeChanged;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<String> categories;
  final bool hideCompleted;
  final VoidCallback onToggleHideCompleted;
  final int totalCount;
  final int completedCount;

  const TimelineFilterBar({
    super.key,
    required this.viewMode,
    required this.onViewModeChanged,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
    required this.hideCompleted,
    required this.onToggleHideCompleted,
    required this.totalCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // View Mode Segmented Bar & Hide Completed Toggle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mode Tabs (Daily, Weekly, Agenda)
            Flexible(
              child: Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildModeSegment(
                      mode: TimelineViewMode.daily,
                      label: 'Daily',
                      icon: Icons.view_day_rounded,
                    ),
                    _buildModeSegment(
                      mode: TimelineViewMode.weekly,
                      label: 'Weekly',
                      icon: Icons.view_week_rounded,
                    ),
                    _buildModeSegment(
                      mode: TimelineViewMode.agenda,
                      label: 'Agenda',
                      icon: Icons.format_list_bulleted_rounded,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 6.w),

            // Hide completed pill button
            GestureDetector(
              onTap: onToggleHideCompleted,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: hideCompleted
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: hideCompleted
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hideCompleted
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: 13.sp,
                      color: hideCompleted
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      hideCompleted ? 'Active' : 'All',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: hideCompleted
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Horizontal Category Chips & Progress Stats
        Row(
          children: [
            // Category horizontal scroll
            Expanded(
              child: SizedBox(
                height: 32.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 6.w),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = cat == selectedCategory;
                    return GestureDetector(
                      onTap: () => onCategorySelected(cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surfaceSoft.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: AppTextStyle.bodySmall.copyWith(
                              color: isSelected
                                  ? AppColors.textDark
                                  : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                              fontSize: 10.5.sp,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // Daily Progress Pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '$completedCount/$totalCount Done',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.activeDot,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildModeSegment({
    required TimelineViewMode mode,
    required String label,
    required IconData icon,
  }) {
    final isSelected = viewMode == mode;
    return GestureDetector(
      onTap: () => onViewModeChanged(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12.sp,
              color: isSelected ? AppColors.textDark : AppColors.textSecondary,
            ),
            SizedBox(width: 3.w),
            Text(
              label,
              style: AppTextStyle.bodySmall.copyWith(
                color: isSelected ? AppColors.textDark : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                fontSize: 10.5.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
