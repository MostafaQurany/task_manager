import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskCommentTile extends StatelessWidget {
  final CommentModel comment;

  const TaskCommentTile({
    super.key,
    required this.comment,
  });

  String _formatTimestamp(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${dt.day}/${dt.month}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: comment.isClientVisible
                    ? AppColors.primaryLight.withValues(alpha: 0.2)
                    : AppColors.warning.withValues(alpha: 0.2),
                child: Text(
                  comment.authorName.isNotEmpty
                      ? comment.authorName[0].toUpperCase()
                      : '?',
                  style: AppTextStyle.bodySmall.copyWith(
                    color: comment.isClientVisible
                        ? AppColors.primary
                        : AppColors.warning,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  comment.authorName,
                  style: AppTextStyle.titleSmall.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: (comment.isClientVisible
                          ? AppColors.primary
                          : AppColors.warning)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  comment.isClientVisible ? 'Client' : 'Internal',
                  style: AppTextStyle.chip.copyWith(
                    color: comment.isClientVisible
                        ? AppColors.primary
                        : AppColors.warning,
                    fontSize: 8.5.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                _formatTimestamp(comment.createdAt),
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 9.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            comment.body,
            style: AppTextStyle.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12.sp,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
