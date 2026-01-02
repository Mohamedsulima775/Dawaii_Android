
// lib/providers/settings_provider.dart

import 'package:dawaii/data/models/settings_state_model.dart';
import 'package:dawaii/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
// import '../services/api_service.dart';
import 'package:dawaii/services/notification_service.dart';
import 'package:dawaii/services/biometric_service.dart';

import 'api_service.dart';
import 'notification_service.dart';

/// Provider رئيسي للإعدادات
final settingsProvider =
StateNotifierProvider<SettingsNotifier, SettingsStateModel>((ref) {
  return SettingsNotifier(ref);
});

/// Notifier لإدارة حالة الإعدادات
class SettingsNotifier extends StateNotifier<SettingsStateModel> {
  final Ref ref;
  late Box settingsBox;
  SharedPreferences? prefs;

  SettingsNotifier(this.ref) : super(const SettingsStateModel()) {
    _init();
  }

  /// التهيئة الأولية
  Future<void> _init() async {
    try {
      // فتح Hive box
      settingsBox = await Hive.openBox('settings');

      // تحميل SharedPreferences
      prefs = await SharedPreferences.getInstance();

      // تحميل الإعدادات المحفوظة
      await loadSettings();
    } catch (e) {
      print('Error initializing settings: $e');
    }
  }

  // ============================================
  // تحميل وحفظ الإعدادات
  // ============================================

