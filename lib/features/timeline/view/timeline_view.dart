import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/timeline/model/timeline_item_model.dart';
import 'package:task_manager/features/timeline/model/timeline_schedule_data.dart';
import 'package:task_manager/features/timeline/widget/timeline_agenda_view.dart';
import 'package:task_manager/features/timeline/widget/timeline_calendar_sheet.dart';
import 'package:task_manager/features/timeline/widget/timeline_date_carousel.dart';
import 'package:task_manager/features/timeline/widget/timeline_filter_bar.dart';
import 'package:task_manager/features/timeline/widget/timeline_header.dart';
import 'package:task_manager/features/timeline/widget/timeline_list.dart';
import 'package:task_manager/features/timeline/widget/timeline_weekly_view.dart';

class TimelineView extends StatefulWidget {
  const TimelineView({super.key});

  @override
  State<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  late DateTime _selectedDate;
  TimelineViewMode _viewMode = TimelineViewMode.daily;
  String _selectedCategory = 'All';
  bool _hideCompleted = false;
  late List<TimelineItemModel> _items;

  final List<String> _categories = [
    'All',
    'Design Sprint',
    'Development',
    'Backend',
    'Meetings',
    'Review',
    'Branding',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _items = TimelineScheduleData.getInitialItems();
  }

  void _toggleTaskCompletion(TimelineItemModel item) {
    setState(() {
      final index = _items.indexWhere((t) => t.id == item.id);
      if (index != -1) {
        final updated = _items[index].copyWith(
          isCompleted: !_items[index].isCompleted,
        );
        _items[index] = updated;

        final isDone = updated.isCompleted;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.surfaceCard,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            content: Row(
              children: [
                Icon(
                  isDone ? Icons.check_circle : Icons.refresh,
                  color: isDone ? AppColors.success : AppColors.primary,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    isDone ? 'Marked "${item.title}" as completed' : 'Reopened "${item.title}"',
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
            action: SnackBarAction(
              label: 'Undo',
              textColor: AppColors.primary,
              onPressed: () {
                setState(() {
                  _items[index] = item;
                });
              },
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _deleteTask(TimelineItemModel item) {
    setState(() {
      final index = _items.indexWhere((t) => t.id == item.id);
      if (index != -1) {
        _items.removeAt(index);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.surfaceCard,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            content: Text(
              'Removed "${item.title}"',
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Undo',
              textColor: AppColors.primary,
              onPressed: () {
                setState(() {
                  _items.insert(index, item);
                });
              },
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });
  }

  Set<String> _getDatesWithTasks() {
    return _items.map((item) => DateFormat('yyyy-MM-dd').format(item.date)).toSet();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter by category
    var filtered = _items.where((t) {
      if (_selectedCategory != 'All' && t.category != _selectedCategory) {
        return false;
      }
      if (_hideCompleted && t.isCompleted) {
        return false;
      }
      return true;
    }).toList();

    // 2. Filter for daily view
    final dailyItems = filtered
        .where((t) => DateUtils.isSameDay(t.date, _selectedDate))
        .toList();

    final isSelectedDateToday = DateUtils.isSameDay(_selectedDate, DateTime.now());
    final totalDailyCount = _items.where((t) => DateUtils.isSameDay(t.date, _selectedDate)).length;
    final completedDailyCount = _items.where((t) => DateUtils.isSameDay(t.date, _selectedDate) && t.isCompleted).length;

    return Container(
      decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: TimelineHeader(
                  selectedDate: _selectedDate,
                  onOpenCalendar: () {
                    TimelineCalendarSheet.show(
                      context,
                      initialDate: _selectedDate,
                      onDateSelected: (newDate) {
                        setState(() => _selectedDate = newDate);
                      },
                    );
                  },
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 14.h)),

              // Horizontal Date Carousel (for Daily & Weekly modes)
              if (_viewMode != TimelineViewMode.agenda) ...[
                SliverToBoxAdapter(
                  child: TimelineDateCarousel(
                    selectedDate: _selectedDate,
                    datesWithTasks: _getDatesWithTasks(),
                    onDateSelected: (date) {
                      setState(() => _selectedDate = date);
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 14.h)),
              ],

              // Filter & Mode Bar
              SliverToBoxAdapter(
                child: TimelineFilterBar(
                  viewMode: _viewMode,
                  onViewModeChanged: (mode) => setState(() => _viewMode = mode),
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                  categories: _categories,
                  hideCompleted: _hideCompleted,
                  onToggleHideCompleted: () => setState(() => _hideCompleted = !_hideCompleted),
                  totalCount: totalDailyCount,
                  completedCount: completedDailyCount,
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // Active View Mode Content
              if (_viewMode == TimelineViewMode.daily)
                TimelineList(
                  items: dailyItems,
                  isSelectedDateToday: isSelectedDateToday,
                  onToggleComplete: _toggleTaskCompletion,
                  onDelete: _deleteTask,
                )
              else if (_viewMode == TimelineViewMode.weekly)
                TimelineWeeklyView(
                  allItems: filtered,
                  selectedDate: _selectedDate,
                  onSelectDay: (day) {
                    setState(() {
                      _selectedDate = day;
                      _viewMode = TimelineViewMode.daily;
                    });
                  },
                  onToggleComplete: _toggleTaskCompletion,
                )
              else
                TimelineAgendaView(
                  items: filtered,
                  onToggleComplete: _toggleTaskCompletion,
                  onDelete: _deleteTask,
                ),

              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
