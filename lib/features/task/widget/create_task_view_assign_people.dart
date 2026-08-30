import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/task/widget/create_task_assign_people_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class CreateTaskViewAssignPeople extends StatefulWidget {
  final ValueChanged<List<String>>? onChanged;
  const CreateTaskViewAssignPeople({super.key, this.onChanged});

  @override
  State<CreateTaskViewAssignPeople> createState() =>
      CreateTaskViewAssignPeopleState();
}

class CreateTaskViewAssignPeopleState
    extends State<CreateTaskViewAssignPeople> {
  List<String> _selectedPeople = [];

  List<String> get selectedPeople => List.unmodifiable(_selectedPeople);
  List<String> get assignedPeople =>
      _selectedPeople.isEmpty ? const ['Just Me'] : List.unmodifiable(_selectedPeople);

  Future<void> _openBottomSheet() async {
    final result = await CreateTaskAssignPeopleBottomSheet.show(
      context,
      _selectedPeople,
    );
    if (result != null) {
      setState(() {
        _selectedPeople = result;
      });
      widget.onChanged?.call(_selectedPeople);
    }
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
            child: _selectedPeople.isEmpty
                ? _buildEmptyState()
                : _buildSelectedState(),
          ),
          GestureDetector(
            onTap: _openBottomSheet,
            child: Row(
              children: [
                Icon(Icons.add, color: AppColors.primary, size: 18.sp),
                SizedBox(width: 4.w),
                Text(
                  'Add',
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
        Icon(Icons.people_outline, color: AppColors.textSecondary, size: 24.sp),
        SizedBox(width: 12.w),
        Text(
          'No people assigned',
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedState() {
    final displayCount = _selectedPeople.length > 3
        ? 3
        : _selectedPeople.length;
    final extraCount = _selectedPeople.length - displayCount;
    final displayNames = _selectedPeople.take(displayCount).join(', ');

    return Row(
      children: [
        Row(
          children: [
            for (var i = 0; i < displayCount; i++)
              Align(
                widthFactor: 0.7,
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.surfaceSoft,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppColors.primary,
                    child: CircleAvatar(
                      radius: 12.5.r,
                      backgroundColor: AppColors.surfaceLight,
                      child: Text(
                        _selectedPeople[i][0],
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (extraCount > 0)
              Align(
                widthFactor: 0.7,
                child: CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColors.surfaceSoft,
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      '+$extraCount',
                      style: AppTextStyle.bodySmall.copyWith(
                        color: AppColors.backgroundDeep,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            displayNames,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textPrimary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
