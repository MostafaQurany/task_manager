import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/features/splash/view/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/routes/app_routes.dart';
import '../core/theme/app_theme.dart';
import '../generated/l10n.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Set your design draft size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: AppRoutes.router,

          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
