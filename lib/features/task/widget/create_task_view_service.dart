import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/models/service_model.dart';
import 'create_task_view_company_card.dart';
import 'create_task_view_service_card.dart';

class CreateTaskViewService extends StatefulWidget {
  final ValueChanged<ServiceModel?>? onChanged;

  const CreateTaskViewService({super.key, this.onChanged});

  @override
  State<CreateTaskViewService> createState() => CreateTaskViewServiceState();
}

class _ServiceAnimationCommand {
  final CompanyCardAnimation animation;
  final int id;

  const _ServiceAnimationCommand(this.animation, this.id);
}

class CreateTaskViewServiceState extends State<CreateTaskViewService> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, _ServiceAnimationCommand> _commands = {};

  final List<ServiceModel> _services = const [
    ServiceModel(
      id: 's1',
      name: 'Design',
      isQuantityBased: true,
      contractedQty: 5,
      consumedQty: 3,
    ),
    ServiceModel(
      id: 's2',
      name: 'Posts',
      isQuantityBased: true,
      contractedQty: 12,
      consumedQty: 8,
    ),
    ServiceModel(
      id: 's3',
      name: 'Website',
      isQuantityBased: false,
      progressPercent: 62,
    ),
    ServiceModel(
      id: 's4',
      name: 'Mobile App',
      isQuantityBased: false,
      progressPercent: 40,
    ),
    ServiceModel(
      id: 's5',
      name: 'Copywriting',
      isQuantityBased: true,
      contractedQty: 4,
      consumedQty: 2,
    ),
    ServiceModel(
      id: 's6',
      name: 'Branding',
      isQuantityBased: true,
      contractedQty: 1,
      consumedQty: 1,
    ),
  ];

  final double _itemWidth = 60.w;
  int? _selectedServiceIndex;
  int _nextAnimationId = 0;

  int? get selectedServiceIndex => _selectedServiceIndex;
  ServiceModel? get selectedService => _selectedServiceIndex != null &&
          _selectedServiceIndex! < _services.length
      ? _services[_selectedServiceIndex!]
      : null;
  String? get selectedServiceName => selectedService?.name;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleCardTap(int index) {
    final oldIndex = _selectedServiceIndex;

    if (oldIndex == index) {
      setState(() {
        _selectedServiceIndex = null;
        _commands[index] = _ServiceAnimationCommand(
          CompanyCardAnimation.drainTopToBottom,
          ++_nextAnimationId,
        );
      });
      widget.onChanged?.call(null);
      return;
    }

    if (oldIndex == null) {
      setState(() {
        _selectedServiceIndex = index;
        _commands[index] = _ServiceAnimationCommand(
          CompanyCardAnimation.fillBottomToTop,
          ++_nextAnimationId,
        );
      });
      widget.onChanged?.call(_services[index]);
      return;
    }

    final movingRight = index > oldIndex;
    setState(() {
      _selectedServiceIndex = index;
      _commands[oldIndex] = _ServiceAnimationCommand(
        movingRight
            ? CompanyCardAnimation.drainLeftToRight
            : CompanyCardAnimation.drainRightToLeft,
        ++_nextAnimationId,
      );
      _commands[index] = _ServiceAnimationCommand(
        movingRight
            ? CompanyCardAnimation.fillLeftToRight
            : CompanyCardAnimation.fillRightToLeft,
        ++_nextAnimationId,
      );
    });
    widget.onChanged?.call(_services[index]);
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
            itemCount: _services.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemBuilder: (context, index) {
              final service = _services[index];
              final command = _commands[index] ??
                  const _ServiceAnimationCommand(CompanyCardAnimation.none, 0);

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
                child: CreateTaskViewServiceCard(
                  key: ValueKey(service.id),
                  serviceName: service.name,
                  quotaBadge: service.quotaLabel,
                  isSelected: _selectedServiceIndex == index,
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
