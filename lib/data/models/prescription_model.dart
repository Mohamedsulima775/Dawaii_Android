// lib/features/prescription/data/models/prescription_model.dart

import '../../domain/entities/prescription.dart';
import '../../domain/entities/prescription_medication.dart';
import 'prescription_medication_model.dart';

class PrescriptionModel extends Prescription {
  const PrescriptionModel({
    required super.id,
    required super.patientId,
    required super.patientName,
    required super.doctorId,
    required super.doctorName,
    required super.prescriptionDate,
    required super.diagnosis,
    required super.instructions,
    super.followUpDate,
    required super.status,
    required super.medications,
    super.prescriptionFile,
    super.consultationId,
    required super.createdAt,
    super.modifiedAt,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      id: json['name'] ?? json['prescription_id'] ?? '',
      patientId: json['patient'] ?? '',
      patientName: json['patient_name'] ?? '',
      doctorId: json['doctor'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      prescriptionDate: DateTime.parse(json['prescription_date']),
      diagnosis: json['diagnosis'] ?? '',
      instructions: json['instructions'] ?? '',
      followUpDate: json['follow_up_date'] != null
          ? DateTime.parse(json['follow_up_date'])
          : null,
      status: json['status'] ?? 'Draft',
      medications: (json['medications'] as List?)
          ?.map((med) => PrescriptionMedicationModel.fromJson(med))
          .toList() ??
          [],
      prescriptionFile: json['prescription_file'],
      consultationId: json['consultation'],
      createdAt: DateTime.parse(
          json['creation'] ?? DateTime.now().toIso8601String()),
      modifiedAt: json['modified'] != null
          ? DateTime.parse(json['modified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'patient': patientId,
      'patient_name': patientName,
      'doctor': doctorId,
      'doctor_name': doctorName,
      'prescription_date': prescriptionDate.toIso8601String(),
      'diagnosis': diagnosis,
      'instructions': instructions,
      'follow_up_date': followUpDate?.toIso8601String(),
      'status': status,
      'medications': medications
          .map((med) => (med as PrescriptionMedicationModel).toJson())
          .toList(),
      'prescription_file': prescriptionFile,
      'consultation': consultationId,
      'creation': createdAt.toIso8601String(),
      'modified': modifiedAt?.toIso8601String(),
    };
  }

  // CopyWith method
  PrescriptionModel copyWith({
    String? id,
    String? patientId,
    String? patientName,
    String? doctorId,
    String? doctorName,
    DateTime? prescriptionDate,
    String? diagnosis,
    String? instructions,
    DateTime? followUpDate,
    String? status,
    List<PrescriptionMedication>? medications,
    String? prescriptionFile,
    String? consultationId,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      prescriptionDate: prescriptionDate ?? this.prescriptionDate,
      diagnosis: diagnosis ?? this.diagnosis,
      instructions: instructions ?? this.instructions,
      followUpDate: followUpDate ?? this.followUpDate,
      status: status ?? this.status,
      medications: medications ?? this.medications,
      prescriptionFile: prescriptionFile ?? this.prescriptionFile,
      consultationId: consultationId ?? this.consultationId,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}

  class Patient {
  final String? name;
  final String patientName;
  final String email;

  Patient({
  this.name,
  required this.patientName,
  required this.email,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
  return Patient(
  name: json['name'],
  patientName: json['patient_name'],
  email: json['email'],
  );
  }
  }





/*
class Prescription {
  final String? name;
  final String patient;
  final String? patientName;
  final String healthcareProvider;
  final String? providerName;
  final String prescriptionDate;
  final String validUntil;
  final String? diagnosis;
  final List<PrescriptionMedication> medications;
  final String? instructions;
  final String? notes;
  final String status; // Active, Partially Filled, Filled, Expired
  final int? totalMedications;
  final int? filledMedications;

  Prescription({
    this.name,
    required this.patient,
    this.patientName,
    required this.healthcareProvider,
    this.providerName,
    required this.prescriptionDate,
    required this.validUntil,
    this.diagnosis,
    required this.medications,
    this.instructions,
    this.notes,
    required this.status,
    this.totalMedications,
    this.filledMedications,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      name: json['name'],
      patient: json['patient'],
      patientName: json['patient_name'],
      healthcareProvider: json['healthcare_provider'],
      providerName: json['provider_name'],
      prescriptionDate: json['prescription_date'],
      validUntil: json['valid_until'],
      diagnosis: json['diagnosis'],
      medications: (json['medications'] as List?)
          ?.map((m) => PrescriptionMedication.fromJson(m))
          .toList() ??
          [],
      instructions: json['instructions'],
      notes: json['notes'],
      status: json['status'] ?? 'Active',
      totalMedications: json['total_medications'],
      filledMedications: json['filled_medications'],
    );
  }
}

class PrescriptionMedication {
  final String medicationName;
  final String? scientificName;
  final String dosage;
  final String frequency;
  final String duration;
  final int quantity;
  final String? instructions;
  final bool isFilled;

  PrescriptionMedication({
    required this.medicationName,
    this.scientificName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.quantity,
    this.instructions,
    this.isFilled = false,
  });

  factory PrescriptionMedication.fromJson(Map<String, dynamic> json) {
    return PrescriptionMedication(
      medicationName: json['medication_name'],
      scientificName: json['scientific_name'],
      dosage: json['dosage'],
      frequency: json['frequency'],
      duration: json['duration'],
      quantity: json['quantity'] ?? 0,
      instructions: json['instructions'],
      isFilled: json['is_filled'] == 1 || json['is_filled'] == true,
    );
  }
}

 */
