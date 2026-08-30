// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appTitle => Intl.message('Task Manager', name: 'appTitle', desc: '');
  String get navHome => Intl.message('Home', name: 'navHome', desc: '');
  String get navTimeline => Intl.message('Timeline', name: 'navTimeline', desc: '');
  String get navTasks => Intl.message('Tasks', name: 'navTasks', desc: '');
  String get navSettings => Intl.message('Settings', name: 'navSettings', desc: '');
  String get navNewTask => Intl.message('New Task', name: 'navNewTask', desc: '');

  String greetingUser(String userName) => Intl.message(
    'Hey $userName!',
    name: 'greetingUser',
    args: [userName],
    desc: '',
  );

  String get taskSummaryTitle => Intl.message('Task Summary', name: 'taskSummaryTitle', desc: '');
  String get inProgress => Intl.message('In Progress', name: 'inProgress', desc: '');
  String get completed => Intl.message('Completed', name: 'completed', desc: '');
  String get searchHint => Intl.message('Search tasks, tags...', name: 'searchHint', desc: '');
  String get recentTasks => Intl.message('Recent Tasks', name: 'recentTasks', desc: '');
  String get filterActive => Intl.message('Active', name: 'filterActive', desc: '');
  String get filterDone => Intl.message('Done', name: 'filterDone', desc: '');

  String get dailyTimeline => Intl.message('Daily Timeline', name: 'dailyTimeline', desc: '');
  String get timelineSubtitle => Intl.message("Today's scheduled tasks", name: 'timelineSubtitle', desc: '');
  String get timelineToday => Intl.message('Today, 15 September', name: 'timelineToday', desc: '');

  String get allTasksTitle => Intl.message('All Tasks', name: 'allTasksTitle', desc: '');
  String activeCount(int count) => Intl.message('$count active', name: 'activeCount', args: [count], desc: '');
  String completedCount(int count) => Intl.message('$count completed', name: 'completedCount', args: [count], desc: '');
  String get filterAllTasks => Intl.message('All Tasks', name: 'filterAllTasks', desc: '');
  String get filterUrgent => Intl.message('Urgent', name: 'filterUrgent', desc: '');
  String get filterInProgress => Intl.message('In Progress', name: 'filterInProgress', desc: '');
  String get urgent => Intl.message('Urgent', name: 'urgent', desc: '');

  String get filterToday => Intl.message('Today', name: 'filterToday', desc: '');
  String get filterReadyToStart => Intl.message('Ready to Start', name: 'filterReadyToStart', desc: '');
  String get filterBlocked => Intl.message('Blocked', name: 'filterBlocked', desc: '');
  String get filterRevisions => Intl.message('Revisions', name: 'filterRevisions', desc: '');
  String get filterWaitingReview => Intl.message('Waiting for Review', name: 'filterWaitingReview', desc: '');

  String get statusToDo => Intl.message('To Do', name: 'statusToDo', desc: '');
  String get statusReadyToStart => Intl.message('Ready to Start', name: 'statusReadyToStart', desc: '');
  String get statusInProgress => Intl.message('In Progress', name: 'statusInProgress', desc: '');
  String get statusInternalReview => Intl.message('Internal Review', name: 'statusInternalReview', desc: '');
  String get statusRevisionInternal => Intl.message('Revision (Internal)', name: 'statusRevisionInternal', desc: '');
  String get statusReadyForClientReview => Intl.message('Ready for Client', name: 'statusReadyForClientReview', desc: '');
  String get statusClientReview => Intl.message('Client Review', name: 'statusClientReview', desc: '');
  String get statusRevisionClient => Intl.message('Revision (Client)', name: 'statusRevisionClient', desc: '');
  String get statusApproved => Intl.message('Approved', name: 'statusApproved', desc: '');
  String get statusCompleted => Intl.message('Completed', name: 'statusCompleted', desc: '');

  String get waitingOnClient => Intl.message('Waiting on Client', name: 'waitingOnClient', desc: '');
  String get waitingOnTeam => Intl.message('Waiting on Team', name: 'waitingOnTeam', desc: '');
  String get waitingOnNone => Intl.message('None', name: 'waitingOnNone', desc: '');

  String get taskDetailTitle => Intl.message('Task Detail', name: 'taskDetailTitle', desc: '');
  String get internalComments => Intl.message('Internal', name: 'internalComments', desc: '');
  String get clientComments => Intl.message('Client', name: 'clientComments', desc: '');
  String get versionHistory => Intl.message('Version History', name: 'versionHistory', desc: '');
  String versionNumber(int version) => Intl.message('Version $version', name: 'versionNumber', args: [version], desc: '');
  String get noComments => Intl.message('No comments yet', name: 'noComments', desc: '');
  String get noVersions => Intl.message('No version history', name: 'noVersions', desc: '');
  String get addCommentHint => Intl.message('Type a comment...', name: 'addCommentHint', desc: '');
  String get submitInternalReview => Intl.message('Submit for Internal Review', name: 'submitInternalReview', desc: '');
  String get approveAndSendToClient => Intl.message('Approve & Send to Client', name: 'approveAndSendToClient', desc: '');
  String get requestRevision => Intl.message('Request Revision', name: 'requestRevision', desc: '');
  String blockedBy(String taskTitle) => Intl.message('Blocked by: $taskTitle', name: 'blockedBy', args: [taskTitle], desc: '');
  String get service => Intl.message('Service:', name: 'service', desc: '');
  String get client => Intl.message('Client:', name: 'client', desc: '');
  String get noDependency => Intl.message('No dependency', name: 'noDependency', desc: '');
  String get selectDependency => Intl.message('Select Dependency', name: 'selectDependency', desc: '');
  String get selectService => Intl.message('Select Service', name: 'selectService', desc: '');
  String get services => Intl.message('Services', name: 'services', desc: '');

  String get createTaskTitle => Intl.message('Create Task', name: 'createTaskTitle', desc: '');
  String get saveTask => Intl.message('Save Task', name: 'saveTask', desc: '');
  String get taskCreated => Intl.message('Task Created!', name: 'taskCreated', desc: '');
  String get assignedTo => Intl.message('Assigned to:', name: 'assignedTo', desc: '');
  String get company => Intl.message('Client:', name: 'company', desc: '');
  String get dateRange => Intl.message('Date Range:', name: 'dateRange', desc: '');
  String get timeRange => Intl.message('Time Range:', name: 'timeRange', desc: '');
  String get description => Intl.message('Description:', name: 'description', desc: '');
  String get checklist => Intl.message('Checklist:', name: 'checklist', desc: '');
  String get noItems => Intl.message('No items', name: 'noItems', desc: '');
  String checklistSummary(int total, int done) => Intl.message('$total items ($done completed)', name: 'checklistSummary', args: [total, done], desc: '');
  String get done => Intl.message('Done', name: 'done', desc: '');

  String get profileAndSettings => Intl.message('Profile & Settings', name: 'profileAndSettings', desc: '');
  String get preferences => Intl.message('PREFERENCES', name: 'preferences', desc: '');
  String get accountAndSecurity => Intl.message('ACCOUNT & SECURITY', name: 'accountAndSecurity', desc: '');
  String get pushNotifications => Intl.message('Push Notifications', name: 'pushNotifications', desc: '');
  String get language => Intl.message('Language', name: 'language', desc: '');
  String get currentLanguage => Intl.message('English (US)', name: 'currentLanguage', desc: '');
  String get securityAndPin => Intl.message('Security & PIN', name: 'securityAndPin', desc: '');
  String get logOut => Intl.message('Log Out', name: 'logOut', desc: '');
  String get tasksDone => Intl.message('Tasks Done', name: 'tasksDone', desc: '');
  String get activeTasks => Intl.message('Active Tasks', name: 'activeTasks', desc: '');
  String get streak => Intl.message('Streak', name: 'streak', desc: '');
  String daysStreak(String days) => Intl.message('$days Days', name: 'daysStreak', args: [days], desc: '');
  String get selectLanguage => Intl.message('Select Language', name: 'selectLanguage', desc: '');
  String get english => Intl.message('English', name: 'english', desc: '');
  String get arabic => Intl.message('العربية (Arabic)', name: 'arabic', desc: '');
  String get edit => Intl.message('Edit', name: 'edit', desc: '');

  String get notificationsTitle => Intl.message('Notifications', name: 'notificationsTitle', desc: '');
  String unreadNotifications(int count) => Intl.message('$count unread notifications', name: 'unreadNotifications', args: [count], desc: '');
  String get markAllRead => Intl.message('Mark all read', name: 'markAllRead', desc: '');
  String get noNotifications => Intl.message('No notifications yet', name: 'noNotifications', desc: '');
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
