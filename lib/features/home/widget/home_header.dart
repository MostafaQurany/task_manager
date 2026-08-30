import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/generated/l10n.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late List<Animation<Offset>> _slideAnimation;
  late List<Animation<double>> _fadeAnimation;

  @override
  initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _slideAnimation = List.generate(3, (index) {
      final double start = index * 0.25;
      final double end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<Offset>(begin: const Offset(0, -5), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, end, curve: Curves.easeInOutSine),
        ),
      );
    });

    _fadeAnimation = List.generate(3, (index) {
      final double start = index * 0.25;
      final double end = (start + 0.5).clamp(0.0, 1.0);
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(start, end, curve: Curves.easeIn),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SlideTransition(
          position: _slideAnimation[0],
          child: FadeTransition(
            opacity: _fadeAnimation[0],
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32.r,
              child: Icon(Icons.person, size: 32.r, color: AppColors.textDark),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        SlideTransition(
          position: _slideAnimation[1],
          child: FadeTransition(
            opacity: _fadeAnimation[1],
            child: Text(
              S.of(context).greetingUser("Jammy"),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Spacer(),
        SlideTransition(
          position: _slideAnimation[2],
          child: FadeTransition(
            opacity: _fadeAnimation[2],
            child: GestureDetector(
              onTap: () {
                context.push(RoutesName.notificationsScreen);
              },
              child: Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.surfaceCard,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      size: 22.sp,
                      color: Colors.white,
                    ),
                    // Notification badge
                    Positioned(
                      top: 10.r,
                      right: 10.r,
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceCard,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.6),
                              blurRadius: 4.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
