import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onAddPressed;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onAddPressed,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  bool _isAddPressed = false;

  @override
  Widget build(BuildContext context) {
    final double barHeight = 60.h;
    final double buttonSize = 52.r;
    final double elevationOffset = 18.h;

    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      height: barHeight + elevationOffset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Smooth Continuous Frosted Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: barHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: barHeight,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 24.r,
                        offset: Offset(0, 8.r),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Tab 0: Home (Urgent tasks & dashboard)
                      _buildNavItem(
                        index: 0,
                        icon: Icons.grid_view_rounded,
                        activeIcon: Icons.grid_view_rounded,
                        label: S.of(context).navHome,
                      ),

                      // Tab 1: Timeline (Task schedule & times)
                      _buildNavItem(
                        index: 1,
                        icon: Icons.schedule_rounded,
                        activeIcon: Icons.schedule_rounded,
                        label: S.of(context).navTimeline,
                      ),

                      // Center spacing for floating add button
                      SizedBox(width: 58.w),

                      // Tab 2: Tasks (All user tasks)
                      _buildNavItem(
                        index: 2,
                        icon: Icons.task_alt_rounded,
                        activeIcon: Icons.task_alt_rounded,
                        label: S.of(context).navTasks,
                      ),

                      // Tab 3: Settings (Profile & rest of settings)
                      _buildNavItem(
                        index: 3,
                        icon: Icons.tune_rounded,
                        activeIcon: Icons.tune_rounded,
                        label: S.of(context).navSettings,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Floating Center Add Button
          Positioned(top: 0, child: _buildFloatingCenterAddButton(buttonSize)),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool isSelected = widget.currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onTabSelected(index),
          borderRadius: BorderRadius.circular(16.r),
          splashColor: AppColors.primary.withValues(alpha: 0.2),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOutCubic,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    size: 18.sp,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                SizedBox(height: 2.h),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 9.5.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.75),
                    height: 1.0,
                  ),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingCenterAddButton(double size) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isAddPressed = true),
      onTapUp: (_) {
        setState(() => _isAddPressed = false);
        widget.onAddPressed();
      },
      onTapCancel: () => setState(() => _isAddPressed = false),
      child: AnimatedScale(
        scale: _isAddPressed ? 0.90 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeInOut,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFFFF9668)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.55),
                blurRadius: 18.r,
                offset: Offset(0, 6.r),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 12.r,
                offset: Offset(0, 4.r),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.4),
                blurRadius: 4.r,
                offset: Offset(0, -1.r),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.add_rounded,
              color: AppColors.textDark,
              size: 28.sp,
            ),
          ),
        ),
      ),
    );
  }
}
