
// lib/models/settings_state_model.dart

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'settings_state_model.freezed.dart';
part 'settings_state_model.g.dart';

/// نموذج حالة الإعدادات
@freezed
class SettingsStateModel with _$SettingsStateModel {
  const factory SettingsStateModel({
    // معلومات المستخدم
    String? patientId,
    String? patientName,
    String? mobile,
    String? email,
    String? profileImage,

    // إعدادات التنبيهات
    @Default(true) bool medicationRemindersEnabled,
    @Default(true) bool lowStockAlertsEnabled,
    @Default(true) bool consultationNotificationsEnabled,
    @Default(true) bool orderStatusNotificationsEnabled,
    @Default(5) int reminderMinutesBefore, // كم دقيقة قبل الموعد
    @Default(true) bool soundEnabled,
    @Default(true) bool vibrationEnabled,

    // إعدادات اللغة والثيم
    @Default('ar') String language, // 'ar' or 'en'
    @Default('light') String themeMode, // 'light', 'dark', 'system'
    @Default(16.0) double fontSize, // حجم الخط

    // إعدادات الأمان
    @Default(false) bool biometricEnabled,
    @Default(false) bool pinCodeEnabled,
    String? pinCode,
    @Default(30) int autoLockMinutes, // قفل تلقائي بعد كم دقيقة

    // إعدادات الخصوصية
    @Default(true) bool shareHealthDataWithDoctor,
    @Default(false) bool allowMarketingNotifications,
    @Default(true) bool showAdherenceToCaregiver,

    // إعدادات المزامنة
    @Default(true) bool autoSync,
    @Default('wifi_only') String syncMode, // 'wifi_only', 'wifi_and_mobile', 'manual'
    DateTime? lastSyncTime,

    // إعدادات العرض
    @Default(true) bool showMedicationImages,
    @Default(true) bool showAdherencePercentage,
    @Default(true) bool showConsecutiveDays,
    @Default('grid') String homeLayoutMode, // 'grid', 'list'

    // إعدادات متقدمة
    @Default(false) bool developerMode,
    String? fcmToken, // Firebase Cloud Messaging token
    @Default(false) bool analyticsEnabled,

    // حالة التحميل والأخطاء
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SettingsStateModel;

  factory SettingsStateModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateModelFromJson(json);
}

/// نموذج تنبيهات محددة
@freezed
class NotificationSetting with _$NotificationSetting {
  const factory NotificationSetting({
    required String id,
    required String title,
    required String description,
    required bool enabled,
    String? icon,
  }) = _NotificationSetting;

  factory NotificationSetting.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingFromJson(json);
}

/// نموذج إعدادات الوقت
@freezed
class TimePreference with _$TimePreference {
  const factory TimePreference({
    required String label,
    required TimeOfDay time,
    required bool enabled,
  }) = _TimePreference;
}

/// خيارات وضع المزامنة
enum SyncMode {
  wifiOnly('wifi_only', 'Wi-Fi فقط'),
  wifiAndMobile('wifi_and_mobile', 'Wi-Fi وبيانات الجوال'),
  manual('manual', 'يدوي');

  const SyncMode(this.value, this.label);
  final String value;
  final String label;
}

/// خيارات وضع الثيم
enum ThemeMode {
  light('light', 'فاتح'),
  dark('dark', 'داكن'),
  system('system', 'النظام');

  const ThemeMode(this.value, this.label);
  final String value;
  final String label;
}

/// خيارات اللغة
enum AppLanguage {
  arabic('ar', 'العربية'),
  english('en', 'English');

  const AppLanguage(this.value, this.label);
  final String value;
  final String label;
}