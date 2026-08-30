import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';
import 'package:task_manager/features/all_tasks/widget/all_tasks_card.dart';

class AllTasksList extends StatelessWidget {
  final List<UserTaskModel> tasks;
  final ValueChanged<UserTaskModel> onToggleTask;
  final ValueChanged<UserTaskModel>? onTaskTap;

  const AllTasksList({
    super.key,
    required this.tasks,
    required this.onToggleTask,
    this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: tasks.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return AllTasksCard(
          task: task,
          onToggleDone: () => onToggleTask(task),
          onTap: () => onTaskTap?.call(task),
        );
      },
    );
  }
}
