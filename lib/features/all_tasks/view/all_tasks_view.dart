import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';
import 'package:task_manager/features/all_tasks/widget/all_tasks_filter_chips.dart';
import 'package:task_manager/features/all_tasks/widget/all_tasks_header.dart';
import 'package:task_manager/features/all_tasks/widget/all_tasks_list.dart';

class AllTasksView extends StatefulWidget {
  const AllTasksView({super.key});

  @override
  State<AllTasksView> createState() => _AllTasksViewState();
}

class _AllTasksViewState extends State<AllTasksView> {
  int _selectedFilterIndex = 0;

  final List<UserTaskModel> _tasks = [
    UserTaskModel(
      id: '1',
      title: 'Complete Landing Page UI',
      category: 'Design',
      dueDate: 'Today, 5:00 PM',
      isDone: false,
      isUrgent: true,
      priorityColor: AppColors.primary,
      status: TaskStatus.inProgress,
      clientName: 'Nacho Brand',
      serviceName: 'Website (62%)',
      description: 'Finish header, features section, and checkout responsiveness.',
      comments: [
        CommentModel(
          id: 'c1',
          authorName: 'Sarah Team Lead',
          body: 'Check that typography matches brand tokens.',
          createdAt: DateTime.now().subtract(const Duration(hours: 4)),
          isClientVisible: false,
        ),
      ],
      versions: [
        TaskVersionModel(
          versionNumber: 1,
          uploadedBy: 'Designer',
          uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
          revisionNote: 'Initial layout draft.',
          approved: false,
        ),
      ],
    ),
    UserTaskModel(
      id: '2',
      title: 'Mobile Integration for User Registration',
      category: 'Flutter',
      dueDate: 'Today, 7:00 PM',
      isDone: false,
      isUrgent: true,
      priorityColor: AppColors.danger,
      status: TaskStatus.readyToStart,
      blockedByTaskTitle: 'Backend Auth API',
      waitingOn: WaitingOn.team,
      clientName: 'Fintech Hub',
      serviceName: 'Mobile App (40%)',
      description: 'Integrate registration endpoints once backend API is deployed.',
    ),
    UserTaskModel(
      id: '3',
      title: 'Review Client Revisions for Logo Pack',
      category: 'Branding',
      dueDate: 'Today, 3:00 PM',
      isDone: false,
      isUrgent: false,
      priorityColor: AppColors.danger,
      status: TaskStatus.revisionRequestedClient,
      waitingOn: WaitingOn.none,
      clientName: 'Apex Health',
      serviceName: 'Design (4/5)',
      description: 'Client asked for darker monochrome variation for print media.',
      comments: [
        CommentModel(
          id: 'c2',
          authorName: 'Apex Brand Manager',
          body: 'Need vector SVG exports with 300 DPI.',
          createdAt: DateTime.now().subtract(const Duration(hours: 6)),
          isClientVisible: true,
        ),
      ],
      versions: [
        TaskVersionModel(
          versionNumber: 1,
          uploadedBy: 'Graphic Designer',
          uploadedAt: DateTime.now().subtract(const Duration(days: 3)),
          revisionNote: 'Primary color palette version.',
          approved: false,
        ),
        TaskVersionModel(
          versionNumber: 2,
          uploadedBy: 'Graphic Designer',
          uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
          revisionNote: 'Adjusted stroke weights.',
          approved: false,
        ),
      ],
    ),
    UserTaskModel(
      id: '4',
      title: 'Ramadan Campaign Creative Deliverable',
      category: 'Design',
      dueDate: 'Tomorrow',
      isDone: false,
      isUrgent: false,
      priorityColor: AppColors.warning,
      status: TaskStatus.internalReview,
      waitingOn: WaitingOn.team,
      clientName: 'Al-Noor Retail',
      serviceName: 'Posts (8/12)',
      description: 'Submitted to Creative Director for internal quality check.',
    ),
    UserTaskModel(
      id: '5',
      title: 'Shop Prototype Feature Walkthrough',
      category: 'Prototype',
      dueDate: '18 Sept',
      isDone: false,
      isUrgent: false,
      priorityColor: AppColors.warning,
      status: TaskStatus.clientReview,
      waitingOn: WaitingOn.client,
      clientName: 'Shop App Client',
      serviceName: 'Mobile App (40%)',
      description: 'Client is reviewing the interactive video preview.',
    ),
    UserTaskModel(
      id: '6',
      title: 'Approved Brand Guidelines Document',
      category: 'Branding',
      dueDate: '14 Sept',
      isDone: true,
      isUrgent: false,
      priorityColor: AppColors.activeDot,
      status: TaskStatus.completed,
      clientName: 'Solaria Energy',
      serviceName: 'Design (5/5)',
      description: 'Deliverable completed, signed off, and counted toward quota.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _tasks.where((t) {
      switch (_selectedFilterIndex) {
        case 0: // Today
          return t.dueDate.toLowerCase().contains('today') || !t.isDone;
        case 1: // Ready to Start
          return t.status == TaskStatus.readyToStart;
        case 2: // In Progress
          return t.status == TaskStatus.inProgress;
        case 3: // Blocked
          return t.blockedByTaskTitle != null && t.blockedByTaskTitle!.isNotEmpty;
        case 4: // Revisions
          return t.status.isRevision;
        case 5: // Waiting for Review
          return t.status.isReview;
        default:
          return true;
      }
    }).toList();

    return Container(
      decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AllTasksHeader(
                  activeCount: _tasks.where((t) => !t.isDone).length,
                  completedCount: _tasks.where((t) => t.isDone).length,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverToBoxAdapter(
                child: AllTasksFilterChips(
                  selectedIndex: _selectedFilterIndex,
                  onFilterSelected: (index) =>
                      setState(() => _selectedFilterIndex = index),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              AllTasksList(
                tasks: filteredTasks,
                onToggleTask: (task) => setState(() {
                  task.isDone = !task.isDone;
                  if (task.isDone) {
                    // if marked done, we can treat as completed
                  }
                }),
                onTaskTap: (task) {
                  context.push(
                    RoutesName.taskDetailScreen,
                    extra: task,
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
