import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum TaskStatus {
  toDo,
  readyToStart,
  inProgress,
  internalReview,
  revisionRequestedInternal,
  readyForClientReview,
  clientReview,
  revisionRequestedClient,
  approved,
  completed,
}

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.toDo:
        return 'To Do';
      case TaskStatus.readyToStart:
        return 'Ready to Start';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.internalReview:
        return 'Internal Review';
      case TaskStatus.revisionRequestedInternal:
        return 'Revision (Internal)';
      case TaskStatus.readyForClientReview:
        return 'Ready for Client';
      case TaskStatus.clientReview:
        return 'Client Review';
      case TaskStatus.revisionRequestedClient:
        return 'Revision (Client)';
      case TaskStatus.approved:
        return 'Approved';
      case TaskStatus.completed:
        return 'Completed';
    }
  }

  Color get color {
    switch (this) {
      case TaskStatus.toDo:
        return AppColors.textMuted;
      case TaskStatus.readyToStart:
        return AppColors.primaryLight;
      case TaskStatus.inProgress:
        return AppColors.primary;
      case TaskStatus.internalReview:
      case TaskStatus.readyForClientReview:
      case TaskStatus.clientReview:
        return AppColors.warning;
      case TaskStatus.revisionRequestedInternal:
      case TaskStatus.revisionRequestedClient:
        return AppColors.danger;
      case TaskStatus.approved:
        return AppColors.activeDot;
      case TaskStatus.completed:
        return AppColors.success;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskStatus.toDo:
        return Icons.radio_button_unchecked;
      case TaskStatus.readyToStart:
        return Icons.play_circle_outline_rounded;
      case TaskStatus.inProgress:
        return Icons.timelapse_rounded;
      case TaskStatus.internalReview:
        return Icons.rate_review_outlined;
      case TaskStatus.revisionRequestedInternal:
        return Icons.replay_rounded;
      case TaskStatus.readyForClientReview:
        return Icons.send_rounded;
      case TaskStatus.clientReview:
        return Icons.visibility_outlined;
      case TaskStatus.revisionRequestedClient:
        return Icons.replay_rounded;
      case TaskStatus.approved:
        return Icons.check_circle_outline_rounded;
      case TaskStatus.completed:
        return Icons.task_alt_rounded;
    }
  }

  bool get isReview =>
      this == TaskStatus.internalReview ||
      this == TaskStatus.readyForClientReview ||
      this == TaskStatus.clientReview;

  bool get isRevision =>
      this == TaskStatus.revisionRequestedInternal ||
      this == TaskStatus.revisionRequestedClient;

  bool get isDone =>
      this == TaskStatus.approved || this == TaskStatus.completed;
}
