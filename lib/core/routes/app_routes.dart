import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/features/home/view/home_view.dart';
import 'package:task_manager/features/splash/view/splash_view.dart';

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
            transitionDuration: const Duration(seconds: 500),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      GoRoute(
        path: RoutesName.homeScreen,
        name: RoutesName.homeScreen,
        pageBuilder: (context, state) =>
            NoTransitionPage(key: state.pageKey, child: const HomeView()),
      ),
    ],
  );
}
