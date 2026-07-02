import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

import '../widget/home_header.dart';
import '../widget/home_search_box.dart';
import '../widget/home_task_card.dart';
import '../widget/home_task_summary.dart';
import '../widget/home_task_tag.dart';
import '../widget/home_tasks_header.dart';

enum TaskFilter { active, done }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<TaskFilter> _selectedFilter = ValueNotifier<TaskFilter>(
    TaskFilter.done,
  );

  @override
  void dispose() {
    _searchController.dispose();
    _selectedFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.softPeachGradient),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 30.h,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(),
                    const TaskSummary(),
                    SearchBox(controller: _searchController),
                    TasksHeader(selectedFilter: _selectedFilter),
                    ..._taskCards,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const List<TaskCard> _taskCards = [
  TaskCard(
    backgroundColor: Color(0xFFE4F7FC),
    borderColor: Colors.white,
    titleColor: Colors.black,
    descriptionColor: Color(0xFF8B9297),
    checkButtonColor: Colors.black,
    checkIconColor: Colors.white,
    dateColor: Color(0xFF4F5961),
    title: 'Complete Landing Page',
    description: 'Nacho Brand landing page',
    date: '15 Sept',
    moreText: '+1 More',
    tags: [
      TaskTag(
        text: 'Landing',
        backgroundColor: Colors.white,
        textColor: Colors.black,
      ),
      TaskTag(
        text: 'Website',
        backgroundColor: Color(0xFFFFB186),
        textColor: Colors.black,
      ),
    ],
  ),
  TaskCard(
    backgroundColor: Color(0xFF11141B),
    borderColor: Color(0xFF3E4653),
    titleColor: Colors.white,
    descriptionColor: Color(0xFF8E929B),
    checkButtonColor: Colors.white,
    checkIconColor: Colors.black,
    dateColor: Color(0xFFB5B8C0),
    title: 'Create prototype for shop app',
    description:
        'Shop app has over 50 screens that\nneeds a prototype for the client.',
    date: '15 Sept',
    moreText: '+3 More',
    tags: [
      TaskTag(
        text: 'Mobile app',
        backgroundColor: Color(0xFFFFB186),
        textColor: Colors.black,
      ),
      TaskTag(
        text: 'Prototype',
        backgroundColor: Color(0xFFEAF8FF),
        textColor: Colors.black,
      ),
    ],
  ),
];
