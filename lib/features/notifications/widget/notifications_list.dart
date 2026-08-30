import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/notifications/model/notification_item_model.dart';
import 'package:task_manager/features/notifications/widget/notification_tile.dart';

class NotificationsList extends StatelessWidget {
  final List<NotificationItemModel> notifications;
  final ValueChanged<NotificationItemModel> onReadNotification;

  const NotificationsList({
    super.key,
    required this.notifications,
    required this.onReadNotification,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notifications.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final item = notifications[index];
        return NotificationTile(
          item: item,
          onTap: () => onReadNotification(item),
        );
      },
    );
  }
}
