
// lib/features/prescription/data/models/prescription_medication_model.dart

import '../../domain/entities/prescription_medication.dart';

class PrescriptionMedicationModel extends PrescriptionMedication {
  const PrescriptionMedicationModel({
    required super.medicationName,
    required super.dosage,
    required super.frequency,
    required super.duration,
    required super.quantity,
    required super.instructions,
    super.itemCode,
  });

  factory PrescriptionMedicationModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionMedicationModel(
      medicationName: json['medication_name'] ?? '',
      dosage: json['dosage'] ?? '',
      frequency: json['frequency'] ?? '',
      duration: json['duration'] ?? '',
      quantity: json['quantity'] ?? 0,
      instructions: json['instructions'] ?? '',
      itemCode: json['item_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medication_name': medicationName,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'quantity': quantity,
      'instructions': instructions,
      'item_code': itemCode,
    };
  }
}