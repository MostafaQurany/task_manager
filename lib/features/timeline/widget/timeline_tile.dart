import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';

class TimelineTile extends StatelessWidget {
  final TimelineItemModel item;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onToggleComplete;
  final VoidCallback? onDelete;

  const TimelineTile({
    super.key,
    required this.item,
    this.isFirst = false,
    this.isLast = false,
    required this.onToggleComplete,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isInProgress = item.status == TaskStatus.inProgress && !item.isCompleted;

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        HapticFeedback.mediumImpact();
        if (direction == DismissDirection.startToEnd) {
          // Toggle completion
          onToggleComplete();
          return false; // Don't remove tile, just toggle
        } else {
          // Delete / Remove
          if (onDelete != null) {
            onDelete!();
            return true;
          }
          return false;
        }
      },
      background: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.5)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.success, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              item.isCompleted ? 'Mark Active' : 'Mark Complete',
              style: AppTextStyle.titleSmall.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.danger.withValues(alpha: 0.5)),
        ),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Remove Task',
              style: AppTextStyle.titleSmall.copyWith(
                color: AppColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.delete_outline_rounded, color: AppColors.danger, size: 24.sp),
          ],
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Time column
            SizedBox(
              width: 72.w,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.time,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 10.5.sp,
                      ),
                    ),
                    Text(
                      item.endTime,
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                        fontSize: 9.5.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSoft,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        item.duration,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 8.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Timeline node & connecting track
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onToggleComplete();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 18.r,
                    height: 18.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.isCompleted
                          ? AppColors.primary
                          : isInProgress
                              ? AppColors.primary.withValues(alpha: 0.2)
                              : AppColors.surfaceCard,
                      border: Border.all(
                        color: item.isCompleted
                            ? AppColors.primary
                            : isInProgress
                                ? AppColors.primary
                                : AppColors.border,
                        width: isInProgress ? 2.5 : 1.5,
                      ),
                      boxShadow: (item.isCompleted || isInProgress)
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.35),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: item.isCompleted
                          ? Icon(
                              Icons.check,
                              size: 11.sp,
                              color: AppColors.textDark,
                            )
                          : isInProgress
                              ? Container(
                                  width: 6.r,
                                  height: 6.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                )
                              : null,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            item.isCompleted
                                ? AppColors.primary.withValues(alpha: 0.6)
                                : Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.08),
                          ],
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                    ),
                  ),
              ],
            ),

            SizedBox(width: 12.w),

            // 3. Task content card
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      RoutesName.taskDetailScreen,
                      extra: item.toUserTaskModel(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isInProgress
                            ? AppColors.primary.withValues(alpha: 0.35)
                            : item.isCompleted
                                ? Colors.white.withValues(alpha: 0.04)
                                : Colors.white.withValues(alpha: 0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Category Tag + Status Pill
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: item.tagColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                item.category,
                                style: AppTextStyle.chip.copyWith(
                                  color: item.tagColor,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            _buildStatusPill(context, item.status, item.isCompleted),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        // Row 2: Title
                        Text(
                          item.title,
                          style: AppTextStyle.titleSmall.copyWith(
                            color: item.isCompleted
                                ? AppColors.textSecondary
                                : Colors.white,
                            fontSize: 13.5.sp,
                            decoration: item.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            decorationColor: AppColors.textSecondary,
                          ),
                        ),

                        // Row 3: Client & Service Subtitle
                        if (item.clientName != null || item.serviceName != null) ...[
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.business_rounded,
                                size: 12.sp,
                                color: AppColors.textMuted,
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  [item.clientName, item.serviceName]
                                      .whereType<String>()
                                      .join(' • '),
                                  style: AppTextStyle.bodySmall.copyWith(
                                    color: AppColors.primaryLight.withValues(alpha: 0.9),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Row 4: Delay Attribution / Blocked Warning
                        if (item.blockedByTaskTitle != null &&
                            item.blockedByTaskTitle!.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.danger.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.block, size: 10.sp, color: AppColors.danger),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: Text(
                                    'Blocked by: ${item.blockedByTaskTitle}',
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: AppColors.danger,
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (item.waitingOn != WaitingOn.none) ...[
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.hourglass_top_rounded,
                                    size: 10.sp, color: AppColors.warning),
                                SizedBox(width: 4.w),
                                Text(
                                  item.waitingOn == WaitingOn.client
                                      ? 'Waiting on Client'
                                      : 'Waiting on Team',
                                  style: AppTextStyle.bodySmall.copyWith(
                                    color: AppColors.warning,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Row 5: Metadata Footer (Comments & Versions counts)
                        if (item.comments.isNotEmpty || item.versions.isNotEmpty) ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              if (item.comments.isNotEmpty) ...[
                                Icon(
                                  Icons.chat_bubble_outline_rounded,
                                  size: 11.sp,
                                  color: AppColors.textMuted,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  '${item.comments.length}',
                                  style: AppTextStyle.bodySmall.copyWith(
                                    fontSize: 9.5.sp,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                              ],
                              if (item.versions.isNotEmpty) ...[
                                Icon(
                                  Icons.history_rounded,
                                  size: 11.sp,
                                  color: AppColors.textMuted,
                                ),
                                SizedBox(width: 3.w),
                                Text(
                                  'v${item.versions.last.versionNumber}',
                                  style: AppTextStyle.bodySmall.copyWith(
                                    fontSize: 9.5.sp,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPill(BuildContext context, TaskStatus status, bool isDone) {
    if (isDone) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline_rounded,
                size: 10.sp, color: AppColors.success),
            SizedBox(width: 3.w),
            Text(
              'Done',
              style: AppTextStyle.chip.copyWith(
                color: AppColors.success,
                fontSize: 8.5.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    Color color;
    String label;
    IconData icon;

    switch (status) {
      case TaskStatus.inProgress:
        color = AppColors.primary;
        label = 'In Progress';
        icon = Icons.play_arrow_rounded;
        break;
      case TaskStatus.readyToStart:
        color = const Color(0xFF8CE8FF);
        label = 'Ready';
        icon = Icons.flag_rounded;
        break;
      case TaskStatus.internalReview:
        color = AppColors.warning;
        label = 'Internal Review';
        icon = Icons.rate_review_rounded;
        break;
      case TaskStatus.clientReview:
      case TaskStatus.readyForClientReview:
        color = AppColors.warning;
        label = 'Client Review';
        icon = Icons.remove_red_eye_rounded;
        break;
      case TaskStatus.revisionRequestedClient:
      case TaskStatus.revisionRequestedInternal:
        color = AppColors.danger;
        label = 'Revision';
        icon = Icons.replay_rounded;
        break;
      case TaskStatus.approved:
        color = AppColors.activeDot;
        label = 'Approved';
        icon = Icons.verified_rounded;
        break;
      case TaskStatus.completed:
        color = AppColors.success;
        label = 'Completed';
        icon = Icons.check_circle_rounded;
        break;
      default:
        color = AppColors.textMuted;
        label = 'To Do';
        icon = Icons.schedule_rounded;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10.sp, color: color),
          SizedBox(width: 3.w),
          Text(
            label,
            style: AppTextStyle.chip.copyWith(
              color: color,
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
