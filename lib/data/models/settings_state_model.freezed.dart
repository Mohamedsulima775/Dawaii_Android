// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsStateModel _$SettingsStateModelFromJson(Map<String, dynamic> json) {
  return _SettingsStateModel.fromJson(json);
}

/// @nodoc
mixin _$SettingsStateModel {
// معلومات المستخدم
  String? get patientId => throw _privateConstructorUsedError;
  String? get patientName => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profileImage =>
      throw _privateConstructorUsedError; // إعدادات التنبيهات
  bool get medicationRemindersEnabled => throw _privateConstructorUsedError;
  bool get lowStockAlertsEnabled => throw _privateConstructorUsedError;
  bool get consultationNotificationsEnabled =>
      throw _privateConstructorUsedError;
  bool get orderStatusNotificationsEnabled =>
      throw _privateConstructorUsedError;
  int get reminderMinutesBefore =>
      throw _privateConstructorUsedError; // كم دقيقة قبل الموعد
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get vibrationEnabled =>
      throw _privateConstructorUsedError; // إعدادات اللغة والثيم
  String get language => throw _privateConstructorUsedError; // 'ar' or 'en'
  String get themeMode =>
      throw _privateConstructorUsedError; // 'light', 'dark', 'system'
  double get fontSize => throw _privateConstructorUsedError; // حجم الخط
// إعدادات الأمان
  bool get biometricEnabled => throw _privateConstructorUsedError;
  bool get pinCodeEnabled => throw _privateConstructorUsedError;
  String? get pinCode => throw _privateConstructorUsedError;
  int get autoLockMinutes =>
      throw _privateConstructorUsedError; // قفل تلقائي بعد كم دقيقة
// إعدادات الخصوصية
  bool get shareHealthDataWithDoctor => throw _privateConstructorUsedError;
  bool get allowMarketingNotifications => throw _privateConstructorUsedError;
  bool get showAdherenceToCaregiver =>
      throw _privateConstructorUsedError; // إعدادات المزامنة
  bool get autoSync => throw _privateConstructorUsedError;
  String get syncMode =>
      throw _privateConstructorUsedError; // 'wifi_only', 'wifi_and_mobile', 'manual'
  DateTime? get lastSyncTime =>
      throw _privateConstructorUsedError; // إعدادات العرض
  bool get showMedicationImages => throw _privateConstructorUsedError;
  bool get showAdherencePercentage => throw _privateConstructorUsedError;
  bool get showConsecutiveDays => throw _privateConstructorUsedError;
  String get homeLayoutMode =>
      throw _privateConstructorUsedError; // 'grid', 'list'
// إعدادات متقدمة
  bool get developerMode => throw _privateConstructorUsedError;
  String? get fcmToken =>
      throw _privateConstructorUsedError; // Firebase Cloud Messaging token
  bool get analyticsEnabled =>
      throw _privateConstructorUsedError; // حالة التحميل والأخطاء
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this SettingsStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateModelCopyWith<SettingsStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateModelCopyWith<$Res> {
  factory $SettingsStateModelCopyWith(
          SettingsStateModel value, $Res Function(SettingsStateModel) then) =
      _$SettingsStateModelCopyWithImpl<$Res, SettingsStateModel>;
  @useResult
  $Res call(
      {String? patientId,
      String? patientName,
      String? mobile,
      String? email,
      String? profileImage,
      bool medicationRemindersEnabled,
      bool lowStockAlertsEnabled,
      bool consultationNotificationsEnabled,
      bool orderStatusNotificationsEnabled,
      int reminderMinutesBefore,
      bool soundEnabled,
      bool vibrationEnabled,
      String language,
      String themeMode,
      double fontSize,
      bool biometricEnabled,
      bool pinCodeEnabled,
      String? pinCode,
      int autoLockMinutes,
      bool shareHealthDataWithDoctor,
      bool allowMarketingNotifications,
      bool showAdherenceToCaregiver,
      bool autoSync,
      String syncMode,
      DateTime? lastSyncTime,
      bool showMedicationImages,
      bool showAdherencePercentage,
      bool showConsecutiveDays,
      String homeLayoutMode,
      bool developerMode,
      String? fcmToken,
      bool analyticsEnabled,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$SettingsStateModelCopyWithImpl<$Res, $Val extends SettingsStateModel>
    implements $SettingsStateModelCopyWith<$Res> {
  _$SettingsStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? patientName = freezed,
    Object? mobile = freezed,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? medicationRemindersEnabled = null,
    Object? lowStockAlertsEnabled = null,
    Object? consultationNotificationsEnabled = null,
    Object? orderStatusNotificationsEnabled = null,
    Object? reminderMinutesBefore = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? language = null,
    Object? themeMode = null,
    Object? fontSize = null,
    Object? biometricEnabled = null,
    Object? pinCodeEnabled = null,
    Object? pinCode = freezed,
    Object? autoLockMinutes = null,
    Object? shareHealthDataWithDoctor = null,
    Object? allowMarketingNotifications = null,
    Object? showAdherenceToCaregiver = null,
    Object? autoSync = null,
    Object? syncMode = null,
    Object? lastSyncTime = freezed,
    Object? showMedicationImages = null,
    Object? showAdherencePercentage = null,
    Object? showConsecutiveDays = null,
    Object? homeLayoutMode = null,
    Object? developerMode = null,
    Object? fcmToken = freezed,
    Object? analyticsEnabled = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      medicationRemindersEnabled: null == medicationRemindersEnabled
          ? _value.medicationRemindersEnabled
          : medicationRemindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lowStockAlertsEnabled: null == lowStockAlertsEnabled
          ? _value.lowStockAlertsEnabled
          : lowStockAlertsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      consultationNotificationsEnabled: null == consultationNotificationsEnabled
          ? _value.consultationNotificationsEnabled
          : consultationNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      orderStatusNotificationsEnabled: null == orderStatusNotificationsEnabled
          ? _value.orderStatusNotificationsEnabled
          : orderStatusNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderMinutesBefore: null == reminderMinutesBefore
          ? _value.reminderMinutesBefore
          : reminderMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      biometricEnabled: null == biometricEnabled
          ? _value.biometricEnabled
          : biometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pinCodeEnabled: null == pinCodeEnabled
          ? _value.pinCodeEnabled
          : pinCodeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pinCode: freezed == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String?,
      autoLockMinutes: null == autoLockMinutes
          ? _value.autoLockMinutes
          : autoLockMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      shareHealthDataWithDoctor: null == shareHealthDataWithDoctor
          ? _value.shareHealthDataWithDoctor
          : shareHealthDataWithDoctor // ignore: cast_nullable_to_non_nullable
              as bool,
      allowMarketingNotifications: null == allowMarketingNotifications
          ? _value.allowMarketingNotifications
          : allowMarketingNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      showAdherenceToCaregiver: null == showAdherenceToCaregiver
          ? _value.showAdherenceToCaregiver
          : showAdherenceToCaregiver // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showMedicationImages: null == showMedicationImages
          ? _value.showMedicationImages
          : showMedicationImages // ignore: cast_nullable_to_non_nullable
              as bool,
      showAdherencePercentage: null == showAdherencePercentage
          ? _value.showAdherencePercentage
          : showAdherencePercentage // ignore: cast_nullable_to_non_nullable
              as bool,
      showConsecutiveDays: null == showConsecutiveDays
          ? _value.showConsecutiveDays
          : showConsecutiveDays // ignore: cast_nullable_to_non_nullable
              as bool,
      homeLayoutMode: null == homeLayoutMode
          ? _value.homeLayoutMode
          : homeLayoutMode // ignore: cast_nullable_to_non_nullable
              as String,
      developerMode: null == developerMode
          ? _value.developerMode
          : developerMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      analyticsEnabled: null == analyticsEnabled
          ? _value.analyticsEnabled
          : analyticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsStateModelImplCopyWith<$Res>
    implements $SettingsStateModelCopyWith<$Res> {
  factory _$$SettingsStateModelImplCopyWith(_$SettingsStateModelImpl value,
          $Res Function(_$SettingsStateModelImpl) then) =
      __$$SettingsStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? patientId,
      String? patientName,
      String? mobile,
      String? email,
      String? profileImage,
      bool medicationRemindersEnabled,
      bool lowStockAlertsEnabled,
      bool consultationNotificationsEnabled,
      bool orderStatusNotificationsEnabled,
      int reminderMinutesBefore,
      bool soundEnabled,
      bool vibrationEnabled,
      String language,
      String themeMode,
      double fontSize,
      bool biometricEnabled,
      bool pinCodeEnabled,
      String? pinCode,
      int autoLockMinutes,
      bool shareHealthDataWithDoctor,
      bool allowMarketingNotifications,
      bool showAdherenceToCaregiver,
      bool autoSync,
      String syncMode,
      DateTime? lastSyncTime,
      bool showMedicationImages,
      bool showAdherencePercentage,
      bool showConsecutiveDays,
      String homeLayoutMode,
      bool developerMode,
      String? fcmToken,
      bool analyticsEnabled,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$SettingsStateModelImplCopyWithImpl<$Res>
    extends _$SettingsStateModelCopyWithImpl<$Res, _$SettingsStateModelImpl>
    implements _$$SettingsStateModelImplCopyWith<$Res> {
  __$$SettingsStateModelImplCopyWithImpl(_$SettingsStateModelImpl _value,
      $Res Function(_$SettingsStateModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientId = freezed,
    Object? patientName = freezed,
    Object? mobile = freezed,
    Object? email = freezed,
    Object? profileImage = freezed,
    Object? medicationRemindersEnabled = null,
    Object? lowStockAlertsEnabled = null,
    Object? consultationNotificationsEnabled = null,
    Object? orderStatusNotificationsEnabled = null,
    Object? reminderMinutesBefore = null,
    Object? soundEnabled = null,
    Object? vibrationEnabled = null,
    Object? language = null,
    Object? themeMode = null,
    Object? fontSize = null,
    Object? biometricEnabled = null,
    Object? pinCodeEnabled = null,
    Object? pinCode = freezed,
    Object? autoLockMinutes = null,
    Object? shareHealthDataWithDoctor = null,
    Object? allowMarketingNotifications = null,
    Object? showAdherenceToCaregiver = null,
    Object? autoSync = null,
    Object? syncMode = null,
    Object? lastSyncTime = freezed,
    Object? showMedicationImages = null,
    Object? showAdherencePercentage = null,
    Object? showConsecutiveDays = null,
    Object? homeLayoutMode = null,
    Object? developerMode = null,
    Object? fcmToken = freezed,
    Object? analyticsEnabled = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SettingsStateModelImpl(
      patientId: freezed == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String?,
      patientName: freezed == patientName
          ? _value.patientName
          : patientName // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      medicationRemindersEnabled: null == medicationRemindersEnabled
          ? _value.medicationRemindersEnabled
          : medicationRemindersEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lowStockAlertsEnabled: null == lowStockAlertsEnabled
          ? _value.lowStockAlertsEnabled
          : lowStockAlertsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      consultationNotificationsEnabled: null == consultationNotificationsEnabled
          ? _value.consultationNotificationsEnabled
          : consultationNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      orderStatusNotificationsEnabled: null == orderStatusNotificationsEnabled
          ? _value.orderStatusNotificationsEnabled
          : orderStatusNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      reminderMinutesBefore: null == reminderMinutesBefore
          ? _value.reminderMinutesBefore
          : reminderMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      vibrationEnabled: null == vibrationEnabled
          ? _value.vibrationEnabled
          : vibrationEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
      biometricEnabled: null == biometricEnabled
          ? _value.biometricEnabled
          : biometricEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pinCodeEnabled: null == pinCodeEnabled
          ? _value.pinCodeEnabled
          : pinCodeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pinCode: freezed == pinCode
          ? _value.pinCode
          : pinCode // ignore: cast_nullable_to_non_nullable
              as String?,
      autoLockMinutes: null == autoLockMinutes
          ? _value.autoLockMinutes
          : autoLockMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      shareHealthDataWithDoctor: null == shareHealthDataWithDoctor
          ? _value.shareHealthDataWithDoctor
          : shareHealthDataWithDoctor // ignore: cast_nullable_to_non_nullable
              as bool,
      allowMarketingNotifications: null == allowMarketingNotifications
          ? _value.allowMarketingNotifications
          : allowMarketingNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      showAdherenceToCaregiver: null == showAdherenceToCaregiver
          ? _value.showAdherenceToCaregiver
          : showAdherenceToCaregiver // ignore: cast_nullable_to_non_nullable
              as bool,
      autoSync: null == autoSync
          ? _value.autoSync
          : autoSync // ignore: cast_nullable_to_non_nullable
              as bool,
      syncMode: null == syncMode
          ? _value.syncMode
          : syncMode // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: freezed == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      showMedicationImages: null == showMedicationImages
          ? _value.showMedicationImages
          : showMedicationImages // ignore: cast_nullable_to_non_nullable
              as bool,
      showAdherencePercentage: null == showAdherencePercentage
          ? _value.showAdherencePercentage
          : showAdherencePercentage // ignore: cast_nullable_to_non_nullable
              as bool,
      showConsecutiveDays: null == showConsecutiveDays
          ? _value.showConsecutiveDays
          : showConsecutiveDays // ignore: cast_nullable_to_non_nullable
              as bool,
      homeLayoutMode: null == homeLayoutMode
          ? _value.homeLayoutMode
          : homeLayoutMode // ignore: cast_nullable_to_non_nullable
              as String,
      developerMode: null == developerMode
          ? _value.developerMode
          : developerMode // ignore: cast_nullable_to_non_nullable
              as bool,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      analyticsEnabled: null == analyticsEnabled
          ? _value.analyticsEnabled
          : analyticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsStateModelImpl implements _SettingsStateModel {
  const _$SettingsStateModelImpl(
      {this.patientId,
      this.patientName,
      this.mobile,
      this.email,
      this.profileImage,
      this.medicationRemindersEnabled = true,
      this.lowStockAlertsEnabled = true,
      this.consultationNotificationsEnabled = true,
      this.orderStatusNotificationsEnabled = true,
      this.reminderMinutesBefore = 5,
      this.soundEnabled = true,
      this.vibrationEnabled = true,
      this.language = 'ar',
      this.themeMode = 'light',
      this.fontSize = 16.0,
      this.biometricEnabled = false,
      this.pinCodeEnabled = false,
      this.pinCode,
      this.autoLockMinutes = 30,
      this.shareHealthDataWithDoctor = true,
      this.allowMarketingNotifications = false,
      this.showAdherenceToCaregiver = true,
      this.autoSync = true,
      this.syncMode = 'wifi_only',
      this.lastSyncTime,
      this.showMedicationImages = true,
      this.showAdherencePercentage = true,
      this.showConsecutiveDays = true,
      this.homeLayoutMode = 'grid',
      this.developerMode = false,
      this.fcmToken,
      this.analyticsEnabled = false,
      this.isLoading = false,
      this.errorMessage});

  factory _$SettingsStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsStateModelImplFromJson(json);

// معلومات المستخدم
  @override
  final String? patientId;
  @override
  final String? patientName;
  @override
  final String? mobile;
  @override
  final String? email;
  @override
  final String? profileImage;
// إعدادات التنبيهات
  @override
  @JsonKey()
  final bool medicationRemindersEnabled;
  @override
  @JsonKey()
  final bool lowStockAlertsEnabled;
  @override
  @JsonKey()
  final bool consultationNotificationsEnabled;
  @override
  @JsonKey()
  final bool orderStatusNotificationsEnabled;
  @override
  @JsonKey()
  final int reminderMinutesBefore;
// كم دقيقة قبل الموعد
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool vibrationEnabled;
// إعدادات اللغة والثيم
  @override
  @JsonKey()
  final String language;
// 'ar' or 'en'
  @override
  @JsonKey()
  final String themeMode;
// 'light', 'dark', 'system'
  @override
  @JsonKey()
  final double fontSize;
// حجم الخط
// إعدادات الأمان
  @override
  @JsonKey()
  final bool biometricEnabled;
  @override
  @JsonKey()
  final bool pinCodeEnabled;
  @override
  final String? pinCode;
  @override
  @JsonKey()
  final int autoLockMinutes;
// قفل تلقائي بعد كم دقيقة
// إعدادات الخصوصية
  @override
  @JsonKey()
  final bool shareHealthDataWithDoctor;
  @override
  @JsonKey()
  final bool allowMarketingNotifications;
  @override
  @JsonKey()
  final bool showAdherenceToCaregiver;
// إعدادات المزامنة
  @override
  @JsonKey()
  final bool autoSync;
  @override
  @JsonKey()
  final String syncMode;
// 'wifi_only', 'wifi_and_mobile', 'manual'
  @override
  final DateTime? lastSyncTime;
// إعدادات العرض
  @override
  @JsonKey()
  final bool showMedicationImages;
  @override
  @JsonKey()
  final bool showAdherencePercentage;
  @override
  @JsonKey()
  final bool showConsecutiveDays;
  @override
  @JsonKey()
  final String homeLayoutMode;
// 'grid', 'list'
// إعدادات متقدمة
  @override
  @JsonKey()
  final bool developerMode;
  @override
  final String? fcmToken;
// Firebase Cloud Messaging token
  @override
  @JsonKey()
  final bool analyticsEnabled;
// حالة التحميل والأخطاء
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SettingsStateModel(patientId: $patientId, patientName: $patientName, mobile: $mobile, email: $email, profileImage: $profileImage, medicationRemindersEnabled: $medicationRemindersEnabled, lowStockAlertsEnabled: $lowStockAlertsEnabled, consultationNotificationsEnabled: $consultationNotificationsEnabled, orderStatusNotificationsEnabled: $orderStatusNotificationsEnabled, reminderMinutesBefore: $reminderMinutesBefore, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, language: $language, themeMode: $themeMode, fontSize: $fontSize, biometricEnabled: $biometricEnabled, pinCodeEnabled: $pinCodeEnabled, pinCode: $pinCode, autoLockMinutes: $autoLockMinutes, shareHealthDataWithDoctor: $shareHealthDataWithDoctor, allowMarketingNotifications: $allowMarketingNotifications, showAdherenceToCaregiver: $showAdherenceToCaregiver, autoSync: $autoSync, syncMode: $syncMode, lastSyncTime: $lastSyncTime, showMedicationImages: $showMedicationImages, showAdherencePercentage: $showAdherencePercentage, showConsecutiveDays: $showConsecutiveDays, homeLayoutMode: $homeLayoutMode, developerMode: $developerMode, fcmToken: $fcmToken, analyticsEnabled: $analyticsEnabled, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateModelImpl &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.medicationRemindersEnabled, medicationRemindersEnabled) ||
                other.medicationRemindersEnabled ==
                    medicationRemindersEnabled) &&
            (identical(other.lowStockAlertsEnabled, lowStockAlertsEnabled) ||
                other.lowStockAlertsEnabled == lowStockAlertsEnabled) &&
            (identical(other.consultationNotificationsEnabled, consultationNotificationsEnabled) ||
                other.consultationNotificationsEnabled ==
                    consultationNotificationsEnabled) &&
            (identical(other.orderStatusNotificationsEnabled, orderStatusNotificationsEnabled) ||
                other.orderStatusNotificationsEnabled ==
                    orderStatusNotificationsEnabled) &&
            (identical(other.reminderMinutesBefore, reminderMinutesBefore) ||
                other.reminderMinutesBefore == reminderMinutesBefore) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.vibrationEnabled, vibrationEnabled) ||
                other.vibrationEnabled == vibrationEnabled) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.biometricEnabled, biometricEnabled) ||
                other.biometricEnabled == biometricEnabled) &&
            (identical(other.pinCodeEnabled, pinCodeEnabled) ||
                other.pinCodeEnabled == pinCodeEnabled) &&
            (identical(other.pinCode, pinCode) || other.pinCode == pinCode) &&
            (identical(other.autoLockMinutes, autoLockMinutes) ||
                other.autoLockMinutes == autoLockMinutes) &&
            (identical(other.shareHealthDataWithDoctor, shareHealthDataWithDoctor) ||
                other.shareHealthDataWithDoctor == shareHealthDataWithDoctor) &&
            (identical(other.allowMarketingNotifications, allowMarketingNotifications) ||
                other.allowMarketingNotifications ==
                    allowMarketingNotifications) &&
            (identical(other.showAdherenceToCaregiver, showAdherenceToCaregiver) ||
                other.showAdherenceToCaregiver == showAdherenceToCaregiver) &&
            (identical(other.autoSync, autoSync) ||
                other.autoSync == autoSync) &&
            (identical(other.syncMode, syncMode) ||
                other.syncMode == syncMode) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.showMedicationImages, showMedicationImages) || other.showMedicationImages == showMedicationImages) &&
            (identical(other.showAdherencePercentage, showAdherencePercentage) || other.showAdherencePercentage == showAdherencePercentage) &&
            (identical(other.showConsecutiveDays, showConsecutiveDays) || other.showConsecutiveDays == showConsecutiveDays) &&
            (identical(other.homeLayoutMode, homeLayoutMode) || other.homeLayoutMode == homeLayoutMode) &&
            (identical(other.developerMode, developerMode) || other.developerMode == developerMode) &&
            (identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken) &&
            (identical(other.analyticsEnabled, analyticsEnabled) || other.analyticsEnabled == analyticsEnabled) &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        patientId,
        patientName,
        mobile,
        email,
        profileImage,
        medicationRemindersEnabled,
        lowStockAlertsEnabled,
        consultationNotificationsEnabled,
        orderStatusNotificationsEnabled,
        reminderMinutesBefore,
        soundEnabled,
        vibrationEnabled,
        language,
        themeMode,
        fontSize,
        biometricEnabled,
        pinCodeEnabled,
        pinCode,
        autoLockMinutes,
        shareHealthDataWithDoctor,
        allowMarketingNotifications,
        showAdherenceToCaregiver,
        autoSync,
        syncMode,
        lastSyncTime,
        showMedicationImages,
        showAdherencePercentage,
        showConsecutiveDays,
        homeLayoutMode,
        developerMode,
        fcmToken,
        analyticsEnabled,
        isLoading,
        errorMessage
      ]);

  /// Create a copy of SettingsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateModelImplCopyWith<_$SettingsStateModelImpl> get copyWith =>
      __$$SettingsStateModelImplCopyWithImpl<_$SettingsStateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsStateModelImplToJson(
      this,
    );
  }
}

