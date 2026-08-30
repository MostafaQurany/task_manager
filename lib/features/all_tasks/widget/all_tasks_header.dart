import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class AllTasksHeader extends StatelessWidget {
  final int activeCount;
  final int completedCount;

  const AllTasksHeader({
    super.key,
    required this.activeCount,
    required this.completedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).allTasksTitle,
              style: AppTextStyle.headlineMedium.copyWith(
                color: Colors.white,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${S.of(context).activeCount(activeCount)} · ${S.of(context).completedCount(completedCount)}',
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: AppColors.surfaceCard,
          radius: 22.r,
          child: Icon(
            Icons.filter_list_rounded,
            size: 22.r,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