  /// تحميل الإعدادات من Local Storage
  Future<void> loadSettings() async {
    try {
      state = state.copyWith(isLoading: true);

      // محاولة التحميل من Hive أولاً
      final savedSettings = settingsBox.get('settings');

      if (savedSettings != null) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(savedSettings);
        state = SettingsStateModel.fromJson(json);
      }

      // مزامنة مع الخادم إذا كانت المزامنة التلقائية مفعّلة
      if (state.autoSync) {
        await syncWithServer();
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'فشل تحميل الإعدادات: $e',
      );
    }
  }

  /// حفظ الإعدادات محلياً
  Future<void> saveSettings() async {
    try {
      // حفظ في Hive
      await settingsBox.put('settings', state.toJson());

      // حفظ قيم مهمة في SharedPreferences (للوصول السريع)
      await prefs?.setString('language', state.language);
      await prefs?.setString('themeMode', state.themeMode);
      await prefs?.setBool('biometricEnabled', state.biometricEnabled);

      // مزامنة مع الخادم
      if (state.autoSync) {
        await syncWithServer();
      }
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  /// مزامنة مع الخادم
  Future<void> syncWithServer() async {
    try {
      if (state.patientId == null) return;

      // إرسال الإعدادات للخادم
      final apiService = ref.read(apiServiceProvider);
      await apiService.updatePatientSettings(
        patientId: state.patientId!,
        settings: state.toJson(),
      );

      state = state.copyWith(lastSyncTime: DateTime.now());
      await saveSettings();
    } catch (e) {
      print('Sync error: $e');
    }
  }

  // ============================================
  // معلومات المستخدم
  // ============================================

  /// تحديث معلومات المستخدم
  void updateUserInfo({
    String? patientId,
    String? patientName,
    String? mobile,
    String? email,
    String? profileImage,
  }) {
    state = state.copyWith(
      patientId: patientId ?? state.patientId,
      patientName: patientName ?? state.patientName,
      mobile: mobile ?? state.mobile,
      email: email ?? state.email,
      profileImage: profileImage ?? state.profileImage,
    );
    saveSettings();
  }

  // ============================================
  // إعدادات التنبيهات
  // ============================================

  /// تفعيل/تعطيل تذكيرات الأدوية
  Future<void> toggleMedicationReminders(bool enabled) async {
    state = state.copyWith(medicationRemindersEnabled: enabled);

    // تحديث خدمة الإشعارات
    final notificationService = ref.read(notificationServiceProvider);
    if (enabled) {
      await notificationService.enableMedicationReminders();
    } else {
      await notificationService.disableMedicationReminders();
    }

    await saveSettings();
  }

  /// تفعيل/تعطيل تنبيهات نفاد الدواء
  void toggleLowStockAlerts(bool enabled) {
    state = state.copyWith(lowStockAlertsEnabled: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل إشعارات الاستشارات
  void toggleConsultationNotifications(bool enabled) {
    state = state.copyWith(consultationNotificationsEnabled: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل إشعارات الطلبات
  void toggleOrderStatusNotifications(bool enabled) {
    state = state.copyWith(orderStatusNotificationsEnabled: enabled);
    saveSettings();
  }

  /// تغيير عدد دقائق التذكير قبل الموعد
  void setReminderMinutesBefore(int minutes) {
    state = state.copyWith(reminderMinutesBefore: minutes);
    saveSettings();
  }

  /// تفعيل/تعطيل الصوت
  void toggleSound(bool enabled) {
    state = state.copyWith(soundEnabled: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل الاهتزاز
  void toggleVibration(bool enabled) {
    state = state.copyWith(vibrationEnabled: enabled);
    saveSettings();
  }

  // ============================================
  // إعدادات اللغة والثيم
  // ============================================

  /// تغيير اللغة
  Future<void> changeLanguage(String language) async {
    state = state.copyWith(language: language);
    await saveSettings();
    // إعادة تحميل التطبيق بلغة جديدة
    // يمكن استخدام easy_localization أو intl
  }

  /// تغيير وضع الثيم
  void changeThemeMode(String themeMode) {
    state = state.copyWith(themeMode: themeMode);
    saveSettings();
  }

  /// تغيير حجم الخط
  void changeFontSize(double fontSize) {
    state = state.copyWith(fontSize: fontSize);
    saveSettings();
  }

  // ============================================
  // إعدادات الأمان
  // ============================================

  /// تفعيل/تعطيل البصمة
  Future<void> toggleBiometric(bool enabled) async {
    if (enabled) {
      final biometricService = ref.read(biometricServiceProvider);
      final canAuthenticate = await biometricService.canAuthenticate();

      if (!canAuthenticate) {
        state = state.copyWith(
          errorMessage: 'البصمة غير متاحة على هذا الجهاز',
        );
        return;
      }

      final authenticated = await biometricService.authenticate();
      if (!authenticated) {
        state = state.copyWith(
          errorMessage: 'فشل التحقق من البصمة',
        );
        return;
      }
    }

    state = state.copyWith(biometricEnabled: enabled);
    await saveSettings();
  }

  /// تفعيل/تعطيل رمز PIN
  void togglePinCode(bool enabled, {String? pinCode}) {
    state = state.copyWith(
      pinCodeEnabled: enabled,
      pinCode: pinCode,
    );
    saveSettings();
  }

  /// تغيير رمز PIN
  void changePinCode(String newPinCode) {
    state = state.copyWith(pinCode: newPinCode);
    saveSettings();
  }

  /// تغيير وقت القفل التلقائي
  void setAutoLockMinutes(int minutes) {
    state = state.copyWith(autoLockMinutes: minutes);
    saveSettings();
  }

  // ============================================
  // إعدادات الخصوصية
  // ============================================

  /// تفعيل/تعطيل مشاركة البيانات مع الطبيب
  void toggleShareHealthData(bool enabled) {
    state = state.copyWith(shareHealthDataWithDoctor: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل الإشعارات التسويقية
  void toggleMarketingNotifications(bool enabled) {
    state = state.copyWith(allowMarketingNotifications: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل عرض الالتزام للمراقب
  void toggleShowAdherenceToCaregiver(bool enabled) {
    state = state.copyWith(showAdherenceToCaregiver: enabled);
    saveSettings();
  }

  // ============================================
  // إعدادات المزامنة
  // ============================================

  /// تفعيل/تعطيل المزامنة التلقائية
  void toggleAutoSync(bool enabled) {
    state = state.copyWith(autoSync: enabled);
    saveSettings();
  }

  /// تغيير وضع المزامنة
  void changeSyncMode(String syncMode) {
    state = state.copyWith(syncMode: syncMode);
    saveSettings();
  }

  /// مزامنة يدوية
  Future<void> manualSync() async {
    state = state.copyWith(isLoading: true);
    await syncWithServer();
    state = state.copyWith(isLoading: false);
  }

  // ============================================
  // إعدادات العرض
  // ============================================

  /// تفعيل/تعطيل عرض صور الأدوية
  void toggleShowMedicationImages(bool enabled) {
    state = state.copyWith(showMedicationImages: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل عرض نسبة الالتزام
  void toggleShowAdherencePercentage(bool enabled) {
    state = state.copyWith(showAdherencePercentage: enabled);
    saveSettings();
  }

  /// تفعيل/تعطيل عرض الأيام المتتالية
  void toggleShowConsecutiveDays(bool enabled) {
    state = state.copyWith(showConsecutiveDays: enabled);
    saveSettings();
  }

  /// تغيير وضع العرض الرئيسي
  void changeHomeLayoutMode(String mode) {
    state = state.copyWith(homeLayoutMode: mode);
    saveSettings();
  }

  // ============================================
  // إعدادات متقدمة
  // ============================================

  /// تفعيل/تعطيل وضع المطور
  void toggleDeveloperMode(bool enabled) {
    state = state.copyWith(developerMode: enabled);
    saveSettings();
  }

  /// تحديث FCM Token
  void updateFCMToken(String token) {
    state = state.copyWith(fcmToken: token);
    saveSettings();
  }

  /// تفعيل/تعطيل التحليلات
  void toggleAnalytics(bool enabled) {
    state = state.copyWith(analyticsEnabled: enabled);
    saveSettings();
  }

  // ============================================
  // إعادة تعيين وحذف
  // ============================================

  /// إعادة تعيين جميع الإعدادات للافتراضي
  Future<void> resetToDefault() async {
    state = const SettingsStateModel();
    await settingsBox.clear();
    await prefs?.clear();
  }

  /// حذف جميع البيانات المحلية
  Future<void> clearAllData() async {
    await settingsBox.clear();
    await prefs?.clear();
    await Hive.deleteBoxFromDisk('medications');
    await Hive.deleteBoxFromDisk('logs');
    state = const SettingsStateModel();
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    await clearAllData();
    // التنقل إلى شاشة تسجيل الدخول
  }
}

// ============================================
// Providers إضافية مفيدة
// ============================================

/// Provider للغة الحالية
final currentLanguageProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider.select((s) => s.language));
});

/// Provider لوضع الثيم الحالي
final currentThemeModeProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider.select((s) => s.themeMode));
});

/// Provider لحالة البصمة
final biometricEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider.select((s) => s.biometricEnabled));
});

/// Provider لحالة التنبيهات
final notificationsEnabledProvider = Provider<bool>((ref) {
  final settings = ref.watch(settingsProvider);
  return settings.medicationRemindersEnabled ||
      settings.lowStockAlertsEnabled ||
      settings.consultationNotificationsEnabled ||
      settings.orderStatusNotificationsEnabled;
});