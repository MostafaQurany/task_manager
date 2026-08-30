// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(String userName) => "Hey ${userName}!";
  static String m1(int count) => "${count} active";
  static String m2(int count) => "${count} completed";
  static String m3(int total, int done) => "${total} items (${done} completed)";
  static String m4(String days) => "${days} Days";
  static String m5(int count) => "${count} unread notifications";
  static String m6(int version) => "Version ${version}";
  static String m7(String taskTitle) => "Blocked by: ${taskTitle}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("Task Manager"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navTimeline": MessageLookupByLibrary.simpleMessage("Timeline"),
    "navTasks": MessageLookupByLibrary.simpleMessage("Tasks"),
    "navSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "navNewTask": MessageLookupByLibrary.simpleMessage("New Task"),

    "greetingUser": m0,
    "taskSummaryTitle": MessageLookupByLibrary.simpleMessage("Task Summary"),
    "inProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search tasks, tags..."),
    "recentTasks": MessageLookupByLibrary.simpleMessage("Recent Tasks"),
    "filterActive": MessageLookupByLibrary.simpleMessage("Active"),
    "filterDone": MessageLookupByLibrary.simpleMessage("Done"),

    "dailyTimeline": MessageLookupByLibrary.simpleMessage("Daily Timeline"),
    "timelineSubtitle": MessageLookupByLibrary.simpleMessage("Today's scheduled tasks"),
    "timelineToday": MessageLookupByLibrary.simpleMessage("Today, 15 September"),

    "allTasksTitle": MessageLookupByLibrary.simpleMessage("All Tasks"),
    "activeCount": m1,
    "completedCount": m2,
    "filterAllTasks": MessageLookupByLibrary.simpleMessage("All Tasks"),
    "filterUrgent": MessageLookupByLibrary.simpleMessage("Urgent"),
    "filterInProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "urgent": MessageLookupByLibrary.simpleMessage("Urgent"),

    "filterToday": MessageLookupByLibrary.simpleMessage("Today"),
    "filterReadyToStart": MessageLookupByLibrary.simpleMessage("Ready to Start"),
    "filterBlocked": MessageLookupByLibrary.simpleMessage("Blocked"),
    "filterRevisions": MessageLookupByLibrary.simpleMessage("Revisions"),
    "filterWaitingReview": MessageLookupByLibrary.simpleMessage("Waiting for Review"),

    "statusToDo": MessageLookupByLibrary.simpleMessage("To Do"),
    "statusReadyToStart": MessageLookupByLibrary.simpleMessage("Ready to Start"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "statusInternalReview": MessageLookupByLibrary.simpleMessage("Internal Review"),
    "statusRevisionInternal": MessageLookupByLibrary.simpleMessage("Revision (Internal)"),
    "statusReadyForClientReview": MessageLookupByLibrary.simpleMessage("Ready for Client"),
    "statusClientReview": MessageLookupByLibrary.simpleMessage("Client Review"),
    "statusRevisionClient": MessageLookupByLibrary.simpleMessage("Revision (Client)"),
    "statusApproved": MessageLookupByLibrary.simpleMessage("Approved"),
    "statusCompleted": MessageLookupByLibrary.simpleMessage("Completed"),

    "waitingOnClient": MessageLookupByLibrary.simpleMessage("Waiting on Client"),
    "waitingOnTeam": MessageLookupByLibrary.simpleMessage("Waiting on Team"),
    "waitingOnNone": MessageLookupByLibrary.simpleMessage("None"),

    "taskDetailTitle": MessageLookupByLibrary.simpleMessage("Task Detail"),
    "internalComments": MessageLookupByLibrary.simpleMessage("Internal"),
    "clientComments": MessageLookupByLibrary.simpleMessage("Client"),
    "versionHistory": MessageLookupByLibrary.simpleMessage("Version History"),
    "versionNumber": m6,
    "noComments": MessageLookupByLibrary.simpleMessage("No comments yet"),
    "noVersions": MessageLookupByLibrary.simpleMessage("No version history"),
    "addCommentHint": MessageLookupByLibrary.simpleMessage("Type a comment..."),
    "submitInternalReview": MessageLookupByLibrary.simpleMessage("Submit for Internal Review"),
    "approveAndSendToClient": MessageLookupByLibrary.simpleMessage("Approve & Send to Client"),
    "requestRevision": MessageLookupByLibrary.simpleMessage("Request Revision"),
    "blockedBy": m7,
    "service": MessageLookupByLibrary.simpleMessage("Service:"),
    "client": MessageLookupByLibrary.simpleMessage("Client:"),
    "noDependency": MessageLookupByLibrary.simpleMessage("No dependency"),
    "selectDependency": MessageLookupByLibrary.simpleMessage("Select Dependency"),
    "selectService": MessageLookupByLibrary.simpleMessage("Select Service"),
    "services": MessageLookupByLibrary.simpleMessage("Services"),

    "createTaskTitle": MessageLookupByLibrary.simpleMessage("Create Task"),
    "saveTask": MessageLookupByLibrary.simpleMessage("Save Task"),
    "taskCreated": MessageLookupByLibrary.simpleMessage("Task Created!"),
    "assignedTo": MessageLookupByLibrary.simpleMessage("Assigned to:"),
    "company": MessageLookupByLibrary.simpleMessage("Client:"),
    "dateRange": MessageLookupByLibrary.simpleMessage("Date Range:"),
    "timeRange": MessageLookupByLibrary.simpleMessage("Time Range:"),
    "description": MessageLookupByLibrary.simpleMessage("Description:"),
    "checklist": MessageLookupByLibrary.simpleMessage("Checklist:"),
    "noItems": MessageLookupByLibrary.simpleMessage("No items"),
    "checklistSummary": m3,
    "done": MessageLookupByLibrary.simpleMessage("Done"),

    "profileAndSettings": MessageLookupByLibrary.simpleMessage("Profile & Settings"),
    "preferences": MessageLookupByLibrary.simpleMessage("PREFERENCES"),
    "accountAndSecurity": MessageLookupByLibrary.simpleMessage("ACCOUNT & SECURITY"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("Push Notifications"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("English (US)"),
    "securityAndPin": MessageLookupByLibrary.simpleMessage("Security & PIN"),
    "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
    "tasksDone": MessageLookupByLibrary.simpleMessage("Tasks Done"),
    "activeTasks": MessageLookupByLibrary.simpleMessage("Active Tasks"),
    "streak": MessageLookupByLibrary.simpleMessage("Streak"),
    "daysStreak": m4,
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية (Arabic)"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),

    "notificationsTitle": MessageLookupByLibrary.simpleMessage("Notifications"),
    "unreadNotifications": m5,
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all read"),
    "noNotifications": MessageLookupByLibrary.simpleMessage("No notifications yet"),
  };
}
