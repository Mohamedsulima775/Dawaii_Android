
// lib/features/prescription/domain/repositories/prescription_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import 'package:dawaii/domain/entities/prescription.dart';

import '../models/prescription_model.dart';

abstract class PrescriptionRepository {
  /// Get all prescriptions for a patient
  Future<Either<Failure, List<Prescription>>> getPatientPrescriptions({
    required String patientId,
    String? status,
    int limit = 50,
  });

  /// Get prescription details
  Future<Either<Failure, Prescription>> getPrescriptionDetails({
    required String prescriptionId,
  });

  /// Get doctor's prescriptions
  Future<Either<Failure, List<Prescription>>> getDoctorPrescriptions({
    required String doctorUserId,
    int limit = 50,
  });

  /// Create new prescription (Doctor only)
  Future<Either<Failure, Prescription>> createPrescription({
    required String patientId,
    required String diagnosis,
    required List<Map<String, dynamic>> medications,
    required String instructions,
    String? notes,
    DateTime? followUpDate,
    String? consultationId,
  });

  /// Update prescription
  Future<Either<Failure, Prescription>> updatePrescription({
    required String prescriptionId,
    String? diagnosis,
    List<Map<String, dynamic>>? medications,
    String? instructions,
    String? notes,
    DateTime? followUpDate,
  });

  /// Cancel prescription
  Future<Either<Failure, bool>> cancelPrescription({
    required String prescriptionId,
    required String reason,
  });

  /// Generate PDF
  Future<Either<Failure, String>> generatePrescriptionPdf({
    required String prescriptionId,
  });
}