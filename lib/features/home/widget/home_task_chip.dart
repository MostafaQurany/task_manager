import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

import 'home_task_tag.dart';

class TaskChip extends StatelessWidget {
  final TaskTag tag;

  const TaskChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: tag.backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Center(
        child: Text(
          tag.text,
          style: TextStyle(
            color: tag.textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
