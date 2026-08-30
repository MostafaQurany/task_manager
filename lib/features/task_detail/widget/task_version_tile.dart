import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskVersionTile extends StatelessWidget {
  final TaskVersionModel version;
  final bool isLast;

  const TaskVersionTile({
    super.key,
    required this.version,
    required this.isLast,
  });

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline node + connector
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: version.approved
                      ? AppColors.primary
                      : AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: version.approved
                        ? AppColors.primary
                        : AppColors.border,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  'v${version.versionNumber}',
                  style: AppTextStyle.chip.copyWith(
                    color: version.approved
                        ? AppColors.textDark
                        : AppColors.textPrimary,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: Colors.white.withValues(alpha: 0.12),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),

          // Content Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: version.approved
                        ? AppColors.primary.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          version.uploadedBy,
                          style: AppTextStyle.titleSmall.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (version.approved)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.activeDot.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 10.sp,
                                  color: AppColors.activeDot,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'Approved',
                                  style: AppTextStyle.chip.copyWith(
                                    color: AppColors.activeDot,
                                    fontSize: 8.5.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Text(
                            _formatDate(version.uploadedAt),
                            style: AppTextStyle.bodySmall.copyWith(
                              color: AppColors.textMuted,
                              fontSize: 9.5.sp,
                            ),
                          ),
                      ],
                    ),
                    if (version.revisionNote != null &&
                        version.revisionNote!.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        version.revisionNote!,
                        style: AppTextStyle.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 11.5.sp,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
