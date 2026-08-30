import 'package:flutter/material.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';

class UserTaskModel {
  final String id;
  final String title;
  final String category;
  final String dueDate;
  bool isDone;
  final bool isUrgent;
  final Color priorityColor;

  // New Agency Workflow fields
  final TaskStatus status;
  final String? blockedByTaskTitle;
  final WaitingOn waitingOn;
  final String? clientName;
  final String? serviceName;
  final List<CommentModel> comments;
  final List<TaskVersionModel> versions;
  final String? description;

  UserTaskModel({
    required this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.isDone,
    required this.isUrgent,
    required this.priorityColor,
    this.status = TaskStatus.inProgress,
    this.blockedByTaskTitle,
    this.waitingOn = WaitingOn.none,
    this.clientName,
    this.serviceName,
    this.comments = const [],
    this.versions = const [],
    this.description,
  });
}
