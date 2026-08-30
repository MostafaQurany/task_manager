import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

enum CompanyCardAnimation {
  none,
  fillBottomToTop,
  drainTopToBottom,
  fillLeftToRight,
  drainLeftToRight,
  fillRightToLeft,
  drainRightToLeft,
}

class CreateTaskViewCompanyCard extends StatefulWidget {
  final String companyName;
  final String companyId;
  final bool isSelected;
  final VoidCallback? onTap;
  final CompanyCardAnimation animation;
  final int animationId;

  const CreateTaskViewCompanyCard({
    super.key,
    required this.companyName,
    required this.companyId,
    required this.isSelected,
    required this.animation,
    required this.animationId,
    this.onTap,
  });

  @override
  State<CreateTaskViewCompanyCard> createState() =>
      _CreateTaskViewCompanyCardState();
}

class _CreateTaskViewCompanyCardState extends State<CreateTaskViewCompanyCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      value: widget.isSelected ? 1 : 0,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(covariant CreateTaskViewCompanyCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animationId != oldWidget.animationId) {
      if (_isFill(widget.animation)) {
        _controller.forward();
      } else if (_isDrain(widget.animation)) {
        _controller.reverse();
      }
      return;
    }

    if (widget.animation == CompanyCardAnimation.none &&
        widget.isSelected != oldWidget.isSelected) {
      _controller.value = widget.isSelected ? 1 : 0;
    }
  }

  bool _isFill(CompanyCardAnimation animation) {
    return animation == CompanyCardAnimation.fillBottomToTop ||
        animation == CompanyCardAnimation.fillLeftToRight ||
        animation == CompanyCardAnimation.fillRightToLeft;
  }

  bool _isDrain(CompanyCardAnimation animation) {
    return animation == CompanyCardAnimation.drainTopToBottom ||
        animation == CompanyCardAnimation.drainLeftToRight ||
        animation == CompanyCardAnimation.drainRightToLeft;
  }

  bool get _isVertical {
    return widget.animation == CompanyCardAnimation.fillBottomToTop ||
        widget.animation == CompanyCardAnimation.drainTopToBottom ||
        widget.animation == CompanyCardAnimation.none;
  }

  Alignment get _fillAlignment {
    switch (widget.animation) {
      case CompanyCardAnimation.fillLeftToRight:
        return Alignment.centerLeft;
      case CompanyCardAnimation.drainLeftToRight:
        return Alignment.centerRight;
      case CompanyCardAnimation.fillRightToLeft:
        return Alignment.centerRight;
      case CompanyCardAnimation.drainRightToLeft:
        return Alignment.centerLeft;
      case CompanyCardAnimation.fillBottomToTop:
      case CompanyCardAnimation.drainTopToBottom:
      case CompanyCardAnimation.none:
        return Alignment.bottomCenter;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.vertical(
      top: Radius.circular(60.r),
      bottom: Radius.circular(60.r),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final coverage = _animation.value.clamp(0.0, 1.0);
          final foregroundColor = Color.lerp(
            Colors.grey.shade400,
            Colors.white,
            coverage,
          )!;
          final borderColor = Color.lerp(
            Colors.grey.shade800,
            AppColors.primary,
            coverage,
          )!;

          return Container(
            width: 50.w,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: borderColor, width: 1.w + coverage.w),
              boxShadow: coverage == 0
                  ? null
                  : [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: 0.30 * coverage,
                        ),
                        blurRadius: 10.r * coverage,
                        spreadRadius: 2.r * coverage,
                      ),
                    ],
            ),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff292929), Color(0xff383838)],
                      ),
                    ),
                  ),
                  Align(
                    alignment: _fillAlignment,
                    child: FractionallySizedBox(
                      widthFactor: _isVertical ? 1 : coverage,
                      heightFactor: _isVertical ? coverage : 1,
                      child: const ColoredBox(color: AppColors.primary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            widget.companyName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: foregroundColor,
                            ),
                          ),
                        ),
                        Text(
                          widget.companyId,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
