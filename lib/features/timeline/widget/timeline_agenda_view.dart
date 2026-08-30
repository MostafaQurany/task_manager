import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';
import 'package:task_manager/features/timeline/widget/timeline_empty_state.dart';
import 'package:task_manager/features/timeline/widget/timeline_tile.dart';

class TimelineAgendaView extends StatelessWidget {
  final List<TimelineItemModel> items;
  final Function(TimelineItemModel) onToggleComplete;
  final Function(TimelineItemModel) onDelete;

  const TimelineAgendaView({
    super.key,
    required this.items,
    required this.onToggleComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(
        child: TimelineEmptyState(
          title: 'No Upcoming Items',
          subtitle: 'No scheduled agenda tasks found for the selected filter.',
        ),
      );
    }

    // Group items by date string
    final Map<String, List<TimelineItemModel>> grouped = {};
    for (final item in items) {
      final key = DateFormat('yyyy-MM-dd').format(item.date);
      grouped.putIfAbsent(key, () => []).add(item);
    }

    final sortedKeys = grouped.keys.toList()..sort();

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final dateKey = sortedKeys[index];
          final dateItems = grouped[dateKey]!;
          final date = dateItems.first.date;
          final isToday = DateUtils.isSameDay(date, DateTime.now());
          final isTomorrow = DateUtils.isSameDay(date, DateTime.now().add(const Duration(days: 1)));

          String headerLabel = DateFormat('EEEE, d MMMM').format(date);
          if (isToday) headerLabel = 'Today • $headerLabel';
          if (isTomorrow) headerLabel = 'Tomorrow • $headerLabel';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 8.r,
                      height: 8.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? AppColors.primary : AppColors.activeDot,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      headerLabel,
                      style: AppTextStyle.titleSmall.copyWith(
                        color: isToday ? AppColors.primaryLight : Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              ...dateItems.asMap().entries.map((entry) {
                final itemIndex = entry.key;
                final item = entry.value;
                final isLast = itemIndex == dateItems.length - 1;

                return TimelineTile(
                  item: item,
                  isLast: isLast,
                  onToggleComplete: () => onToggleComplete(item),
                  onDelete: () => onDelete(item),
                );
              }),
              SizedBox(height: 8.h),
            ],
          );
        },
        childCount: sortedKeys.length,
      ),
    );
  }
}
