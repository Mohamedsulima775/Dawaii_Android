
// lib/features/medication/domain/entities/medication_log.dart

import 'package:equatable/equatable.dart';

class MedicationLog extends Equatable {
  final String id;
  final String medicationScheduleId;
  final String medicationName;
  final DateTime scheduledTime;
  final DateTime takenAt;
  final bool taken;
  final String? notes;
  final int quantityTaken;
  final DateTime createdAt;

  const MedicationLog({
    required this.id,
    required this.medicationScheduleId,
    required this.medicationName,
    required this.scheduledTime,
    required this.takenAt,
    required this.taken,
    this.notes,
    this.quantityTaken = 1,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    medicationScheduleId,
    medicationName,
    scheduledTime,
    takenAt,
    taken,
    notes,
    quantityTaken,
    createdAt,
  ];

  /// هل تم التناول في الوقت المحدد؟
  bool get isOnTime {
    final difference = takenAt.difference(scheduledTime).abs();
    return difference.inMinutes <= 15; // ±15 دقيقة
  }

  /// هل متأخر؟
  bool get isLate {
    return takenAt.isAfter(scheduledTime.add(const Duration(minutes: 15)));
  }

  /// هل مبكر؟
  bool get isEarly {
    return takenAt.isBefore(scheduledTime.subtract(const Duration(minutes: 15)));
  }

  /// الفرق بالدقائق
  int get minutesDifference {
    return takenAt.difference(scheduledTime).inMinutes;
  }
}