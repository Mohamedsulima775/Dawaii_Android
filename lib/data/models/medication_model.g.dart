// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MedicationScheduleImpl _$$MedicationScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicationScheduleImpl(
      scheduleId: json['schedule_id'] as String,
      patientId: json['patient_id'] as String,
      medicationName: json['medication_name'] as String,
      scientificName: json['scientific_name'] as String?,
      dosage: json['dosage'] as String,
      frequency: json['frequency'] as String,
      times: (json['times'] as List<dynamic>)
          .map((e) => MedicationTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentStock: (json['current_stock'] as num).toInt(),
      stockUnit: json['stock_unit'] as String,
      dailyConsumption: (json['daily_consumption'] as num).toDouble(),
      daysUntilDepletion: (json['days_until_depletion'] as num).toInt(),
      colorCode: json['color_code'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );

Map<String, dynamic> _$$MedicationScheduleImplToJson(
        _$MedicationScheduleImpl instance) =>
    <String, dynamic>{
      'schedule_id': instance.scheduleId,
      'patient_id': instance.patientId,
      'medication_name': instance.medicationName,
      'scientific_name': instance.scientificName,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'times': instance.times,
      'current_stock': instance.currentStock,
      'stock_unit': instance.stockUnit,
      'daily_consumption': instance.dailyConsumption,
      'days_until_depletion': instance.daysUntilDepletion,
      'color_code': instance.colorCode,
      'image': instance.image,
      'is_active': instance.isActive,
    };

_$MedicationTimeImpl _$$MedicationTimeImplFromJson(Map<String, dynamic> json) =>
    _$MedicationTimeImpl(
      time: json['time'] as String,
      beforeAfterMeal: json['before_after_meal'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$MedicationTimeImplToJson(
        _$MedicationTimeImpl instance) =>
    <String, dynamic>{
      'time': instance.time,
      'before_after_meal': instance.beforeAfterMeal,
      'notes': instance.notes,
    };

_$MedicationLogImpl _$$MedicationLogImplFromJson(Map<String, dynamic> json) =>
    _$MedicationLogImpl(
      logId: json['log_id'] as String,
      medicationScheduleId: json['medication_schedule_id'] as String,
      scheduledTime: DateTime.parse(json['scheduled_time'] as String),
      actualTime: json['actual_time'] == null
          ? null
          : DateTime.parse(json['actual_time'] as String),
      status: json['status'] as String,
      skipReason: json['skip_reason'] as String?,
    );

Map<String, dynamic> _$$MedicationLogImplToJson(_$MedicationLogImpl instance) =>
    <String, dynamic>{
      'log_id': instance.logId,
      'medication_schedule_id': instance.medicationScheduleId,
      'scheduled_time': instance.scheduledTime.toIso8601String(),
      'actual_time': instance.actualTime?.toIso8601String(),
      'status': instance.status,
      'skip_reason': instance.skipReason,
    };
