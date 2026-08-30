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
  String get localeName => 'ar';

  static String m0(String userName) => "مرحباً ${userName}!";
  static String m1(int count) => "${count} نشطة";
  static String m2(int count) => "${count} مكتملة";
  static String m3(int total, int done) => "${total} عناصر (${done} مكتملة)";
  static String m4(String days) => "${days} أيام";
  static String m5(int count) => "${count} إشعارات غير مقروءة";
  static String m6(int version) => "الإصدار ${version}";
  static String m7(String taskTitle) => "معلّق بسبب: ${taskTitle}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appTitle": MessageLookupByLibrary.simpleMessage("مدير المهام"),
    "navHome": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "navTimeline": MessageLookupByLibrary.simpleMessage("الجدول الزمني"),
    "navTasks": MessageLookupByLibrary.simpleMessage("المهام"),
    "navSettings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "navNewTask": MessageLookupByLibrary.simpleMessage("مهمة جديدة"),

    "greetingUser": m0,
    "taskSummaryTitle": MessageLookupByLibrary.simpleMessage("ملخص المهام"),
    "inProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "completed": MessageLookupByLibrary.simpleMessage("مكتملة"),
    "searchHint": MessageLookupByLibrary.simpleMessage("ابحث عن المهام والتصنيفات..."),
    "recentTasks": MessageLookupByLibrary.simpleMessage("المهام الأخيرة"),
    "filterActive": MessageLookupByLibrary.simpleMessage("نشطة"),
    "filterDone": MessageLookupByLibrary.simpleMessage("مكتملة"),

    "dailyTimeline": MessageLookupByLibrary.simpleMessage("الجدول اليومي"),
    "timelineSubtitle": MessageLookupByLibrary.simpleMessage("المهام المجدولة لليوم"),
    "timelineToday": MessageLookupByLibrary.simpleMessage("اليوم، 15 سبتمبر"),

    "allTasksTitle": MessageLookupByLibrary.simpleMessage("جميع المهام"),
    "activeCount": m1,
    "completedCount": m2,
    "filterAllTasks": MessageLookupByLibrary.simpleMessage("الكل"),
    "filterUrgent": MessageLookupByLibrary.simpleMessage("عاجل"),
    "filterInProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "urgent": MessageLookupByLibrary.simpleMessage("عاجل"),

    "filterToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "filterReadyToStart": MessageLookupByLibrary.simpleMessage("جاهز للبدء"),
    "filterBlocked": MessageLookupByLibrary.simpleMessage("معلّق"),
    "filterRevisions": MessageLookupByLibrary.simpleMessage("تعديلات"),
    "filterWaitingReview": MessageLookupByLibrary.simpleMessage("بانتظار المراجعة"),

    "statusToDo": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "statusReadyToStart": MessageLookupByLibrary.simpleMessage("جاهز للبدء"),
    "statusInProgress": MessageLookupByLibrary.simpleMessage("قيد التنفيذ"),
    "statusInternalReview": MessageLookupByLibrary.simpleMessage("مراجعة داخلية"),
    "statusRevisionInternal": MessageLookupByLibrary.simpleMessage("تعديل داخلي"),
    "statusReadyForClientReview": MessageLookupByLibrary.simpleMessage("جاهز للعميل"),
    "statusClientReview": MessageLookupByLibrary.simpleMessage("مراجعة العميل"),
    "statusRevisionClient": MessageLookupByLibrary.simpleMessage("تعديل مطلوب من العميل"),
    "statusApproved": MessageLookupByLibrary.simpleMessage("معتمد"),
    "statusCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),

    "waitingOnClient": MessageLookupByLibrary.simpleMessage("بانتظار العميل"),
    "waitingOnTeam": MessageLookupByLibrary.simpleMessage("بانتظار الفريق"),
    "waitingOnNone": MessageLookupByLibrary.simpleMessage("لا يوجد"),

    "taskDetailTitle": MessageLookupByLibrary.simpleMessage("تفاصيل المهمة"),
    "internalComments": MessageLookupByLibrary.simpleMessage("داخلي"),
    "clientComments": MessageLookupByLibrary.simpleMessage("العميل"),
    "versionHistory": MessageLookupByLibrary.simpleMessage("سجل الإصدارات"),
    "versionNumber": m6,
    "noComments": MessageLookupByLibrary.simpleMessage("لا توجد تعليقات بعد"),
    "noVersions": MessageLookupByLibrary.simpleMessage("لا يوجد سجل إصدارات"),
    "addCommentHint": MessageLookupByLibrary.simpleMessage("اكتب تعليقاً..."),
    "submitInternalReview": MessageLookupByLibrary.simpleMessage("إرسال للمراجعة الداخلية"),
    "approveAndSendToClient": MessageLookupByLibrary.simpleMessage("اعتماد وإرسال للعميل"),
    "requestRevision": MessageLookupByLibrary.simpleMessage("طلب تعديل"),
    "blockedBy": m7,
    "service": MessageLookupByLibrary.simpleMessage("الخدمة:"),
    "client": MessageLookupByLibrary.simpleMessage("العميل:"),
    "noDependency": MessageLookupByLibrary.simpleMessage("بدون اعتمادية"),
    "selectDependency": MessageLookupByLibrary.simpleMessage("اختر الاعتمادية"),
    "selectService": MessageLookupByLibrary.simpleMessage("اختر الخدمة"),
    "services": MessageLookupByLibrary.simpleMessage("الخدمات"),

    "createTaskTitle": MessageLookupByLibrary.simpleMessage("إنشاء مهمة"),
    "saveTask": MessageLookupByLibrary.simpleMessage("حفظ المهمة"),
    "taskCreated": MessageLookupByLibrary.simpleMessage("تم إنشاء المهمة بنجاح!"),
    "assignedTo": MessageLookupByLibrary.simpleMessage("مُسند إلى:"),
    "company": MessageLookupByLibrary.simpleMessage("العميل:"),
    "dateRange": MessageLookupByLibrary.simpleMessage("الفترة الزمنية:"),
    "timeRange": MessageLookupByLibrary.simpleMessage("نطاق الوقت:"),
    "description": MessageLookupByLibrary.simpleMessage("الوصف:"),
    "checklist": MessageLookupByLibrary.simpleMessage("قائمة التحقق:"),
    "noItems": MessageLookupByLibrary.simpleMessage("لا توجد عناصر"),
    "checklistSummary": m3,
    "done": MessageLookupByLibrary.simpleMessage("تم"),

    "profileAndSettings": MessageLookupByLibrary.simpleMessage("الملف الشخصي والإعدادات"),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "accountAndSecurity": MessageLookupByLibrary.simpleMessage("الحساب والأمان"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("الإشعارات الفورية"),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("العربية (Arabic)"),
    "securityAndPin": MessageLookupByLibrary.simpleMessage("الأمان ورمز PIN"),
    "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "tasksDone": MessageLookupByLibrary.simpleMessage("المهام المنجزة"),
    "activeTasks": MessageLookupByLibrary.simpleMessage("المهام النشطة"),
    "streak": MessageLookupByLibrary.simpleMessage("سلسلة الإنجاز"),
    "daysStreak": m4,
    "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
    "english": MessageLookupByLibrary.simpleMessage("English (الإنجليزية)"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية (Arabic)"),
    "edit": MessageLookupByLibrary.simpleMessage("تعديل"),

    "notificationsTitle": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "unreadNotifications": m5,
    "markAllRead": MessageLookupByLibrary.simpleMessage("تحديد الكل كمقروء"),
    "noNotifications": MessageLookupByLibrary.simpleMessage("لا توجد إشعارات حالياً"),
  };
}
