import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TaskStatusStepper extends StatelessWidget {
  final TaskStatus currentStatus;

  const TaskStatusStepper({
    super.key,
    required this.currentStatus,
  });

  static const List<String> _stages = [
    'To Do',
    'In Progress',
    'Internal Review',
    'Client Review',
    'Approved',
  ];

  int _getCurrentStageIndex() {
    switch (currentStatus) {
      case TaskStatus.toDo:
      case TaskStatus.readyToStart:
        return 0;
      case TaskStatus.inProgress:
        return 1;
      case TaskStatus.internalReview:
      case TaskStatus.revisionRequestedInternal:
        return 2;
      case TaskStatus.readyForClientReview:
      case TaskStatus.clientReview:
      case TaskStatus.revisionRequestedClient:
        return 3;
      case TaskStatus.approved:
      case TaskStatus.completed:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeIndex = _getCurrentStageIndex();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Workflow Progress',
                style: AppTextStyle.titleSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                '${activeIndex + 1} of ${_stages.length}',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_stages.length, (index) {
                final isPassed = index < activeIndex;
                final isCurrent = index == activeIndex;

                return Row(
                  children: [
                    Column(
                      children: [
                        // Node circle
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPassed
                                ? AppColors.primary
                                : isCurrent
                                    ? AppColors.primaryLight
                                    : AppColors.surfaceSoft,
                            border: Border.all(
                              color: isPassed || isCurrent
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: isCurrent ? 2.5 : 1.5,
                            ),
                            boxShadow: isCurrent
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.5),
                                      blurRadius: 10.r,
                                      spreadRadius: 2.r,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: isPassed
                                ? Icon(
                                    Icons.check,
                                    size: 12.sp,
                                    color: AppColors.textDark,
                                  )
                                : isCurrent
                                    ? Container(
                                        width: 8.r,
                                        height: 8.r,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.textDark,
                                        ),
                                      )
                                    : Text(
                                        '${index + 1}',
                                        style: AppTextStyle.chip.copyWith(
                                          color: AppColors.textMuted,
                                          fontSize: 9.sp,
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        // Stage Label
                        Text(
                          _stages[index],
                          style: AppTextStyle.bodySmall.copyWith(
                            color: isCurrent
                                ? Colors.white
                                : isPassed
                                    ? AppColors.textSecondary
                                    : AppColors.textMuted,
                            fontWeight: isCurrent
                                ? FontWeight.w700
                                : isPassed
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                            fontSize: 9.5.sp,
                          ),
                        ),
                      ],
                    ),
                    if (index < _stages.length - 1)
                      Container(
                        width: 24.w,
                        height: 2.h,
                        margin: EdgeInsets.only(
                          bottom: 18.h,
                          left: 4.w,
                          right: 4.w,
                        ),
                        decoration: BoxDecoration(
                          color: index < activeIndex
                              ? AppColors.primary
                              : Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
