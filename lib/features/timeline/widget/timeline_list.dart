import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';
import 'package:task_manager/features/timeline/widget/timeline_empty_state.dart';
import 'package:task_manager/features/timeline/widget/timeline_gap_tile.dart';
import 'package:task_manager/features/timeline/widget/timeline_now_indicator.dart';
import 'package:task_manager/features/timeline/widget/timeline_tile.dart';

class TimelineList extends StatelessWidget {
  final List<TimelineItemModel> items;
  final bool isSelectedDateToday;
  final Function(TimelineItemModel) onToggleComplete;
  final Function(TimelineItemModel) onDelete;

  const TimelineList({
    super.key,
    required this.items,
    required this.isSelectedDateToday,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(
        child: TimelineEmptyState(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Check if we should insert Now Indicator before items in the afternoon
          final item = items[index];
          final isLast = index == items.length - 1;
          final isFirst = index == 0;

          // Gap check: if there's a large gap between item 2 (morning) and item 3 (afternoon)
          final bool showGapAfterThis = (index == 1 && items.length > 2);
          // Show live now indicator around 05:00 PM / between item 3 & 4
          final bool showNowBeforeThis = isSelectedDateToday && index == 3;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showNowBeforeThis)
                Padding(
                  padding: EdgeInsets.only(left: 76.w, bottom: 8.h),
                  child: const TimelineNowIndicator(),
                ),

              TimelineTile(
                item: item,
                isFirst: isFirst,
                isLast: isLast && !showGapAfterThis,
                onToggleComplete: () => onToggleComplete(item),
                onDelete: () => onDelete(item),
              ),

              if (showGapAfterThis)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: const TimelineGapTile(
                    timeRange: '11:15 AM - 01:30 PM',
                    duration: '2h 15m',
                  ),
                ),
            ],
          );
        },
        childCount: items.length,
      ),
    );
  }
}
