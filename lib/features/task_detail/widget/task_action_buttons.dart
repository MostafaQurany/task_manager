import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskActionButtons extends StatelessWidget {
  final TaskStatus status;
  final ValueChanged<TaskStatus>? onStatusChanged;

  const TaskActionButtons({
    super.key,
    required this.status,
    this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case TaskStatus.toDo:
      case TaskStatus.readyToStart:
        return _buildPrimaryButton(
          title: 'Start Working',
          icon: Icons.play_arrow_rounded,
          onTap: () => onStatusChanged?.call(TaskStatus.inProgress),
        );

      case TaskStatus.inProgress:
        return _buildPrimaryButton(
          title: 'Submit for Internal Review',
          icon: Icons.send_rounded,
          onTap: () => onStatusChanged?.call(TaskStatus.internalReview),
        );

      case TaskStatus.internalReview:
        return Column(
          children: [
            _buildPrimaryButton(
              title: 'Approve & Send to Client',
              icon: Icons.check_circle_outline_rounded,
              onTap: () => onStatusChanged?.call(TaskStatus.clientReview),
            ),
            SizedBox(height: 10.h),
            _buildSecondaryButton(
              title: 'Request Internal Revision',
              icon: Icons.replay_rounded,
              onTap: () =>
                  onStatusChanged?.call(TaskStatus.revisionRequestedInternal),
            ),
          ],
        );

      case TaskStatus.clientReview:
      case TaskStatus.readyForClientReview:
        return Column(
          children: [
            _buildPrimaryButton(
              title: 'Client Approved',
              icon: Icons.verified_rounded,
              onTap: () => onStatusChanged?.call(TaskStatus.approved),
            ),
            SizedBox(height: 10.h),
            _buildSecondaryButton(
              title: 'Client Requested Revision',
              icon: Icons.replay_rounded,
              onTap: () =>
                  onStatusChanged?.call(TaskStatus.revisionRequestedClient),
            ),
          ],
        );

      case TaskStatus.revisionRequestedInternal:
      case TaskStatus.revisionRequestedClient:
        return _buildPrimaryButton(
          title: 'Submit New Version',
          icon: Icons.upload_file_rounded,
          onTap: () => onStatusChanged?.call(TaskStatus.internalReview),
        );

      case TaskStatus.approved:
        return _buildPrimaryButton(
          title: 'Mark as Completed',
          icon: Icons.task_alt_rounded,
          onTap: () => onStatusChanged?.call(TaskStatus.completed),
        );

      case TaskStatus.completed:
        return Container(
          width: double.infinity,
          height: 54.h,
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Deliverable Completed & Counted',
                  style: AppTextStyle.button.copyWith(
                    color: AppColors.success,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildPrimaryButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 16.r,
              offset: Offset(0, 6.r),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.textDark, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTextStyle.button.copyWith(
                  color: AppColors.textDark,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.warning, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppTextStyle.button.copyWith(
                  color: Colors.white,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
