
// lib/features/prescription/domain/entities/prescription.dart

import 'package:equatable/equatable.dart';
import 'prescription_medication.dart';

class Prescription extends Equatable {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime prescriptionDate;
  final String diagnosis;
  final String instructions;
  final DateTime? followUpDate;
  final String status; // Draft, Active, Modified, Completed, Cancelled
  final List<PrescriptionMedication> medications;
  final String? prescriptionFile;
  final String? consultationId;
  final DateTime createdAt;
  final DateTime? modifiedAt;

  const Prescription({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.prescriptionDate,
    required this.diagnosis,
    required this.instructions,
    this.followUpDate,
    required this.status,
    required this.medications,
    this.prescriptionFile,
    this.consultationId,
    required this.createdAt,
    this.modifiedAt,
  });

  @override
  List<Object?> get props => [
    id,
    patientId,
    doctorId,
    prescriptionDate,
    status,
    medications,
  ];

  // Helper methods
  bool get isActive => status == 'Active';
  bool get isCompleted => status == 'Completed';
  bool get isCancelled => status == 'Cancelled';

  int get medicationCount => medications.length;

  bool get hasFollowUp => followUpDate != null;

  Duration? get timeUntilFollowUp {
    if (followUpDate == null) return null;
    return followUpDate!.difference(DateTime.now());
  }

}