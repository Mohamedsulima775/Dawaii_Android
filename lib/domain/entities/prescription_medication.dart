
// lib/features/prescription/domain/entities/prescription_medication.dart

import 'package:equatable/equatable.dart';

class PrescriptionMedication extends Equatable {
  final String medicationName;
  final String dosage;
  final String frequency; // Once Daily, Twice Daily, etc.
  final String duration; // 30 days, 1 month, etc.
  final int quantity;
  final String instructions;
  final String? itemCode; // Link to Medication Item

  const PrescriptionMedication({
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.quantity,
    required this.instructions,
    this.itemCode,
  });

  @override
  List<Object?> get props => [
    medicationName,
    dosage,
    frequency,
    duration,
    quantity,
  ];

  // Helper methods
  bool get isOnceDailyFrequency => frequency == 'Once Daily';
  bool get isTwiceDailyFrequency => frequency == 'Twice Daily';
  bool get isThriceDailyFrequency => frequency == 'Thrice Daily';
}