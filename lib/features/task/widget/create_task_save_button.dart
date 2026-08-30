import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class CreateTaskSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateTaskSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.backgroundDeep,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_task_rounded,
              size: 22.sp,
              color: AppColors.whiteCard,
            ),
            SizedBox(width: 10.w),
            Text(
              S.of(context).saveTask,
              style: AppTextStyle.button.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.whiteCard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
