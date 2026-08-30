import 'package:flutter/material.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';

class TimelineItemModel {
  final String id;
  final DateTime date;
  final String time; // e.g. "09:00 AM"
  final String endTime; // e.g. "09:45 AM"
  final String title;
  final String category;
  final String duration;
  final bool isCompleted;
  final Color tagColor;
  final TaskStatus status;
  final String? clientName;
  final String? serviceName;
  final String? blockedByTaskTitle;
  final WaitingOn waitingOn;
  final String? description;
  final List<CommentModel> comments;
  final List<TaskVersionModel> versions;

  const TimelineItemModel({
    required this.id,
    required this.date,
    required this.time,
    required this.endTime,
    required this.title,
    required this.category,
    required this.duration,
    required this.isCompleted,
    required this.tagColor,
    this.status = TaskStatus.inProgress,
    this.clientName,
    this.serviceName,
    this.blockedByTaskTitle,
    this.waitingOn = WaitingOn.none,
    this.description,
    this.comments = const [],
    this.versions = const [],
  });

  TimelineItemModel copyWith({
    String? id,
    DateTime? date,
    String? time,
    String? endTime,
    String? title,
    String? category,
    String? duration,
    bool? isCompleted,
    Color? tagColor,
    TaskStatus? status,
    String? clientName,
    String? serviceName,
    String? blockedByTaskTitle,
    WaitingOn? waitingOn,
    String? description,
    List<CommentModel>? comments,
    List<TaskVersionModel>? versions,
  }) {
    return TimelineItemModel(
      id: id ?? this.id,
      date: date ?? this.date,
      time: time ?? this.time,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      category: category ?? this.category,
      duration: duration ?? this.duration,
      isCompleted: isCompleted ?? this.isCompleted,
      tagColor: tagColor ?? this.tagColor,
      status: status ?? this.status,
      clientName: clientName ?? this.clientName,
      serviceName: serviceName ?? this.serviceName,
      blockedByTaskTitle: blockedByTaskTitle ?? this.blockedByTaskTitle,
      waitingOn: waitingOn ?? this.waitingOn,
      description: description ?? this.description,
      comments: comments ?? this.comments,
      versions: versions ?? this.versions,
    );
  }

  UserTaskModel toUserTaskModel() {
    return UserTaskModel(
      id: id,
      title: title,
      category: category,
      dueDate: '$time - $endTime',
      isDone: isCompleted,
      isUrgent: status == TaskStatus.revisionRequestedClient ||
          status == TaskStatus.revisionRequestedInternal,
      priorityColor: tagColor,
      status: isCompleted ? TaskStatus.completed : status,
      blockedByTaskTitle: blockedByTaskTitle,
      waitingOn: waitingOn,
      clientName: clientName,
      serviceName: serviceName,
      comments: comments,
      versions: versions,
      description: description,
    );
  }
}
