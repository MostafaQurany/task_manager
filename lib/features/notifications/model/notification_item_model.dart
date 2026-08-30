import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';

enum NotificationType {
  taskAssigned,
  taskUnblocked,
  internalRevisionRequested,
  clientRevisionRequested,
  approved,
  newComment,
  deadlineApproaching,
  taskLate,
}

extension NotificationTypeExtension on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.taskAssigned:
        return Icons.assignment_ind_outlined;
      case NotificationType.taskUnblocked:
        return Icons.lock_open_rounded;
      case NotificationType.internalRevisionRequested:
      case NotificationType.clientRevisionRequested:
        return Icons.replay_rounded;
      case NotificationType.approved:
        return Icons.check_circle_outline_rounded;
      case NotificationType.newComment:
        return Icons.chat_bubble_outline_rounded;
      case NotificationType.deadlineApproaching:
        return Icons.alarm_rounded;
      case NotificationType.taskLate:
        return Icons.error_outline_rounded;
    }
  }

  Color get iconColor {
    switch (this) {
      case NotificationType.taskUnblocked:
      case NotificationType.approved:
        return AppColors.activeDot;
      case NotificationType.internalRevisionRequested:
      case NotificationType.clientRevisionRequested:
      case NotificationType.deadlineApproaching:
        return AppColors.warning;
      case NotificationType.taskLate:
        return AppColors.danger;
      case NotificationType.taskAssigned:
      case NotificationType.newComment:
        return AppColors.primary;
    }
  }
}

class NotificationItemModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final IconData? customIcon;
  final Color? customIconColor;
  bool isRead;

  NotificationItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    this.type = NotificationType.taskAssigned,
    this.customIcon,
    this.customIconColor,
    required this.isRead,
  });

  IconData get icon => customIcon ?? type.icon;
  Color get iconColor => customIconColor ?? type.iconColor;
}
