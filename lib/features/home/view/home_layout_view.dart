import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/widgets/custom_bottom_nav_bar.dart';

class HomeLayoutView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeLayoutView({super.key, required this.navigationShell});

  void _onTabSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  void _onAddPressed(BuildContext context) {
    context.push(RoutesName.createTaskScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        left: false,
        right: false,
        child: CustomBottomNavBar(
          currentIndex: navigationShell.currentIndex,
          onTabSelected: _onTabSelected,
          onAddPressed: () => _onAddPressed(context),
        ),
      ),
    );
  }
}
