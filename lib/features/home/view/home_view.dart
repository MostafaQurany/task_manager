import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/widgets/background_gradiant.dart';

enum TaskFilter { active, done }

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TaskFilter selectedFilter = TaskFilter.done;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32.r,
                          child: Icon(Icons.person, size: 32.r),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          "Hey Jammy!",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceCard,
                            foregroundColor: AppColors.borderLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.r),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "add Task",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.add, color: Colors.white, size: 18.r),
                            ],
                          ),
                        ),
                      ],
                    ),

                    RichText(
                      text: TextSpan(
                        text: 'You have got ',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28.sp,
                        ),

                        children: [
                          TextSpan(
                            text: '4 Tasks \n',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'today ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'to complete👋',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 28.sp,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          height: 60.h,
                          padding: const EdgeInsets.only(left: 10, right: 0),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.22),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 20.r,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  cursorColor: Colors.white,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search Tasks',
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 10.w,
                                    ),
                                  ),
                                ),
                              ),

                              // Filter button
                              Container(
                                width: 65.w,
                                height: 65.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.18,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.tune_rounded,
                                  color: Color(0xFF252833),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'My ',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Tasks',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 60.h,

                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF3C4050,
                            ).withValues(alpha: 0.80),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.18),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _filterButton(
                                title: 'Active',
                                value: TaskFilter.active,
                                showDot: true,
                              ),
                              _filterButton(
                                title: 'Done',
                                value: TaskFilter.done,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const TaskCard(
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
                    const TaskCard(
                      backgroundColor: Colors.transparent,
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
                    const TaskCard(
                      backgroundColor: Colors.transparent,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterButton({
    required String title,
    required TaskFilter value,
    bool showDot = false,
  }) {
    final bool isSelected = selectedFilter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.r),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            if (showDot) ...[
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF9DFF8F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? const Color.fromARGB(255, 103, 103, 104)
                    : Colors.white.withValues(alpha: 0.55),
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final Color checkButtonColor;
  final Color checkIconColor;
  final Color dateColor;
  final String title;
  final String description;
  final String date;
  final String moreText;
  final List<TaskTag> tags;

  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.checkButtonColor,
    required this.checkIconColor,
    required this.dateColor,
    required this.title,
    required this.description,
    required this.date,
    required this.moreText,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(42),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips + date
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      if (tags.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TaskChip(tag: tags[0]),
                        ),
                      ],
                      if (tags.length > 1) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TaskChip(tag: tags[1]),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              Text(
                date,
                style: TextStyle(
                  color: dateColor,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),

          SizedBox(height: 10.h),

          Text(
            description,
            style: TextStyle(
              color: descriptionColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),

          SizedBox(height: 24.h),

          Row(
            children: [
              const Spacer(),
              Container(
                width: 50.h,
                height: 50.h,
                decoration: BoxDecoration(
                  color: checkButtonColor,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 14.r,
                      offset: Offset(0, 8.r),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: checkIconColor,
                  size: 28.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskTag {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const TaskTag({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });
}

class TaskChip extends StatelessWidget {
  final TaskTag tag;

  const TaskChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: tag.backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Center(
        child: Text(
          tag.text,
          style: TextStyle(
            color: tag.textColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