abstract class _SettingsStateModel implements SettingsStateModel {
  const factory _SettingsStateModel(
      {final String? patientId,
      final String? patientName,
      final String? mobile,
      final String? email,
      final String? profileImage,
      final bool medicationRemindersEnabled,
      final bool lowStockAlertsEnabled,
      final bool consultationNotificationsEnabled,
      final bool orderStatusNotificationsEnabled,
      final int reminderMinutesBefore,
      final bool soundEnabled,
      final bool vibrationEnabled,
      final String language,
      final String themeMode,
      final double fontSize,
      final bool biometricEnabled,
      final bool pinCodeEnabled,
      final String? pinCode,
      final int autoLockMinutes,
      final bool shareHealthDataWithDoctor,
      final bool allowMarketingNotifications,
      final bool showAdherenceToCaregiver,
      final bool autoSync,
      final String syncMode,
      final DateTime? lastSyncTime,
      final bool showMedicationImages,
      final bool showAdherencePercentage,
      final bool showConsecutiveDays,
      final String homeLayoutMode,
      final bool developerMode,
      final String? fcmToken,
      final bool analyticsEnabled,
      final bool isLoading,
      final String? errorMessage}) = _$SettingsStateModelImpl;

  factory _SettingsStateModel.fromJson(Map<String, dynamic> json) =
      _$SettingsStateModelImpl.fromJson;

// معلومات المستخدم
  @override
  String? get patientId;
  @override
  String? get patientName;
  @override
  String? get mobile;
  @override
  String? get email;
  @override
  String? get profileImage; // إعدادات التنبيهات
  @override
  bool get medicationRemindersEnabled;
  @override
  bool get lowStockAlertsEnabled;
  @override
  bool get consultationNotificationsEnabled;
  @override
  bool get orderStatusNotificationsEnabled;
  @override
  int get reminderMinutesBefore; // كم دقيقة قبل الموعد
  @override
  bool get soundEnabled;
  @override
  bool get vibrationEnabled; // إعدادات اللغة والثيم
  @override
  String get language; // 'ar' or 'en'
  @override
  String get themeMode; // 'light', 'dark', 'system'
  @override
  double get fontSize; // حجم الخط
// إعدادات الأمان
  @override
  bool get biometricEnabled;
  @override
  bool get pinCodeEnabled;
  @override
  String? get pinCode;
  @override
  int get autoLockMinutes; // قفل تلقائي بعد كم دقيقة
// إعدادات الخصوصية
  @override
  bool get shareHealthDataWithDoctor;
  @override
  bool get allowMarketingNotifications;
  @override
  bool get showAdherenceToCaregiver; // إعدادات المزامنة
  @override
  bool get autoSync;
  @override
  String get syncMode; // 'wifi_only', 'wifi_and_mobile', 'manual'
  @override
  DateTime? get lastSyncTime; // إعدادات العرض
  @override
  bool get showMedicationImages;
  @override
  bool get showAdherencePercentage;
  @override
  bool get showConsecutiveDays;
  @override
  String get homeLayoutMode; // 'grid', 'list'
// إعدادات متقدمة
  @override
  bool get developerMode;
  @override
  String? get fcmToken; // Firebase Cloud Messaging token
  @override
  bool get analyticsEnabled; // حالة التحميل والأخطاء
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of SettingsStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateModelImplCopyWith<_$SettingsStateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSetting _$NotificationSettingFromJson(Map<String, dynamic> json) {
  return _NotificationSetting.fromJson(json);
}

/// @nodoc
mixin _$NotificationSetting {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this NotificationSetting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingCopyWith<NotificationSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingCopyWith<$Res> {
  factory $NotificationSettingCopyWith(
          NotificationSetting value, $Res Function(NotificationSetting) then) =
      _$NotificationSettingCopyWithImpl<$Res, NotificationSetting>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      bool enabled,
      String? icon});
}

