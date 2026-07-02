import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

import '../view/home_view.dart';

class FilterButton extends StatelessWidget {
  final String title;
  final TaskFilter value;
  final TaskFilter selectedFilter;
  final bool showDot;
  final ValueChanged<TaskFilter> onSelected;

  const FilterButton({
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
                    color: Colors.black.withValues(alpha: 0.18),
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
                  color: Color(0xFF9DFF8F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color.fromARGB(255, 103, 103, 104)
                    : Colors.white.withValues(alpha: 0.55),
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
