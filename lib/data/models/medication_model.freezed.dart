// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medication_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicationSchedule _$MedicationScheduleFromJson(Map<String, dynamic> json) {
  return _MedicationSchedule.fromJson(json);
}

/// @nodoc
mixin _$MedicationSchedule {
  @JsonKey(name: 'schedule_id')
  String get scheduleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'patient_id')
  String get patientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_name')
  String get medicationName => throw _privateConstructorUsedError;
  @JsonKey(name: 'scientific_name')
  String? get scientificName => throw _privateConstructorUsedError;
  String get dosage => throw _privateConstructorUsedError;
  String get frequency => throw _privateConstructorUsedError;
  List<MedicationTime> get times => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_stock')
  int get currentStock => throw _privateConstructorUsedError;
  @JsonKey(name: 'stock_unit')
  String get stockUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'daily_consumption')
  double get dailyConsumption => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_until_depletion')
  int get daysUntilDepletion => throw _privateConstructorUsedError;
  @JsonKey(name: 'color_code')
  String? get colorCode => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this MedicationSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationScheduleCopyWith<MedicationSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationScheduleCopyWith<$Res> {
  factory $MedicationScheduleCopyWith(
          MedicationSchedule value, $Res Function(MedicationSchedule) then) =
      _$MedicationScheduleCopyWithImpl<$Res, MedicationSchedule>;
  @useResult
  $Res call(
      {@JsonKey(name: 'schedule_id') String scheduleId,
      @JsonKey(name: 'patient_id') String patientId,
      @JsonKey(name: 'medication_name') String medicationName,
      @JsonKey(name: 'scientific_name') String? scientificName,
      String dosage,
      String frequency,
      List<MedicationTime> times,
      @JsonKey(name: 'current_stock') int currentStock,
      @JsonKey(name: 'stock_unit') String stockUnit,
      @JsonKey(name: 'daily_consumption') double dailyConsumption,
      @JsonKey(name: 'days_until_depletion') int daysUntilDepletion,
      @JsonKey(name: 'color_code') String? colorCode,
      String? image,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class _$MedicationScheduleCopyWithImpl<$Res, $Val extends MedicationSchedule>
    implements $MedicationScheduleCopyWith<$Res> {
  _$MedicationScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleId = null,
    Object? patientId = null,
    Object? medicationName = null,
    Object? scientificName = freezed,
    Object? dosage = null,
    Object? frequency = null,
    Object? times = null,
    Object? currentStock = null,
    Object? stockUnit = null,
    Object? dailyConsumption = null,
    Object? daysUntilDepletion = null,
    Object? colorCode = freezed,
    Object? image = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      medicationName: null == medicationName
          ? _value.medicationName
          : medicationName // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: freezed == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String?,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<MedicationTime>,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as int,
      stockUnit: null == stockUnit
          ? _value.stockUnit
          : stockUnit // ignore: cast_nullable_to_non_nullable
              as String,
      dailyConsumption: null == dailyConsumption
          ? _value.dailyConsumption
          : dailyConsumption // ignore: cast_nullable_to_non_nullable
              as double,
      daysUntilDepletion: null == daysUntilDepletion
          ? _value.daysUntilDepletion
          : daysUntilDepletion // ignore: cast_nullable_to_non_nullable
              as int,
      colorCode: freezed == colorCode
          ? _value.colorCode
          : colorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationScheduleImplCopyWith<$Res>
    implements $MedicationScheduleCopyWith<$Res> {
  factory _$$MedicationScheduleImplCopyWith(_$MedicationScheduleImpl value,
          $Res Function(_$MedicationScheduleImpl) then) =
      __$$MedicationScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'schedule_id') String scheduleId,
      @JsonKey(name: 'patient_id') String patientId,
      @JsonKey(name: 'medication_name') String medicationName,
      @JsonKey(name: 'scientific_name') String? scientificName,
      String dosage,
      String frequency,
      List<MedicationTime> times,
      @JsonKey(name: 'current_stock') int currentStock,
      @JsonKey(name: 'stock_unit') String stockUnit,
      @JsonKey(name: 'daily_consumption') double dailyConsumption,
      @JsonKey(name: 'days_until_depletion') int daysUntilDepletion,
      @JsonKey(name: 'color_code') String? colorCode,
      String? image,
      @JsonKey(name: 'is_active') bool isActive});
}

/// @nodoc
class __$$MedicationScheduleImplCopyWithImpl<$Res>
    extends _$MedicationScheduleCopyWithImpl<$Res, _$MedicationScheduleImpl>
    implements _$$MedicationScheduleImplCopyWith<$Res> {
  __$$MedicationScheduleImplCopyWithImpl(_$MedicationScheduleImpl _value,
      $Res Function(_$MedicationScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleId = null,
    Object? patientId = null,
    Object? medicationName = null,
    Object? scientificName = freezed,
    Object? dosage = null,
    Object? frequency = null,
    Object? times = null,
    Object? currentStock = null,
    Object? stockUnit = null,
    Object? dailyConsumption = null,
    Object? daysUntilDepletion = null,
    Object? colorCode = freezed,
    Object? image = freezed,
    Object? isActive = null,
  }) {
    return _then(_$MedicationScheduleImpl(
      scheduleId: null == scheduleId
          ? _value.scheduleId
          : scheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      patientId: null == patientId
          ? _value.patientId
          : patientId // ignore: cast_nullable_to_non_nullable
              as String,
      medicationName: null == medicationName
          ? _value.medicationName
          : medicationName // ignore: cast_nullable_to_non_nullable
              as String,
      scientificName: freezed == scientificName
          ? _value.scientificName
          : scientificName // ignore: cast_nullable_to_non_nullable
              as String?,
      dosage: null == dosage
          ? _value.dosage
          : dosage // ignore: cast_nullable_to_non_nullable
              as String,
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _value._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<MedicationTime>,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as int,
      stockUnit: null == stockUnit
          ? _value.stockUnit
          : stockUnit // ignore: cast_nullable_to_non_nullable
              as String,
      dailyConsumption: null == dailyConsumption
          ? _value.dailyConsumption
          : dailyConsumption // ignore: cast_nullable_to_non_nullable
              as double,
      daysUntilDepletion: null == daysUntilDepletion
          ? _value.daysUntilDepletion
          : daysUntilDepletion // ignore: cast_nullable_to_non_nullable
              as int,
      colorCode: freezed == colorCode
          ? _value.colorCode
          : colorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationScheduleImpl implements _MedicationSchedule {
  const _$MedicationScheduleImpl(
      {@JsonKey(name: 'schedule_id') required this.scheduleId,
      @JsonKey(name: 'patient_id') required this.patientId,
      @JsonKey(name: 'medication_name') required this.medicationName,
      @JsonKey(name: 'scientific_name') this.scientificName,
      required this.dosage,
      required this.frequency,
      required final List<MedicationTime> times,
      @JsonKey(name: 'current_stock') required this.currentStock,
      @JsonKey(name: 'stock_unit') required this.stockUnit,
      @JsonKey(name: 'daily_consumption') required this.dailyConsumption,
      @JsonKey(name: 'days_until_depletion') required this.daysUntilDepletion,
      @JsonKey(name: 'color_code') this.colorCode,
      this.image,
      @JsonKey(name: 'is_active') this.isActive = true})
      : _times = times;

  factory _$MedicationScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationScheduleImplFromJson(json);

  @override
  @JsonKey(name: 'schedule_id')
  final String scheduleId;
  @override
  @JsonKey(name: 'patient_id')
  final String patientId;
  @override
  @JsonKey(name: 'medication_name')
  final String medicationName;
  @override
  @JsonKey(name: 'scientific_name')
  final String? scientificName;
  @override
  final String dosage;
  @override
  final String frequency;
  final List<MedicationTime> _times;
  @override
  List<MedicationTime> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  @JsonKey(name: 'current_stock')
  final int currentStock;
  @override
  @JsonKey(name: 'stock_unit')
  final String stockUnit;
  @override
  @JsonKey(name: 'daily_consumption')
  final double dailyConsumption;
  @override
  @JsonKey(name: 'days_until_depletion')
  final int daysUntilDepletion;
  @override
  @JsonKey(name: 'color_code')
  final String? colorCode;
  @override
  final String? image;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;

  @override
  String toString() {
    return 'MedicationSchedule(scheduleId: $scheduleId, patientId: $patientId, medicationName: $medicationName, scientificName: $scientificName, dosage: $dosage, frequency: $frequency, times: $times, currentStock: $currentStock, stockUnit: $stockUnit, dailyConsumption: $dailyConsumption, daysUntilDepletion: $daysUntilDepletion, colorCode: $colorCode, image: $image, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationScheduleImpl &&
            (identical(other.scheduleId, scheduleId) ||
                other.scheduleId == scheduleId) &&
            (identical(other.patientId, patientId) ||
                other.patientId == patientId) &&
            (identical(other.medicationName, medicationName) ||
                other.medicationName == medicationName) &&
            (identical(other.scientificName, scientificName) ||
                other.scientificName == scientificName) &&
            (identical(other.dosage, dosage) || other.dosage == dosage) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(other._times, _times) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.stockUnit, stockUnit) ||
                other.stockUnit == stockUnit) &&
            (identical(other.dailyConsumption, dailyConsumption) ||
                other.dailyConsumption == dailyConsumption) &&
            (identical(other.daysUntilDepletion, daysUntilDepletion) ||
                other.daysUntilDepletion == daysUntilDepletion) &&
            (identical(other.colorCode, colorCode) ||
                other.colorCode == colorCode) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scheduleId,
      patientId,
      medicationName,
      scientificName,
      dosage,
      frequency,
      const DeepCollectionEquality().hash(_times),
      currentStock,
      stockUnit,
      dailyConsumption,
      daysUntilDepletion,
      colorCode,
      image,
      isActive);

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationScheduleImplCopyWith<_$MedicationScheduleImpl> get copyWith =>
      __$$MedicationScheduleImplCopyWithImpl<_$MedicationScheduleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationScheduleImplToJson(
      this,
    );
  }
}

abstract class _MedicationSchedule implements MedicationSchedule {
  const factory _MedicationSchedule(
      {@JsonKey(name: 'schedule_id') required final String scheduleId,
      @JsonKey(name: 'patient_id') required final String patientId,
      @JsonKey(name: 'medication_name') required final String medicationName,
      @JsonKey(name: 'scientific_name') final String? scientificName,
      required final String dosage,
      required final String frequency,
      required final List<MedicationTime> times,
      @JsonKey(name: 'current_stock') required final int currentStock,
      @JsonKey(name: 'stock_unit') required final String stockUnit,
      @JsonKey(name: 'daily_consumption')
      required final double dailyConsumption,
      @JsonKey(name: 'days_until_depletion')
      required final int daysUntilDepletion,
      @JsonKey(name: 'color_code') final String? colorCode,
      final String? image,
      @JsonKey(name: 'is_active')
      final bool isActive}) = _$MedicationScheduleImpl;

  factory _MedicationSchedule.fromJson(Map<String, dynamic> json) =
      _$MedicationScheduleImpl.fromJson;

  @override
  @JsonKey(name: 'schedule_id')
  String get scheduleId;
  @override
  @JsonKey(name: 'patient_id')
  String get patientId;
  @override
  @JsonKey(name: 'medication_name')
  String get medicationName;
  @override
  @JsonKey(name: 'scientific_name')
  String? get scientificName;
  @override
  String get dosage;
  @override
  String get frequency;
  @override
  List<MedicationTime> get times;
  @override
  @JsonKey(name: 'current_stock')
  int get currentStock;
  @override
  @JsonKey(name: 'stock_unit')
  String get stockUnit;
  @override
  @JsonKey(name: 'daily_consumption')
  double get dailyConsumption;
  @override
  @JsonKey(name: 'days_until_depletion')
  int get daysUntilDepletion;
  @override
  @JsonKey(name: 'color_code')
  String? get colorCode;
  @override
  String? get image;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;

  /// Create a copy of MedicationSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationScheduleImplCopyWith<_$MedicationScheduleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MedicationTime _$MedicationTimeFromJson(Map<String, dynamic> json) {
  return _MedicationTime.fromJson(json);
}

/// @nodoc
mixin _$MedicationTime {
  String get time => throw _privateConstructorUsedError; // "08:00"
  @JsonKey(name: 'before_after_meal')
  String? get beforeAfterMeal => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this MedicationTime to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationTimeCopyWith<MedicationTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationTimeCopyWith<$Res> {
  factory $MedicationTimeCopyWith(
          MedicationTime value, $Res Function(MedicationTime) then) =
      _$MedicationTimeCopyWithImpl<$Res, MedicationTime>;
  @useResult
  $Res call(
      {String time,
      @JsonKey(name: 'before_after_meal') String? beforeAfterMeal,
      String? notes});
}

/// @nodoc
class _$MedicationTimeCopyWithImpl<$Res, $Val extends MedicationTime>
    implements $MedicationTimeCopyWith<$Res> {
  _$MedicationTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? beforeAfterMeal = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      beforeAfterMeal: freezed == beforeAfterMeal
          ? _value.beforeAfterMeal
          : beforeAfterMeal // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationTimeImplCopyWith<$Res>
    implements $MedicationTimeCopyWith<$Res> {
  factory _$$MedicationTimeImplCopyWith(_$MedicationTimeImpl value,
          $Res Function(_$MedicationTimeImpl) then) =
      __$$MedicationTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String time,
      @JsonKey(name: 'before_after_meal') String? beforeAfterMeal,
      String? notes});
}

/// @nodoc
class __$$MedicationTimeImplCopyWithImpl<$Res>
    extends _$MedicationTimeCopyWithImpl<$Res, _$MedicationTimeImpl>
    implements _$$MedicationTimeImplCopyWith<$Res> {
  __$$MedicationTimeImplCopyWithImpl(
      _$MedicationTimeImpl _value, $Res Function(_$MedicationTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? beforeAfterMeal = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$MedicationTimeImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      beforeAfterMeal: freezed == beforeAfterMeal
          ? _value.beforeAfterMeal
          : beforeAfterMeal // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationTimeImpl implements _MedicationTime {
  const _$MedicationTimeImpl(
      {required this.time,
      @JsonKey(name: 'before_after_meal') this.beforeAfterMeal,
      this.notes});

  factory _$MedicationTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationTimeImplFromJson(json);

  @override
  final String time;
// "08:00"
  @override
  @JsonKey(name: 'before_after_meal')
  final String? beforeAfterMeal;
  @override
  final String? notes;

  @override
  String toString() {
    return 'MedicationTime(time: $time, beforeAfterMeal: $beforeAfterMeal, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationTimeImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.beforeAfterMeal, beforeAfterMeal) ||
                other.beforeAfterMeal == beforeAfterMeal) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, time, beforeAfterMeal, notes);

  /// Create a copy of MedicationTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationTimeImplCopyWith<_$MedicationTimeImpl> get copyWith =>
      __$$MedicationTimeImplCopyWithImpl<_$MedicationTimeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationTimeImplToJson(
      this,
    );
  }
}

abstract class _MedicationTime implements MedicationTime {
  const factory _MedicationTime(
      {required final String time,
      @JsonKey(name: 'before_after_meal') final String? beforeAfterMeal,
      final String? notes}) = _$MedicationTimeImpl;

  factory _MedicationTime.fromJson(Map<String, dynamic> json) =
      _$MedicationTimeImpl.fromJson;

  @override
  String get time; // "08:00"
  @override
  @JsonKey(name: 'before_after_meal')
  String? get beforeAfterMeal;
  @override
  String? get notes;

  /// Create a copy of MedicationTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationTimeImplCopyWith<_$MedicationTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MedicationLog _$MedicationLogFromJson(Map<String, dynamic> json) {
  return _MedicationLog.fromJson(json);
}

/// @nodoc
mixin _$MedicationLog {
  @JsonKey(name: 'log_id')
  String get logId => throw _privateConstructorUsedError;
  @JsonKey(name: 'medication_schedule_id')
  String get medicationScheduleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_time')
  DateTime get scheduledTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'actual_time')
  DateTime? get actualTime => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // taken, missed, skipped
  @JsonKey(name: 'skip_reason')
  String? get skipReason => throw _privateConstructorUsedError;

  /// Serializes this MedicationLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicationLogCopyWith<MedicationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicationLogCopyWith<$Res> {
  factory $MedicationLogCopyWith(
          MedicationLog value, $Res Function(MedicationLog) then) =
      _$MedicationLogCopyWithImpl<$Res, MedicationLog>;
  @useResult
  $Res call(
      {@JsonKey(name: 'log_id') String logId,
      @JsonKey(name: 'medication_schedule_id') String medicationScheduleId,
      @JsonKey(name: 'scheduled_time') DateTime scheduledTime,
      @JsonKey(name: 'actual_time') DateTime? actualTime,
      String status,
      @JsonKey(name: 'skip_reason') String? skipReason});
}

/// @nodoc
class _$MedicationLogCopyWithImpl<$Res, $Val extends MedicationLog>
    implements $MedicationLogCopyWith<$Res> {
  _$MedicationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = null,
    Object? medicationScheduleId = null,
    Object? scheduledTime = null,
    Object? actualTime = freezed,
    Object? status = null,
    Object? skipReason = freezed,
  }) {
    return _then(_value.copyWith(
      logId: null == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as String,
      medicationScheduleId: null == medicationScheduleId
          ? _value.medicationScheduleId
          : medicationScheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualTime: freezed == actualTime
          ? _value.actualTime
          : actualTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      skipReason: freezed == skipReason
          ? _value.skipReason
          : skipReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicationLogImplCopyWith<$Res>
    implements $MedicationLogCopyWith<$Res> {
  factory _$$MedicationLogImplCopyWith(
          _$MedicationLogImpl value, $Res Function(_$MedicationLogImpl) then) =
      __$$MedicationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'log_id') String logId,
      @JsonKey(name: 'medication_schedule_id') String medicationScheduleId,
      @JsonKey(name: 'scheduled_time') DateTime scheduledTime,
      @JsonKey(name: 'actual_time') DateTime? actualTime,
      String status,
      @JsonKey(name: 'skip_reason') String? skipReason});
}

