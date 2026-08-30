import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'task_version_tile.dart';

class TaskVersionHistory extends StatelessWidget {
  final List<TaskVersionModel> versions;

  const TaskVersionHistory({
    super.key,
    required this.versions,
  });

  @override
  Widget build(BuildContext context) {
    if (versions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Version History',
              style: AppTextStyle.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${versions.length} versions',
                style: AppTextStyle.chip.copyWith(
                  color: AppColors.primary,
                  fontSize: 9.5.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        ...List.generate(versions.length, (index) {
          return TaskVersionTile(
            version: versions[index],
            isLast: index == versions.length - 1,
          );
        }),
      ],
    );
  }
}
