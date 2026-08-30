import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/task/view/create_task_view.dart';
import 'package:task_manager/generated/l10n.dart';

class CreateTaskViewHeader extends StatefulWidget {
  final ValueNotifier<DayFilter> selectedFilter;
  const CreateTaskViewHeader({super.key, required this.selectedFilter});

  @override
  State<CreateTaskViewHeader> createState() => _CreateTaskViewHeaderState();
}

class _CreateTaskViewHeaderState extends State<CreateTaskViewHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            S.of(context).createTaskTitle,
            style: AppTextStyle.headlineMedium.copyWith(
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
        ),
      ],
    );
  }
}
