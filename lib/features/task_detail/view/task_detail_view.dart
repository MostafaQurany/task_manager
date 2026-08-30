import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';
import '../widget/task_action_buttons.dart';
import '../widget/task_comments_section.dart';
import '../widget/task_detail_header.dart';
import '../widget/task_detail_meta_card.dart';
import '../widget/task_status_stepper.dart';
import '../widget/task_version_history.dart';

class TaskDetailView extends StatefulWidget {
  final UserTaskModel? task;

  const TaskDetailView({super.key, this.task});

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  late TaskStatus _currentStatus;
  late List<CommentModel> _comments;
  late List<TaskVersionModel> _versions;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.task?.status ?? TaskStatus.inProgress;

    _comments = widget.task?.comments.isNotEmpty == true
        ? List.from(widget.task!.comments)
        : [
            CommentModel(
              id: 'c1',
              authorName: 'Sarah Lead',
              body: 'Please make sure copy aligns with client brief v2.',
              createdAt: DateTime.now().subtract(const Duration(hours: 3)),
              isClientVisible: false,
            ),
            CommentModel(
              id: 'c2',
              authorName: 'Alex Client',
              body: 'Can we try a slightly warmer orange for the primary button?',
              createdAt: DateTime.now().subtract(const Duration(hours: 1)),
              isClientVisible: true,
            ),
          ];

    _versions = widget.task?.versions.isNotEmpty == true
        ? List.from(widget.task!.versions)
        : [
            TaskVersionModel(
              versionNumber: 1,
              uploadedBy: 'Designer',
              uploadedAt: DateTime.now().subtract(const Duration(days: 2)),
              revisionNote: 'Initial design delivery uploaded for internal review.',
              approved: false,
            ),
            TaskVersionModel(
              versionNumber: 2,
              uploadedBy: 'Designer',
              uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
              revisionNote: 'Applied feedback on logo sizing and CTA contrast.',
              approved: true,
            ),
          ];
  }

  void _onStatusChanged(TaskStatus newStatus) {
    setState(() {
      _currentStatus = newStatus;
      if (newStatus == TaskStatus.revisionRequestedInternal ||
          newStatus == TaskStatus.revisionRequestedClient) {
        final nextVersion = _versions.length + 1;
        _versions.insert(
          0,
          TaskVersionModel(
            versionNumber: nextVersion,
            uploadedBy: 'Team',
            uploadedAt: DateTime.now(),
            revisionNote: newStatus == TaskStatus.revisionRequestedClient
                ? 'Client requested modifications'
                : 'Internal review requested changes',
            approved: false,
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Workflow updated to: ${newStatus.label}'),
        backgroundColor: newStatus.color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.task?.title ?? 'Deliverable Design Task';
    final category = widget.task?.category ?? 'Design';
    final dueDate = widget.task?.dueDate ?? 'Today, 5:00 PM';
    final waitingOn = widget.task?.waitingOn ?? WaitingOn.none;
    final blockedBy = widget.task?.blockedByTaskTitle;
    final clientName = widget.task?.clientName ?? 'Acme Corp';
    final serviceName = widget.task?.serviceName ?? 'Design (3/5)';
    final description = widget.task?.description ??
        'Create high-fidelity responsive screens and interactive prototype adhering to brand guidelines.';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.softPeachGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskDetailHeader(
                        title: title,
                        clientName: clientName,
                        serviceName: serviceName,
                        status: _currentStatus,
                      ),
                      SizedBox(height: 18.h),
                      TaskStatusStepper(currentStatus: _currentStatus),
                      SizedBox(height: 16.h),
                      TaskDetailMetaCard(
                        category: category,
                        dueDate: dueDate,
                        waitingOn: waitingOn,
                        blockedByTaskTitle: blockedBy,
                        description: description,
                      ),
                      SizedBox(height: 16.h),
                      TaskVersionHistory(versions: _versions),
                      SizedBox(height: 16.h),
                      TaskCommentsSection(
                        initialComments: _comments,
                        onCommentAdded: (comment) {
                          setState(() => _comments.insert(0, comment));
                        },
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Action Buttons
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.backgroundDeep.withValues(alpha: 0.85),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                child: TaskActionButtons(
                  status: _currentStatus,
                  onStatusChanged: _onStatusChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
