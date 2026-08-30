import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/generated/l10n.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;

  const SearchBox({super.key, required this.controller});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubicEmphasized,
    );
    // Start the expand animation right after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fullWidth = constraints.maxWidth;
        final leftPadding = 10.0.w;
        final rightPadding = 9.0.w;
        final filterWidth = 60.w;
        // Final width the text field should occupy.
        final textFieldMaxWidth =
            (fullWidth - filterWidth - leftPadding - rightPadding).clamp(
              0.0,
              double.infinity,
            );

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 60.h,
                  padding: const EdgeInsets.only(left: 10, right: 0),
                  decoration: BoxDecoration(
                    color: AppColors.searchBoxFill,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.searchBoxBorder,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 20.r,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      // Visible "window" grows from 0 -> full.
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: SizedBox(
                          width: textFieldMaxWidth * _animation.value,
                          child: OverflowBox(
                            maxWidth: textFieldMaxWidth,
                            minWidth: textFieldMaxWidth,
                            alignment: Alignment.centerLeft,
                            child: child!,
                          ),
                        ),
                      );
                    },
                    child: TextField(
                      controller: widget.controller,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: S.of(context).searchHint,
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          color: AppColors.searchBoxHint,
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        prefixIconConstraints: BoxConstraints(minWidth: 10.w),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              width: 65.w,
              height: 65.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: AppColors.darkIconBackground,
                size: 30,
              ),
            ),
          ],
        );
      },
    );
  }
}
