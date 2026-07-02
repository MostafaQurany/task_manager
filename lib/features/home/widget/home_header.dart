import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 32.r,
          child: Icon(Icons.person, size: 32.r),
        ),
        SizedBox(width: 16.w),
        Text(
          "Hey Jammy!",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surfaceCard,
            foregroundColor: AppColors.borderLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          ),
          child: Row(
            children: [
              Text(
                "add Task",
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
              Icon(Icons.add, color: Colors.white, size: 18.r),
            ],
          ),
        ),
      ],
    );
  }
}
