import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/features/all_tasks/model/user_task_model.dart';
import 'package:task_manager/features/all_tasks/view/all_tasks_view.dart';
import 'package:task_manager/features/home/view/home_layout_view.dart';
import 'package:task_manager/features/home/view/home_view.dart';
import 'package:task_manager/features/notifications/view/notifications_view.dart';
import 'package:task_manager/features/settings/view/settings_view.dart';
import 'package:task_manager/features/splash/view/splash_view.dart';
import 'package:task_manager/features/task/view/create_task_view.dart';
import 'package:task_manager/features/task_detail/view/task_detail_view.dart';
import 'package:task_manager/features/timeline/view/timeline_view.dart';

final class AppRoutes {
  static final router = GoRouter(
    initialLocation: RoutesName.splashScreen,
    routes: [
      GoRoute(
        path: RoutesName.splashScreen,
        name: RoutesName.splashScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashView(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final exitAnimation = CurvedAnimation(
                    parent: secondaryAnimation,
                    curve: Curves.easeInOutCubic,
                  );

                  final scaleDown = Tween<double>(
                    begin: 1.0,
                    end: 0.0,
                  ).animate(exitAnimation);

                  final fadeOut = Tween<double>(
                    begin: 1.0,
                    end: 0.0,
                  ).animate(exitAnimation);

                  return FadeTransition(
                    opacity: fadeOut,
                    child: ScaleTransition(
                      scale: scaleDown,
                      alignment: Alignment.topLeft,
                      child: child,
                    ),
                  );
                },
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeLayoutView(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home (Dashboard & Urgent tasks)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutesName.homeScreen,
                name: RoutesName.homeScreen,
                pageBuilder: (context, state) =>
                    NoTransitionPage(key: state.pageKey, child: const HomeView()),
              ),
            ],
          ),

          // Branch 1: Timeline (Task schedule & timeline)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutesName.timelineScreen,
                name: RoutesName.timelineScreen,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const TimelineView(),
                ),
              ),
            ],
          ),

          // Branch 2: Tasks (All user tasks)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutesName.allTasksScreen,
                name: RoutesName.allTasksScreen,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const AllTasksView(),
                ),
              ),
            ],
          ),

          // Branch 3: Settings (Profile & Settings)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutesName.settingsScreen,
                name: RoutesName.settingsScreen,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const SettingsView(),
                ),
              ),
            ],
          ),
        ],
      ),

      // Create Task route
      GoRoute(
        path: RoutesName.createTaskScreen,
        name: RoutesName.createTaskScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreateTaskView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: child,
            );
          },
        ),
      ),

      // Task Detail route
      GoRoute(
        path: RoutesName.taskDetailScreen,
        name: RoutesName.taskDetailScreen,
        pageBuilder: (context, state) {
          final task = state.extra is UserTaskModel
              ? state.extra as UserTaskModel
              : null;
          return CustomTransitionPage(
            key: state.pageKey,
            child: TaskDetailView(task: task),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              );
            },
          );
        },
      ),

      // Notifications route
      GoRoute(
        path: RoutesName.notificationsScreen,
        name: RoutesName.notificationsScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationsView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
