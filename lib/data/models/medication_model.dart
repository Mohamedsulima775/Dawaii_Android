//lib/data/models/medication_model.dart

// lib/models/medication_model.dart
/*
import 'dart:ui';

import 'package:flutter/material.dart';

class Medication {
  final String id;
  final String medicationName;
  final String? scientificName;
  final String dosage;
  final String frequency;
  final String? instructions;
  final int currentStock;
  final int? daysUntilDepletion;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final String? category;
  final String? reminderTime;
  final List<MedicationTime>? times;

  Medication({
    required this.id,
    required this.medicationName,
    this.scientificName,
    required this.dosage,
    required this.frequency,
    this.instructions,
    required this.currentStock,
    this.daysUntilDepletion,
    required this.startDate,
    this.endDate,
    required this.isActive,
    this.category,
    this.reminderTime,
    this.times,
  });

  // From JSON
  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['name'] ?? '',
      medicationName: json['medication_name'] ?? '',
      scientificName: json['scientific_name'],
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      instructions: json['instructions'],
      currentStock: json['current_stock'] ?? 0,
      daysUntilDepletion: json['days_until_depletion'],
      startDate: DateTime.parse(json['start_date']),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      category: json['category'],
      reminderTime: json['reminder_time'],
      times: json['times'] != null
          ? (json['times'] as List)
          .map((t) => MedicationTime.fromJson(t))
          .toList()
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'medication_name': medicationName,
      'scientific_name': scientificName,
      'dosage': dosage,
      'frequency': frequency,
      'instructions': instructions,
      'current_stock': currentStock,
      'days_until_depletion': daysUntilDepletion,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive ? 1 : 0,
      'category': category,
      'reminder_time': reminderTime,
      'times': times?.map((t) => t.toJson()).toList(),
    };
  }

  // Copy with
  Medication copyWith({
    String? id,
    String? medicationName,
    String? scientificName,
    String? dosage,
    String? frequency,
    String? instructions,
    int? currentStock,
    int? daysUntilDepletion,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    String? category,
    String? reminderTime,
    List<MedicationTime>? times,
  }) {
    return Medication(
      id: id ?? this.id,
      medicationName: medicationName ?? this.medicationName,
      scientificName: scientificName ?? this.scientificName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      instructions: instructions ?? this.instructions,
      currentStock: currentStock ?? this.currentStock,
      daysUntilDepletion: daysUntilDepletion ?? this.daysUntilDepletion,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      category: category ?? this.category,
      reminderTime: reminderTime ?? this.reminderTime,
      times: times ?? this.times,
    );
  }

  // Stock status
  String get stockStatus {
    if (daysUntilDepletion == null) return 'جيد';
    if (daysUntilDepletion! <= 2) return 'حرج';
    if (daysUntilDepletion! <= 5) return 'منخفض';
    return 'جيد';
  }

  // Stock color
  Color get stockColor {
    if (daysUntilDepletion == null) return Colors.green;
    if (daysUntilDepletion! <= 2) return Colors.red;
    if (daysUntilDepletion! <= 5) return Colors.orange;
    return Colors.green;
  }
}

// Medication Time Model
class MedicationTime {
  final String time;
  final bool taken;
  final DateTime? takenAt;

  MedicationTime({
    required this.time,
    required this.taken,
    this.takenAt,
  });

  factory MedicationTime.fromJson(Map<String, dynamic> json) {
    return MedicationTime(
      time: json['time'] ?? '',
      taken: json['taken'] == 1 || json['taken'] == true,
      takenAt: json['taken_at'] != null
          ? DateTime.parse(json['taken_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'taken': taken ? 1 : 0,
      'taken_at': takenAt?.toIso8601String(),
    };
  }
}

// Medication Log Model
class MedicationLog {
  final String id;
  final String medicationSchedule;
  final String medicationName;
  final DateTime takenAt;
  final String? notes;

  MedicationLog({
    required this.id,
    required this.medicationSchedule,
    required this.medicationName,
    required this.takenAt,
    this.notes,
  });

  factory MedicationLog.fromJson(Map<String, dynamic> json) {
    return MedicationLog(
      id: json['name'] ?? '',
      medicationSchedule: json['medication_schedule'] ?? '',
      medicationName: json['medication_name'] ?? '',
      takenAt: DateTime.parse(json['taken_at']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'medication_schedule': medicationSchedule,
      'medication_name': medicationName,
      'taken_at': takenAt.toIso8601String(),
      'notes': notes,
    };
  }
}
*/




// الاول
import 'package:freezed_annotation/freezed_annotation.dart';
part 'medication_model.freezed.dart';
part 'medication_model.g.dart';

@freezed
class MedicationSchedule with _$MedicationSchedule {
  const factory MedicationSchedule({
    @JsonKey(name: 'schedule_id') required String scheduleId,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'medication_name') required String medicationName,
    @JsonKey(name: 'scientific_name') String? scientificName,
    required String dosage,
    required String frequency,
    required List<MedicationTime> times,
    @JsonKey(name: 'current_stock') required int currentStock,
    @JsonKey(name: 'stock_unit') required String stockUnit,
    @JsonKey(name: 'daily_consumption') required double dailyConsumption,
    @JsonKey(name: 'days_until_depletion') required int daysUntilDepletion,
    @JsonKey(name: 'color_code') String? colorCode,
    String? image,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
  }) = _MedicationSchedule;

  factory MedicationSchedule.fromJson(Map<String, dynamic> json) =>
      _$MedicationScheduleFromJson(json);
}

@freezed
class MedicationTime with _$MedicationTime {
  const factory MedicationTime({
    required String time, // "08:00"
    @JsonKey(name: 'before_after_meal') String? beforeAfterMeal,
    String? notes,
  }) = _MedicationTime;

  factory MedicationTime.fromJson(Map<String, dynamic> json) =>
      _$MedicationTimeFromJson(json);
}

@freezed
class MedicationLog with _$MedicationLog {
  const factory MedicationLog({
    @JsonKey(name: 'log_id') required String logId,
    @JsonKey(name: 'medication_schedule_id') required String medicationScheduleId,
    @JsonKey(name: 'scheduled_time') required DateTime scheduledTime,
    @JsonKey(name: 'actual_time') DateTime? actualTime,
    required String status, // taken, missed, skipped
    @JsonKey(name: 'skip_reason') String? skipReason,
  }) = _MedicationLog;

  factory MedicationLog.fromJson(Map<String, dynamic> json) =>
      _$MedicationLogFromJson(json);
}



