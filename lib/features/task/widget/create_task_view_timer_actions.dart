import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class CreateTaskViewTimerActions extends StatelessWidget {
  final VoidCallback onShowDatePicker;
  final VoidCallback onShowTimePicker;

  const CreateTaskViewTimerActions({
    super.key,
    required this.onShowDatePicker,
    required this.onShowTimePicker,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5.h,
        children: [
          GestureDetector(
            onTap: () {
              _triggerHapticFeedback();
              onShowDatePicker();
            },
            child: Container(
              height: 120.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.date_range,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ),
          ),
          Container(
            height: 2.h,
            width: 50.w,
            color: AppColors.borderLight.withValues(alpha: 0.1),
          ),
          GestureDetector(
            onTap: () {
              _triggerHapticFeedback();
              onShowTimePicker();
            },
            child: Container(
              height: 120.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                border: Border.all(
                  color: AppColors.borderLight.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.schedule,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }
}
