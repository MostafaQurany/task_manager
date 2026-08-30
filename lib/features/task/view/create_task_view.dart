import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/task/widget/create_task_save_button.dart';
import 'package:task_manager/features/task/widget/create_task_success_dialog.dart';
import 'package:task_manager/features/task/widget/create_task_view_assign_people.dart';
import 'package:task_manager/features/task/widget/create_task_view_company.dart';
import 'package:task_manager/features/task/widget/create_task_view_content.dart';
import 'package:task_manager/features/task/widget/create_task_view_dependency.dart';
import 'package:task_manager/features/task/widget/create_task_view_header.dart';
import 'package:task_manager/features/task/widget/create_task_view_service.dart';
import 'package:task_manager/features/task/widget/create_task_view_timer.dart';

enum DayFilter { am, pm }

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  State<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends State<CreateTaskView> {
  final ValueNotifier<DayFilter> _selectedFilter = ValueNotifier<DayFilter>(
    DayFilter.am,
  );

  // Widget State Keys for modular validation & data access
  final GlobalKey<CreateTaskViewAssignPeopleState> _peopleKey = GlobalKey();
  final GlobalKey<CreateTaskViewCompanyState> _companyKey = GlobalKey();
  final GlobalKey<CreateTaskViewServiceState> _serviceKey = GlobalKey();
  final GlobalKey<CreateTaskViewDependencyState> _dependencyKey = GlobalKey();
  final GlobalKey<CreateTaskViewTimerState> _timerKey = GlobalKey();
  final GlobalKey<CreateTaskViewContentState> _contentKey = GlobalKey();

  @override
  void dispose() {
    _selectedFilter.dispose();
    super.dispose();
  }

  void _onSaveTask() {
    final isContentValid = _contentKey.currentState?.validate() ?? false;
    if (!isContentValid) return;

    final people =
        _peopleKey.currentState?.assignedPeople ?? const ['Just Me'];
    final companyIndex = _companyKey.currentState?.selectedCompany;
    final serviceName = _serviceKey.currentState?.selectedServiceName;
    final blockedByTaskTitle = _dependencyKey.currentState?.blockedByTaskTitle;
    final startDate = _timerKey.currentState?.startDate;
    final endDate = _timerKey.currentState?.endDate;
    final startTime = _timerKey.currentState?.startTime;
    final endTime = _timerKey.currentState?.endTime;
    final description = _contentKey.currentState?.description ?? '';
    final checklist = _contentKey.currentState?.checklist ?? [];

    showDialog(
      context: context,
      builder: (context) => CreateTaskSuccessDialog(
        people: people,
        companyIndex: companyIndex,
        serviceName: serviceName,
        blockedByTaskTitle: blockedByTaskTitle,
        startDate: startDate,
        endDate: endDate,
        startTime: startTime,
        endTime: endTime,
        description: description,
        checklist: checklist,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff242424),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CreateTaskViewHeader(selectedFilter: _selectedFilter),
                SizedBox(height: 24.h),
                CreateTaskViewAssignPeople(key: _peopleKey),
                SizedBox(height: 24.h),
                CreateTaskViewCompany(key: _companyKey),
                SizedBox(height: 24.h),
                CreateTaskViewService(key: _serviceKey),
                SizedBox(height: 24.h),
                CreateTaskViewDependency(key: _dependencyKey),
                SizedBox(height: 24.h),
                CreateTaskViewTimer(key: _timerKey),
                SizedBox(height: 24.h),
                CreateTaskViewContent(key: _contentKey),
                SizedBox(height: 30.h),
                CreateTaskSaveButton(onPressed: _onSaveTask),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
