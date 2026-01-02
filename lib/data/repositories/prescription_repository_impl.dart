
// lib/features/prescription/data/repositories/prescription_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:dawaii/data/repositories/prescription_repository.dart';
import '../../domain/entities/prescription.dart';
import '../models/prescription_model.dart';
import '../../../../core/network/api_client.dart';
import 'package:dawaii/core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';

class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final ApiClient apiClient;

  PrescriptionRepositoryImpl({required this.apiClient});

  @override
  Future<Either<Failure, List<Prescription>>> getPatientPrescriptions({
    required String patientId,
    String? status,
    int limit = 50,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.get_patient_prescriptions',
        queryParameters: {
          'patient_id': patientId,
          if (status != null) 'status': status,
          'limit': limit,
        },
      );

      final List<dynamic> data = response['data']['message'];
      final prescriptions = data
          .map((json) => PrescriptionModel.fromJson(json))
          .toList();

      return Right(prescriptions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Prescription>> getPrescriptionDetails({
    required String prescriptionId,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.get_prescription',
        queryParameters: {
          'prescription_id': prescriptionId,
        },
      );

      final prescription = PrescriptionModel.fromJson(response['data']['message']);
      return Right(prescription);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Prescription>>> getDoctorPrescriptions({
    required String doctorUserId,
    int limit = 50,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.get_doctor_prescriptions',
        queryParameters: {
          'doctor_user_id': doctorUserId,
          'limit': limit,
        },
      );

      final List<dynamic> data = response['data']['message'];
      final prescriptions = data
          .map((json) => PrescriptionModel.fromJson(json))
          .toList();

      return Right(prescriptions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Prescription>> createPrescription({
    required String patientId,
    required String diagnosis,
    required List<Map<String, dynamic>> medications,
    required String instructions,
    String? notes,
    DateTime? followUpDate,
    String? consultationId,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.create_prescription',
        body: {
          'patient_id': patientId,
          'diagnosis': diagnosis,
          'medications': medications,
          'instructions': instructions,
          if (notes != null) 'notes': notes,
          if (followUpDate != null)
            'follow_up_date': followUpDate.toIso8601String().split('T')[0],
          if (consultationId != null) 'consultation_id': consultationId,
        },
      );

      final prescription = PrescriptionModel.fromJson(response['data']['message']);
      return Right(prescription);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Prescription>> updatePrescription({
    required String prescriptionId,
    String? diagnosis,
    List<Map<String, dynamic>>? medications,
    String? instructions,
    String? notes,
    DateTime? followUpDate,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.update_prescription',
        body: {
          'prescription_id': prescriptionId,
          if (diagnosis != null) 'diagnosis': diagnosis,
          if (medications != null) 'medications': medications,
          if (instructions != null) 'instructions': instructions,
          if (notes != null) 'notes': notes,
          if (followUpDate != null)
            'follow_up_date': followUpDate.toIso8601String().split('T')[0],
        },
      );

      final prescription = PrescriptionModel.fromJson(response['data']['message']);
      return Right(prescription);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelPrescription({
    required String prescriptionId,
    required String reason,
  }) async {
    try {
      await apiClient.post(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.cancel_prescription',
        body: {
          'prescription_id': prescriptionId,
          'reason': reason,
        },
      );

      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> generatePrescriptionPdf({
    required String prescriptionId,
  }) async {
    try {
      final response = await apiClient.post(
        '/api/method/my_medicinal.my_medicinal.doctype.medical_prescription.medical_prescription.generate_prescription_pdf',
        body: {
          'prescription_id': prescriptionId,
        },
      );

      final pdfUrl = response['data']['message']['pdf_url'];
      return Right(pdfUrl);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}