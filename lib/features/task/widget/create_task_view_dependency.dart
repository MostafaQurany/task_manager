import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'create_task_dependency_bottom_sheet.dart';

class CreateTaskViewDependency extends StatefulWidget {
  final ValueChanged<String?>? onChanged;

  const CreateTaskViewDependency({super.key, this.onChanged});

  @override
  State<CreateTaskViewDependency> createState() =>
      CreateTaskViewDependencyState();
}

class CreateTaskViewDependencyState extends State<CreateTaskViewDependency> {
  String? _blockedByTaskTitle;

  String? get blockedByTaskTitle => _blockedByTaskTitle;

  Future<void> _openBottomSheet() async {
    final result = await CreateTaskDependencyBottomSheet.show(
      context,
      _blockedByTaskTitle,
    );
    setState(() {
      _blockedByTaskTitle = result;
    });
    widget.onChanged?.call(_blockedByTaskTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _blockedByTaskTitle == null
                ? _buildEmptyState()
                : _buildSelectedState(),
          ),
          GestureDetector(
            onTap: _openBottomSheet,
            child: Row(
              children: [
                Icon(
                  _blockedByTaskTitle == null ? Icons.add : Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  _blockedByTaskTitle == null ? 'Add' : 'Change',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Row(
      children: [
        Icon(
          Icons.link_off,
          color: AppColors.textSecondary,
          size: 22.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          'No dependency',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedState() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            color: AppColors.danger,
            size: 16.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            'Blocked by: $_blockedByTaskTitle',
            style: AppTextStyle.bodyMedium.copyWith(
              color: AppColors.danger,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