/// @nodoc
class _$NotificationSettingCopyWithImpl<$Res, $Val extends NotificationSetting>
    implements $NotificationSettingCopyWith<$Res> {
  _$NotificationSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? enabled = null,
    Object? icon = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingImplCopyWith<$Res>
    implements $NotificationSettingCopyWith<$Res> {
  factory _$$NotificationSettingImplCopyWith(_$NotificationSettingImpl value,
          $Res Function(_$NotificationSettingImpl) then) =
      __$$NotificationSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      bool enabled,
      String? icon});
}

/// @nodoc
class __$$NotificationSettingImplCopyWithImpl<$Res>
    extends _$NotificationSettingCopyWithImpl<$Res, _$NotificationSettingImpl>
    implements _$$NotificationSettingImplCopyWith<$Res> {
  __$$NotificationSettingImplCopyWithImpl(_$NotificationSettingImpl _value,
      $Res Function(_$NotificationSettingImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSetting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? enabled = null,
    Object? icon = freezed,
  }) {
    return _then(_$NotificationSettingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingImpl implements _NotificationSetting {
  const _$NotificationSettingImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.enabled,
      this.icon});

  factory _$NotificationSettingImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final bool enabled;
  @override
  final String? icon;

  @override
  String toString() {
    return 'NotificationSetting(id: $id, title: $title, description: $description, enabled: $enabled, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, enabled, icon);

  /// Create a copy of NotificationSetting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingImplCopyWith<_$NotificationSettingImpl> get copyWith =>
      __$$NotificationSettingImplCopyWithImpl<_$NotificationSettingImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingImplToJson(
      this,
    );
  }
}

abstract class _NotificationSetting implements NotificationSetting {
  const factory _NotificationSetting(
      {required final String id,
      required final String title,
      required final String description,
      required final bool enabled,
      final String? icon}) = _$NotificationSettingImpl;

  factory _NotificationSetting.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  bool get enabled;
  @override
  String? get icon;

  /// Create a copy of NotificationSetting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingImplCopyWith<_$NotificationSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TimePreference {
  String get label => throw _privateConstructorUsedError;
  TimeOfDay get time => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  /// Create a copy of TimePreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimePreferenceCopyWith<TimePreference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimePreferenceCopyWith<$Res> {
  factory $TimePreferenceCopyWith(
          TimePreference value, $Res Function(TimePreference) then) =
      _$TimePreferenceCopyWithImpl<$Res, TimePreference>;
  @useResult
  $Res call({String label, TimeOfDay time, bool enabled});
}

/// @nodoc
class _$TimePreferenceCopyWithImpl<$Res, $Val extends TimePreference>
    implements $TimePreferenceCopyWith<$Res> {
  _$TimePreferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimePreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? time = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimePreferenceImplCopyWith<$Res>
    implements $TimePreferenceCopyWith<$Res> {
  factory _$$TimePreferenceImplCopyWith(_$TimePreferenceImpl value,
          $Res Function(_$TimePreferenceImpl) then) =
      __$$TimePreferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, TimeOfDay time, bool enabled});
}

