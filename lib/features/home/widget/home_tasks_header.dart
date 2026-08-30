import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/home/model/task_filter.dart';
import 'package:task_manager/generated/l10n.dart';
import 'home_filter_button.dart';

class TasksHeader extends StatefulWidget {
  final ValueNotifier<TaskFilter> selectedFilter;

  const TasksHeader({super.key, required this.selectedFilter});

  @override
  State<TasksHeader> createState() => _TasksHeaderState();
}

class _TasksHeaderState extends State<TasksHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimationsLeft;
  late Animation<Offset> _slideAnimationsRight;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _slideAnimationsLeft = Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutCubicEmphasized,
          ),
        );

    _slideAnimationsRight = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOutCubicEmphasized,
          ),
        );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SlideTransition(
          position: _slideAnimationsLeft,

          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'My ',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _slideAnimationsRight,

          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ValueListenableBuilder<TaskFilter>(
              valueListenable: widget.selectedFilter,
              builder: (context, value, _) {
                return Container(
                  height: 60.h,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.filterBarBackground,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: AppColors.filterBarBorder,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FilterButton(
                        title: S.of(context).filterActive,
                        value: TaskFilter.active,
                        selectedFilter: value,
                        showDot: true,
                        onSelected: (filter) =>
                            widget.selectedFilter.value = filter,
                      ),
                      FilterButton(
                        title: S.of(context).filterDone,
                        value: TaskFilter.done,
                        selectedFilter: value,
                        onSelected: (filter) =>
                            widget.selectedFilter.value = filter,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
