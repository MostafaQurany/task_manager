import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/localization/locale_provider.dart';
import 'package:task_manager/core/models/comment_model.dart';
import 'package:task_manager/core/models/service_model.dart';
import 'package:task_manager/core/models/task_status.dart';
import 'package:task_manager/core/models/task_version_model.dart';
import 'package:task_manager/core/models/waiting_on.dart';
import 'package:task_manager/core/services/storage_service.dart';
import 'package:task_manager/core/widgets/custom_bottom_nav_bar.dart';
import 'package:task_manager/generated/l10n.dart';

void main() {
  testWidgets(
      'CustomBottomNavBar renders English localized tabs and floating center add button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    int selectedIndex = 0;
    bool addPressed = false;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: selectedIndex,
              onTabSelected: (index) => selectedIndex = index,
              onAddPressed: () => addPressed = true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Timeline'), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_rounded));
    expect(addPressed, isTrue);

    await tester.tap(find.text('Timeline'));
    expect(selectedIndex, 1);
  });

  testWidgets('CustomBottomNavBar renders Arabic localized tabs',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1125, 2436);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    int selectedIndex = 0;

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: selectedIndex,
              onTabSelected: (index) => selectedIndex = index,
              onAddPressed: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('الجدول الزمني'), findsOneWidget);
    expect(find.text('المهام'), findsOneWidget);
    expect(find.text('الإعدادات'), findsOneWidget);
  });

  test(
      'LocaleNotifier restores saved Arabic locale from SharedPreferences and persists changes',
      () async {
    SharedPreferences.setMockInitialValues({
      StorageKeys.appLanguageCode: 'ar',
    });

    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
    addTearDown(container.dispose);

    // Verify initial restored locale is 'ar'
    expect(container.read(localeProvider), const Locale('ar'));

    // Switch to English and verify persistence
    await container
        .read(localeProvider.notifier)
        .setLocale(const Locale('en'));
    expect(container.read(localeProvider), const Locale('en'));
    expect(prefs.getString(StorageKeys.appLanguageCode), 'en');
  });

  group('Agency Workflow Domain Models Tests', () {
    test('TaskStatus extensions reflect expected state logic', () {
      expect(TaskStatus.inProgress.label, 'In Progress');
      expect(TaskStatus.internalReview.isReview, isTrue);
      expect(TaskStatus.clientReview.isReview, isTrue);
      expect(TaskStatus.revisionRequestedInternal.isRevision, isTrue);
      expect(TaskStatus.revisionRequestedClient.isRevision, isTrue);
      expect(TaskStatus.approved.isDone, isTrue);
      expect(TaskStatus.completed.isDone, isTrue);
      expect(TaskStatus.toDo.isDone, isFalse);
    });

    test('ServiceModel quota labels for counted and percentage services', () {
      const quantityService = ServiceModel(
        id: 's1',
        name: 'Design',
        isQuantityBased: true,
        contractedQty: 5,
        consumedQty: 3,
      );
      expect(quantityService.quotaLabel, '3/5');

      const projectService = ServiceModel(
        id: 's2',
        name: 'Website',
        isQuantityBased: false,
        progressPercent: 62,
      );
      expect(projectService.quotaLabel, '62%');
    });

    test('WaitingOn labels and isWaiting helper', () {
      expect(WaitingOn.none.isWaiting, isFalse);
      expect(WaitingOn.client.isWaiting, isTrue);
      expect(WaitingOn.client.label, 'Waiting on Client');
      expect(WaitingOn.team.label, 'Waiting on Team');
    });

    test('CommentModel and TaskVersionModel data integrity', () {
      final comment = CommentModel(
        id: 'c1',
        authorName: 'Client',
        body: 'Approved',
        createdAt: DateTime.now(),
        isClientVisible: true,
      );
      expect(comment.isClientVisible, isTrue);

      final version = TaskVersionModel(
        versionNumber: 2,
        uploadedBy: 'Designer',
        uploadedAt: DateTime.now(),
        revisionNote: 'Updated logo sizing',
        approved: true,
      );
      expect(version.versionNumber, 2);
      expect(version.approved, isTrue);
    });
  });
}
