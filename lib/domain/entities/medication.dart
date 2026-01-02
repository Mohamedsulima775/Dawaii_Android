

// domain/entities/medication.dart
/*
//الاول
class Medication {
  final String id;
  final String patientId;
  final String name;
  final String? scientificName;
  final String dosage;
  final String frequency;
  final List<MedicationTime> times;
  final int currentStock;
  final String stockUnit;
  final double dailyConsumption;
  final int daysUntilDepletion;
  final String? beforeAfterMeal;
  final String? duration;
  final String? instructions;
  final String? sideEffects;
  final String? notes;
  final String? image;
  final String? colorCode;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? lastRefillDate;
  final DateTime createdAt;

  const Medication({
    required this.id,
    required this.patientId,
    required this.name,
    this.scientificName,
    required this.dosage,
    required this.frequency,
    required this.times,
    required this.currentStock,
    this.stockUnit = 'حبة',
    required this.dailyConsumption,
    required this.daysUntilDepletion,
    this.beforeAfterMeal,
    this.duration,
    this.instructions,
    this.sideEffects,
    this.notes,
    this.image,
    this.colorCode,
    this.isActive = true,
    this.startDate,
    this.endDate,
    this.lastRefillDate,
    required this.createdAt,
  });

  // Create empty medication
  factory Medication.empty() {
    return Medication(
      id: '',
      patientId: '',
      name: '',
      dosage: '',
      frequency: '',
      times: const [],
      currentStock: 0,
      dailyConsumption: 0,
      daysUntilDepletion: 0,
      createdAt: DateTime.now(),
    );
  }

  // Copy with method
  Medication copyWith({
    String? id,
    String? patientId,
    String? name,
    String? scientificName,
    String? dosage,
    String? frequency,
    List<MedicationTime>? times,
    int? currentStock,
    String? stockUnit,
    double? dailyConsumption,
    int? daysUntilDepletion,
    String? beforeAfterMeal,
    String? duration,
    String? instructions,
    String? sideEffects,
    String? notes,
    String? image,
    String? colorCode,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastRefillDate,
    DateTime? createdAt,
  }) {
    return Medication(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      currentStock: currentStock ?? this.currentStock,
      stockUnit: stockUnit ?? this.stockUnit,
      dailyConsumption: dailyConsumption ?? this.dailyConsumption,
      daysUntilDepletion: daysUntilDepletion ?? this.daysUntilDepletion,
      beforeAfterMeal: beforeAfterMeal ?? this.beforeAfterMeal,
      duration: duration ?? this.duration,
      instructions: instructions ?? this.instructions,
      sideEffects: sideEffects ?? this.sideEffects,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      colorCode: colorCode ?? this.colorCode,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lastRefillDate: lastRefillDate ?? this.lastRefillDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Check if medication is low on stock
  bool get isLowStock => daysUntilDepletion <= 5 && daysUntilDepletion > 0;

  // Check if medication is out of stock
  bool get isOutOfStock => currentStock <= 0;

  // Check if medication needs urgent refill
  bool get needsUrgentRefill => daysUntilDepletion <= 2;

  // Get stock status
  StockStatus get stockStatus {
    if (isOutOfStock) return StockStatus.outOfStock;
    if (needsUrgentRefill) return StockStatus.critical;
    if (isLowStock) return StockStatus.low;
    return StockStatus.sufficient;
  }

  // Get next time to take medication
  DateTime? getNextMedicationTime() {
    if (times.isEmpty) return null;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Check today's times
    for (final time in times) {
      final medicationDateTime = DateTime(
        today.year,
        today.month,
        today.day,
        time.hour,
        time.minute,
      );

      if (medicationDateTime.isAfter(now)) {
        return medicationDateTime;
      }
    }

    // If no time found today, return first time tomorrow
    if (times.isNotEmpty) {
      final tomorrow = today.add(const Duration(days: 1));
      return DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        times.first.hour,
        times.first.minute,
      );
    }

    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Medication && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Medication(id: $id, name: $name, dosage: $dosage, stock: $currentStock)';
  }
}

// Medication time model
class MedicationTime {
  final int hour;
  final int minute;
  final String? note;

  const MedicationTime({
    required this.hour,
    required this.minute,
    this.note,
  });

  // Get time as string (HH:mm)
  String get timeString {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  // Get time as 12-hour format
  String get time12Hour {
    final period = hour >= 12 ? 'م' : 'ص';
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m $period';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicationTime &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => timeString;
}

// Stock status enum
enum StockStatus {
  sufficient,
  low,
  critical,
  outOfStock,
}

extension StockStatusExtension on StockStatus {
  String get displayName {
    switch (this) {
      case StockStatus.sufficient:
        return 'كافي';
      case StockStatus.low:
        return 'منخفض';
      case StockStatus.critical:
        return 'حرج';
      case StockStatus.outOfStock:
        return 'نفد';
    }
  }

  String get emoji {
    switch (this) {
      case StockStatus.sufficient:
        return '✅';
      case StockStatus.low:
        return '⚠️';
      case StockStatus.critical:
        return '🚨';
      case StockStatus.outOfStock:
        return '❌';
    }
  }
}

 */


// lib/features/medication/domain/entities/medication.dart

// lib/features/medication/domain/entities/medication.dart

import 'package:equatable/equatable.dart';