/// @nodoc
class __$$MedicationLogImplCopyWithImpl<$Res>
    extends _$MedicationLogCopyWithImpl<$Res, _$MedicationLogImpl>
    implements _$$MedicationLogImplCopyWith<$Res> {
  __$$MedicationLogImplCopyWithImpl(
      _$MedicationLogImpl _value, $Res Function(_$MedicationLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = null,
    Object? medicationScheduleId = null,
    Object? scheduledTime = null,
    Object? actualTime = freezed,
    Object? status = null,
    Object? skipReason = freezed,
  }) {
    return _then(_$MedicationLogImpl(
      logId: null == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as String,
      medicationScheduleId: null == medicationScheduleId
          ? _value.medicationScheduleId
          : medicationScheduleId // ignore: cast_nullable_to_non_nullable
              as String,
      scheduledTime: null == scheduledTime
          ? _value.scheduledTime
          : scheduledTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualTime: freezed == actualTime
          ? _value.actualTime
          : actualTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      skipReason: freezed == skipReason
          ? _value.skipReason
          : skipReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicationLogImpl implements _MedicationLog {
  const _$MedicationLogImpl(
      {@JsonKey(name: 'log_id') required this.logId,
      @JsonKey(name: 'medication_schedule_id')
      required this.medicationScheduleId,
      @JsonKey(name: 'scheduled_time') required this.scheduledTime,
      @JsonKey(name: 'actual_time') this.actualTime,
      required this.status,
      @JsonKey(name: 'skip_reason') this.skipReason});

  factory _$MedicationLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicationLogImplFromJson(json);

  @override
  @JsonKey(name: 'log_id')
  final String logId;
  @override
  @JsonKey(name: 'medication_schedule_id')
  final String medicationScheduleId;
  @override
  @JsonKey(name: 'scheduled_time')
  final DateTime scheduledTime;
  @override
  @JsonKey(name: 'actual_time')
  final DateTime? actualTime;
  @override
  final String status;
// taken, missed, skipped
  @override
  @JsonKey(name: 'skip_reason')
  final String? skipReason;

  @override
  String toString() {
    return 'MedicationLog(logId: $logId, medicationScheduleId: $medicationScheduleId, scheduledTime: $scheduledTime, actualTime: $actualTime, status: $status, skipReason: $skipReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicationLogImpl &&
            (identical(other.logId, logId) || other.logId == logId) &&
            (identical(other.medicationScheduleId, medicationScheduleId) ||
                other.medicationScheduleId == medicationScheduleId) &&
            (identical(other.scheduledTime, scheduledTime) ||
                other.scheduledTime == scheduledTime) &&
            (identical(other.actualTime, actualTime) ||
                other.actualTime == actualTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.skipReason, skipReason) ||
                other.skipReason == skipReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, logId, medicationScheduleId,
      scheduledTime, actualTime, status, skipReason);

  /// Create a copy of MedicationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicationLogImplCopyWith<_$MedicationLogImpl> get copyWith =>
      __$$MedicationLogImplCopyWithImpl<_$MedicationLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicationLogImplToJson(
      this,
    );
  }
}

abstract class _MedicationLog implements MedicationLog {
  const factory _MedicationLog(
      {@JsonKey(name: 'log_id') required final String logId,
      @JsonKey(name: 'medication_schedule_id')
      required final String medicationScheduleId,
      @JsonKey(name: 'scheduled_time') required final DateTime scheduledTime,
      @JsonKey(name: 'actual_time') final DateTime? actualTime,
      required final String status,
      @JsonKey(name: 'skip_reason')
      final String? skipReason}) = _$MedicationLogImpl;

  factory _MedicationLog.fromJson(Map<String, dynamic> json) =
      _$MedicationLogImpl.fromJson;

  @override
  @JsonKey(name: 'log_id')
  String get logId;
  @override
  @JsonKey(name: 'medication_schedule_id')
  String get medicationScheduleId;
  @override
  @JsonKey(name: 'scheduled_time')
  DateTime get scheduledTime;
  @override
  @JsonKey(name: 'actual_time')
  DateTime? get actualTime;
  @override
  String get status; // taken, missed, skipped
  @override
  @JsonKey(name: 'skip_reason')
  String? get skipReason;

  /// Create a copy of MedicationLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicationLogImplCopyWith<_$MedicationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
