import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class TaskSummary extends StatelessWidget {
  const TaskSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: 'You have got ',
        style: TextStyle(color: AppColors.textPrimary, fontSize: 28.sp),
        children: [
          TextSpan(
            text: '4 Tasks \n',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'today ',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'to complete👋',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 28.sp),
          ),
        ],
      ),
    );
  }
}
