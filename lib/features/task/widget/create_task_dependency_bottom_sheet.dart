import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class CreateTaskDependencyBottomSheet extends StatefulWidget {
  final String? initiallySelected;

  const CreateTaskDependencyBottomSheet({
    super.key,
    required this.initiallySelected,
  });

  static Future<String?> show(
    BuildContext context,
    String? initiallySelected,
  ) {
    return showModalBottomSheet<String?>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateTaskDependencyBottomSheet(
        initiallySelected: initiallySelected,
      ),
    );
  }

  @override
  State<CreateTaskDependencyBottomSheet> createState() =>
      _CreateTaskDependencyBottomSheetState();
}

class _CreateTaskDependencyBottomSheetState
    extends State<CreateTaskDependencyBottomSheet> {
  final List<String> _availableTasks = [
    'None',
    'Content Brief Preparation',
    'Copywriting & Content Approval',
    'Backend Auth API',
    'Database Schema Migration',
    'Brand Assets Delivery',
    'Client Requirements Sign-off',
  ];

  String? _selectedTask;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedTask = widget.initiallySelected ?? 'None';
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _availableTasks
        .where((task) => task.toLowerCase().contains(_searchQuery))
        .toList();

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            // Drag handle
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Set Dependency',
                    style: AppTextStyle.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      final result =
                          _selectedTask == 'None' ? null : _selectedTask;
                      Navigator.of(context).pop(result);
                    },
                    child: Text(
                      'Done',
                      style: AppTextStyle.button
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: TextField(
                controller: _searchController,
                style: AppTextStyle.bodyLarge
                    .copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  hintStyle: AppTextStyle.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surfaceSoft,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Divider(color: AppColors.borderLight.withValues(alpha: 0.1)),
            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  final isSelected = _selectedTask == task;
                  final isNone = task == 'None';

                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    leading: CircleAvatar(
                      backgroundColor: isNone
                          ? AppColors.surfaceSoft
                          : AppColors.surfaceLight,
                      child: Icon(
                        isNone ? Icons.link_off : Icons.lock_outline_rounded,
                        size: 16.sp,
                        color: isNone ? AppColors.textMuted : AppColors.danger,
                      ),
                    ),
                    title: Text(
                      task,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: isNone
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: AppColors.primary)
                        : const Icon(Icons.circle_outlined,
                            color: AppColors.border),
                    onTap: () {
                      setState(() => _selectedTask = task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
