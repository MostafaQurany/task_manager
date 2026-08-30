import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/services/storage_service.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    try {
      final prefs = ref.watch(sharedPreferencesProvider);
      final savedCode = prefs.getString(StorageKeys.appLanguageCode);
      if (savedCode != null && (savedCode == 'ar' || savedCode == 'en')) {
        return Locale(savedCode);
      }
    } catch (_) {
      // Fallback if sharedPreferencesProvider is not provided in test harness
    }
    return const Locale('en');
  }

  Future<void> setLocale(Locale newLocale) async {
    if (state != newLocale) {
      state = newLocale;
      try {
        final prefs = ref.read(sharedPreferencesProvider);
        await prefs.setString(StorageKeys.appLanguageCode, newLocale.languageCode);
      } catch (_) {}
    }
  }

  Future<void> toggleLocale() async {
    final nextLocale = state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    await setLocale(nextLocale);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(() {
  return LocaleNotifier();
});
