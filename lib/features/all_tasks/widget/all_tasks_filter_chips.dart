import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class AllTasksFilterChips extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onFilterSelected;

  const AllTasksFilterChips({
    super.key,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      S.of(context).filterToday,
      S.of(context).filterReadyToStart,
      S.of(context).filterInProgress,
      S.of(context).filterBlocked,
      S.of(context).filterRevisions,
      S.of(context).filterWaitingReview,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onFilterSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  filters[index],
                  style: AppTextStyle.bodySmall.copyWith(
                    color: isSelected
                        ? AppColors.textDark
                        : Colors.white,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
