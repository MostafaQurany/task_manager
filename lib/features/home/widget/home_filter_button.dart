import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class FilterButton<T> extends StatelessWidget {
  final String title;
  final T value;
  final T selectedFilter;
  final bool showDot;
  final ValueChanged<T> onSelected;

  const FilterButton({
    super.key,
    required this.title,
    required this.value,
    required this.selectedFilter,
    required this.onSelected,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedFilter == value;

    return GestureDetector(
      onTap: () => onSelected(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 10.r,
                    offset: Offset(0, 4.r),
                  ),
                ]
              : const [],
        ),
        child: Row(
          children: [
            if (showDot) ...[
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.activeDot,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.filterTextSelected
                    : AppColors.filterTextUnselected,
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
