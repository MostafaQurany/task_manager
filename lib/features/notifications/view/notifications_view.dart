import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/notifications/model/notification_item_model.dart';
import 'package:task_manager/features/notifications/widget/notifications_header.dart';
import 'package:task_manager/features/notifications/widget/notifications_list.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final List<NotificationItemModel> _notifications = [
    NotificationItemModel(
      id: '1',
      title: 'Task Unblocked',
      description: '"Mobile Integration" is unblocked. Backend API has been deployed.',
      time: '10m ago',
      type: NotificationType.taskUnblocked,
      isRead: false,
    ),
    NotificationItemModel(
      id: '2',
      title: 'Internal Revision Requested',
      description: 'Creative Director requested updates on "Ramadan Campaign Post".',
      time: '35m ago',
      type: NotificationType.internalRevisionRequested,
      isRead: false,
    ),
    NotificationItemModel(
      id: '3',
      title: 'Client Review Sign-off',
      description: 'Client approved Version 2 of "Shop App Prototype". Quota consumed (1/5).',
      time: '2h ago',
      type: NotificationType.approved,
      isRead: false,
    ),
    NotificationItemModel(
      id: '4',
      title: 'New Client Comment',
      description: 'Apex Health left a comment: "Please export logo pack in 300 DPI vector format."',
      time: '5h ago',
      type: NotificationType.newComment,
      isRead: false,
    ),
    NotificationItemModel(
      id: '5',
      title: 'Deliverable Assigned',
      description: 'Sarah assigned you to "Brand Identity Guidelines & Mockups".',
      time: 'Yesterday',
      type: NotificationType.taskAssigned,
      isRead: true,
    ),
    NotificationItemModel(
      id: '6',
      title: 'Deadline Approaching',
      description: '"Complete Landing Page UI" is due in 3 hours.',
      time: 'Yesterday',
      type: NotificationType.deadlineApproaching,
      isRead: true,
    ),
    NotificationItemModel(
      id: '7',
      title: 'Deliverable Delayed',
      description: 'Waiting on client files for "Al-Noor Retail Ad Banners". Accountability timer paused.',
      time: '2 days ago',
      type: NotificationType.taskLate,
      isRead: true,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (final item in _notifications) {
        item.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                NotificationsHeader(
                  unreadCount: unreadCount,
                  onMarkAllAsRead: _markAllAsRead,
                ),
                SizedBox(height: 18.h),
                Expanded(
                  child: NotificationsList(
                    notifications: _notifications,
                    onReadNotification: (item) => setState(() => item.isRead = true),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