/// =======================================
/// Medication Entity
/// =======================================
class Medication extends Equatable {
  final String id;
  final String patientId;

  final medicationName;
  final String scientificName;

  final String dosage;
  final String frequency;

  final List<MedicationTime> times;

  final int currentStock;
  final String stockUnit;
  final double dailyConsumption;
  final int daysUntilDepletion;

  final bool isActive;

  final String? beforeAfterMeal;
  final String? duration;
  final String? instructions;
  final String? sideEffects;
  final String? notes;

  final String? image;
  final String? colorCode;

  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? lastRefillDate;

  final DateTime createdAt;
  final DateTime modifiedAt;

  const Medication({
    required this.id,
    required this.patientId,
    required this.medicationName,
    this.scientificName = '',
    required this.dosage,
    required this.frequency,
    required this.times,
    required this.currentStock,
    this.stockUnit = 'حبة',
    required this.dailyConsumption,
    required this.daysUntilDepletion,
    this.isActive = true,
    this.beforeAfterMeal,
    this.duration,
    this.instructions,
    this.sideEffects,
    this.notes,
    this.image,
    this.colorCode,
    this.startDate,
    this.endDate,
    this.lastRefillDate,
    required this.createdAt,
    required this.modifiedAt,
  });

  /// ===============================
  /// Business Logic
  /// ===============================

  bool get isLowStock => daysUntilDepletion <= 5 && daysUntilDepletion > 0;

  bool get isOutOfStock => currentStock <= 0;

  bool get needsUrgentRefill => daysUntilDepletion <= 2;

  StockStatus get stockStatus {
    if (isOutOfStock) return StockStatus.outOfStock;
    if (needsUrgentRefill) return StockStatus.critical;
    if (isLowStock) return StockStatus.low;
    return StockStatus.sufficient;
  }

  DateTime? get nextDoseTime {
    if (times.isEmpty) return null;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final time in times) {
      final dateTime = DateTime(
        today.year,
        today.month,
        today.day,
        time.hour,
        time.minute,
      );
      if (dateTime.isAfter(now)) return dateTime;
    }

    final tomorrow = today.add(const Duration(days: 1));
    final first = times.first;
    return DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      first.hour,
      first.minute,
    );
  }

  bool get isDueSoon {
    final next = nextDoseTime;
    if (next == null) return false;
    final diff = next.difference(DateTime.now());
    return diff.inMinutes <= 30 && diff.inMinutes >= 0;
  }

  /// ===============================
  /// Copy With
  /// ===============================
  Medication copyWith({
    String? id,
    String? patientId,
    String? medicationName,
    String? scientificName,
    String? dosage,
    String? frequency,
    List<MedicationTime>? times,
    int? currentStock,
    String? stockUnit,
    double? dailyConsumption,
    int? daysUntilDepletion,
    bool? isActive,
    String? beforeAfterMeal,
    String? duration,
    String? instructions,
    String? sideEffects,
    String? notes,
    String? image,
    String? colorCode,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastRefillDate,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Medication(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      medicationName: medicationName ?? this.medicationName,
      scientificName: scientificName ?? this.scientificName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      currentStock: currentStock ?? this.currentStock,
      stockUnit: stockUnit ?? this.stockUnit,
      dailyConsumption: dailyConsumption ?? this.dailyConsumption,
      daysUntilDepletion: daysUntilDepletion ?? this.daysUntilDepletion,
      isActive: isActive ?? this.isActive,
      beforeAfterMeal: beforeAfterMeal ?? this.beforeAfterMeal,
      duration: duration ?? this.duration,
      instructions: instructions ?? this.instructions,
      sideEffects: sideEffects ?? this.sideEffects,
      notes: notes ?? this.notes,
      image: image ?? this.image,
      colorCode: colorCode ?? this.colorCode,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lastRefillDate: lastRefillDate ?? this.lastRefillDate,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    patientId,
    medicationName,
    scientificName,
    dosage,
    frequency,
    times,
    currentStock,
    stockUnit,
    dailyConsumption,
    daysUntilDepletion,
    isActive,
    beforeAfterMeal,
    duration,
    instructions,
    sideEffects,
    notes,
    image,
    colorCode,
    startDate,
    endDate,
    lastRefillDate,
    createdAt,
    modifiedAt,
  ];
}

/// =======================================
/// MedicationTime (Value Object)
/// =======================================
class MedicationTime extends Equatable {
  final int hour;
  final int minute;
  final String? note;

  const MedicationTime({
    required this.hour,
    required this.minute,
    this.note,
  });

  String get time24h =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get time12h {
    final period = hour >= 12 ? 'م' : 'ص';
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$h:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  List<Object?> get props => [hour, minute, note];
}

/// =======================================
/// Stock Status
/// =======================================
enum StockStatus {
  sufficient,
  low,
  critical,
  outOfStock,
}

extension StockStatusX on StockStatus {
  String get label {
    switch (this) {
      case StockStatus.sufficient:
        return 'كافي';
      case StockStatus.low:
        return 'منخفض';
      case StockStatus.critical:
        return 'حرج';
      case StockStatus.outOfStock:
        return 'نفد';
    }
  }

  String get emoji {
    switch (this) {
      case StockStatus.sufficient:
        return '✅';
      case StockStatus.low:
        return '⚠️';
      case StockStatus.critical:
        return '🚨';
      case StockStatus.outOfStock:
        return '❌';
    }
  }
}