import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/task/widget/create_task_view_company_card.dart';

class CreateTaskViewCompany extends StatefulWidget {
  final ValueChanged<int?>? onChanged;

  const CreateTaskViewCompany({super.key, this.onChanged});

  @override
  State<CreateTaskViewCompany> createState() => CreateTaskViewCompanyState();
}

class _CardAnimationCommand {
  final CompanyCardAnimation animation;
  final int id;

  const _CardAnimationCommand(this.animation, this.id);
}

class CreateTaskViewCompanyState extends State<CreateTaskViewCompany> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, _CardAnimationCommand> _commands = {};

  static const int _itemCount = 8;
  final double _itemWidth = 60.w;

  int? _selectedCompanyIndex;
  int _nextAnimationId = 0;

  int? get selectedCompany => _selectedCompanyIndex;
  String? get selectedClientName =>
      _selectedCompanyIndex == null ? null : 'Client ${_selectedCompanyIndex! + 1}';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleCardTap(int index) {
    final oldIndex = _selectedCompanyIndex;

    if (oldIndex == index) {
      setState(() {
        _selectedCompanyIndex = null;
        _commands[index] = _CardAnimationCommand(
          CompanyCardAnimation.drainTopToBottom,
          ++_nextAnimationId,
        );
      });
      widget.onChanged?.call(null);
      return;
    }

    if (oldIndex == null) {
      setState(() {
        _selectedCompanyIndex = index;
        _commands[index] = _CardAnimationCommand(
          CompanyCardAnimation.fillBottomToTop,
          ++_nextAnimationId,
        );
      });
      widget.onChanged?.call(index);
      return;
    }

    final movingRight = index > oldIndex;
    setState(() {
      _selectedCompanyIndex = index;
      _commands[oldIndex] = _CardAnimationCommand(
        movingRight
            ? CompanyCardAnimation.drainLeftToRight
            : CompanyCardAnimation.drainRightToLeft,
        ++_nextAnimationId,
      );
      _commands[index] = _CardAnimationCommand(
        movingRight
            ? CompanyCardAnimation.fillLeftToRight
            : CompanyCardAnimation.fillRightToLeft,
        ++_nextAnimationId,
      );
    });
    widget.onChanged?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _itemCount,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemBuilder: (context, index) {
              final command =
                  _commands[index] ??
                  const _CardAnimationCommand(CompanyCardAnimation.none, 0);

              return AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  final scrollOffset = _scrollController.hasClients
                      ? _scrollController.offset
                      : 0.0;
                  final itemLeft = index * _itemWidth - scrollOffset + 10.w;
                  final itemCenter = itemLeft + _itemWidth / 2;
                  final leftSafe = maxWidth * 0.20;
                  final rightSafe = maxWidth * 0.80;

                  var scale = 1.0;
                  var opacity = 1.0;

                  if (itemCenter < leftSafe) {
                    final factor = (itemCenter / leftSafe).clamp(0.0, 1.0);
                    scale = 0.75 + 0.25 * factor;
                    opacity = 0.6 + 0.4 * factor;
                  } else if (itemCenter > rightSafe) {
                    final factor =
                        ((maxWidth - itemCenter) / (maxWidth - rightSafe))
                            .clamp(0.0, 1.0);
                    scale = 0.75 + 0.25 * factor;
                    opacity = 0.6 + 0.4 * factor;
                  }

                  return Container(
                    width: 50.w,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(opacity: opacity, child: child),
                    ),
                  );
                },
                child: CreateTaskViewCompanyCard(
                  key: ValueKey(index),
                  companyName: index == _itemCount - 1
                      ? 'See More'
                      : 'Client ${index + 1}',
                  companyId: 'CL ${index + 1}',
                  isSelected: _selectedCompanyIndex == index,
                  animation: command.animation,
                  animationId: command.id,
                  onTap: () => _handleCardTap(index),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
