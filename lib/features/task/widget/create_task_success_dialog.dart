import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/task/widget/create_task_view_content.dart';
import 'package:task_manager/generated/l10n.dart';

class CreateTaskSuccessDialog extends StatelessWidget {
  final List<String> people;
  final int? companyIndex;
  final String? serviceName;
  final String? blockedByTaskTitle;
  final DateTime? startDate;
  final DateTime? endDate;
  final PickedTime? startTime;
  final PickedTime? endTime;
  final String description;
  final List<ChecklistItem> checklist;

  const CreateTaskSuccessDialog({
    super.key,
    required this.people,
    required this.companyIndex,
    this.serviceName,
    this.blockedByTaskTitle,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.checklist,
  });

  String _formatPickedTime(PickedTime time) {
    final h = time.h.toString().padLeft(2, '0');
    final m = time.m.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final companyText = companyIndex == null ? 'None' : 'Client $companyIndex';
    final serviceText = serviceName ?? 'None';
    final blockedByText = blockedByTaskTitle ?? 'None';
    final peopleText = people.join(', ');

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 28.sp),
          SizedBox(width: 10.w),
          Text(S.of(context).taskCreated, style: AppTextStyle.titleLarge),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(S.of(context).assignedTo, peopleText),
            SizedBox(height: 8.h),
            _buildDetailRow(S.of(context).company, companyText),
            SizedBox(height: 8.h),
            _buildDetailRow(S.of(context).service, serviceText),
            SizedBox(height: 8.h),
            _buildDetailRow('Blocked by:', blockedByText),
            SizedBox(height: 8.h),
            _buildDetailRow(
              S.of(context).dateRange,
              startDate != null && endDate != null
                  ? '${startDate!.day}/${startDate!.month} - ${endDate!.day}/${endDate!.month}'
                  : 'Not set',
            ),
            SizedBox(height: 8.h),
            _buildDetailRow(
              S.of(context).timeRange,
              startTime != null && endTime != null
                  ? '${_formatPickedTime(startTime!)} - ${_formatPickedTime(endTime!)}'
                  : 'Not set',
            ),
            SizedBox(height: 8.h),
            _buildDetailRow(
              S.of(context).description,
              description.isEmpty ? 'No description' : description,
            ),
            SizedBox(height: 8.h),
            _buildDetailRow(
              S.of(context).checklist,
              checklist.isEmpty
                  ? S.of(context).noItems
                  : S.of(context).checklistSummary(
                      checklist.length,
                      checklist.where((i) => i.isDone).length,
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
            context.pop();
          },
          child: Text(
            S.of(context).done,
            style: AppTextStyle.button.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
