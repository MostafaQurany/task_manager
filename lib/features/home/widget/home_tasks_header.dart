import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

import '../view/home_view.dart';
import 'home_filter_button.dart';

class TasksHeader extends StatelessWidget {
  final ValueNotifier<TaskFilter> selectedFilter;

  const TasksHeader({super.key, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'My ',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<TaskFilter>(
          valueListenable: selectedFilter,
          builder: (context, value, _) {
            return Container(
              height: 60.h,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF3C4050).withValues(alpha: 0.80),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilterButton(
                    title: 'Active',
                    value: TaskFilter.active,
                    selectedFilter: value,
                    showDot: true,
                    onSelected: (filter) => selectedFilter.value = filter,
                  ),
                  FilterButton(
                    title: 'Done',
                    value: TaskFilter.done,
                    selectedFilter: value,
                    onSelected: (filter) => selectedFilter.value = filter,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
