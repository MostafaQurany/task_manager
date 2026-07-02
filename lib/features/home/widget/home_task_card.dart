import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

import 'home_task_chip.dart';
import 'home_task_tag.dart';

class TaskCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color checkButtonColor;
  final Color checkIconColor;
  final Color dateColor;
  final String title;
  final String description;
  final String date;
  final String moreText;
  final List<TaskTag> tags;

  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.checkButtonColor,
    required this.checkIconColor,
    required this.dateColor,
    required this.title,
    required this.description,
    required this.date,
    required this.moreText,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(42),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final tag in tags.take(2))
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TaskChip(tag: tag),
                        ),
                    ],
                  ),
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: dateColor,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: TextStyle(
              color: descriptionColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              const Spacer(),
              Container(
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                  color: checkButtonColor,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 14.r,
                      offset: Offset(0, 8.r),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: checkIconColor,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
