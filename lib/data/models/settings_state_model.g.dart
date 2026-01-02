// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateModelImpl _$$SettingsStateModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsStateModelImpl(
      patientId: json['patientId'] as String?,
      patientName: json['patientName'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      profileImage: json['profileImage'] as String?,
      medicationRemindersEnabled:
          json['medicationRemindersEnabled'] as bool? ?? true,
      lowStockAlertsEnabled: json['lowStockAlertsEnabled'] as bool? ?? true,
      consultationNotificationsEnabled:
          json['consultationNotificationsEnabled'] as bool? ?? true,
      orderStatusNotificationsEnabled:
          json['orderStatusNotificationsEnabled'] as bool? ?? true,
      reminderMinutesBefore:
          (json['reminderMinutesBefore'] as num?)?.toInt() ?? 5,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      language: json['language'] as String? ?? 'ar',
      themeMode: json['themeMode'] as String? ?? 'light',
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16.0,
      biometricEnabled: json['biometricEnabled'] as bool? ?? false,
      pinCodeEnabled: json['pinCodeEnabled'] as bool? ?? false,
      pinCode: json['pinCode'] as String?,
      autoLockMinutes: (json['autoLockMinutes'] as num?)?.toInt() ?? 30,
      shareHealthDataWithDoctor:
          json['shareHealthDataWithDoctor'] as bool? ?? true,
      allowMarketingNotifications:
          json['allowMarketingNotifications'] as bool? ?? false,
      showAdherenceToCaregiver:
          json['showAdherenceToCaregiver'] as bool? ?? true,
      autoSync: json['autoSync'] as bool? ?? true,
      syncMode: json['syncMode'] as String? ?? 'wifi_only',
      lastSyncTime: json['lastSyncTime'] == null
          ? null
          : DateTime.parse(json['lastSyncTime'] as String),
      showMedicationImages: json['showMedicationImages'] as bool? ?? true,
      showAdherencePercentage: json['showAdherencePercentage'] as bool? ?? true,
      showConsecutiveDays: json['showConsecutiveDays'] as bool? ?? true,
      homeLayoutMode: json['homeLayoutMode'] as String? ?? 'grid',
      developerMode: json['developerMode'] as bool? ?? false,
      fcmToken: json['fcmToken'] as String?,
      analyticsEnabled: json['analyticsEnabled'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$SettingsStateModelImplToJson(
        _$SettingsStateModelImpl instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'patientName': instance.patientName,
      'mobile': instance.mobile,
      'email': instance.email,
      'profileImage': instance.profileImage,
      'medicationRemindersEnabled': instance.medicationRemindersEnabled,
      'lowStockAlertsEnabled': instance.lowStockAlertsEnabled,
      'consultationNotificationsEnabled':
          instance.consultationNotificationsEnabled,
      'orderStatusNotificationsEnabled':
          instance.orderStatusNotificationsEnabled,
      'reminderMinutesBefore': instance.reminderMinutesBefore,
      'soundEnabled': instance.soundEnabled,
      'vibrationEnabled': instance.vibrationEnabled,
      'language': instance.language,
      'themeMode': instance.themeMode,
      'fontSize': instance.fontSize,
      'biometricEnabled': instance.biometricEnabled,
      'pinCodeEnabled': instance.pinCodeEnabled,
      'pinCode': instance.pinCode,
      'autoLockMinutes': instance.autoLockMinutes,
      'shareHealthDataWithDoctor': instance.shareHealthDataWithDoctor,
      'allowMarketingNotifications': instance.allowMarketingNotifications,
      'showAdherenceToCaregiver': instance.showAdherenceToCaregiver,
      'autoSync': instance.autoSync,
      'syncMode': instance.syncMode,
      'lastSyncTime': instance.lastSyncTime?.toIso8601String(),
      'showMedicationImages': instance.showMedicationImages,
      'showAdherencePercentage': instance.showAdherencePercentage,
      'showConsecutiveDays': instance.showConsecutiveDays,
      'homeLayoutMode': instance.homeLayoutMode,
      'developerMode': instance.developerMode,
      'fcmToken': instance.fcmToken,
      'analyticsEnabled': instance.analyticsEnabled,
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
    };

_$NotificationSettingImpl _$$NotificationSettingImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      enabled: json['enabled'] as bool,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$NotificationSettingImplToJson(
        _$NotificationSettingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'enabled': instance.enabled,
      'icon': instance.icon,
    };
