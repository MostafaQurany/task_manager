import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/home/model/task_filter.dart';
import 'package:task_manager/features/home/widget/home_header.dart';
import 'package:task_manager/features/home/widget/home_search_box.dart';
import 'package:task_manager/features/home/widget/home_task_summary.dart';
import 'package:task_manager/features/home/widget/home_tasks_header.dart';
import 'package:task_manager/features/home/widget/home_tasks_list.dart';

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
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: Header()),
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              const SliverToBoxAdapter(child: TaskSummary()),
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              SliverToBoxAdapter(
                child: SearchBox(controller: _searchController),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              SliverToBoxAdapter(
                child: TasksHeader(selectedFilter: _selectedFilter),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              const HomeTasksList(),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