/// @nodoc
class __$$TimePreferenceImplCopyWithImpl<$Res>
    extends _$TimePreferenceCopyWithImpl<$Res, _$TimePreferenceImpl>
    implements _$$TimePreferenceImplCopyWith<$Res> {
  __$$TimePreferenceImplCopyWithImpl(
      _$TimePreferenceImpl _value, $Res Function(_$TimePreferenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimePreference
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? time = null,
    Object? enabled = null,
  }) {
    return _then(_$TimePreferenceImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as TimeOfDay,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TimePreferenceImpl implements _TimePreference {
  const _$TimePreferenceImpl(
      {required this.label, required this.time, required this.enabled});

  @override
  final String label;
  @override
  final TimeOfDay time;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'TimePreference(label: $label, time: $time, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimePreferenceImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, time, enabled);

  /// Create a copy of TimePreference
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimePreferenceImplCopyWith<_$TimePreferenceImpl> get copyWith =>
      __$$TimePreferenceImplCopyWithImpl<_$TimePreferenceImpl>(
          this, _$identity);
}

abstract class _TimePreference implements TimePreference {
  const factory _TimePreference(
      {required final String label,
      required final TimeOfDay time,
      required final bool enabled}) = _$TimePreferenceImpl;

  @override
  String get label;
  @override
  TimeOfDay get time;
  @override
  bool get enabled;

  /// Create a copy of TimePreference
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimePreferenceImplCopyWith<_$TimePreferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
