
// lib/features/prescription/domain/usecases/get_patient_prescriptions.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../data/repositories/prescription_repository.dart';
import '../../entities/prescription.dart';
import '../usecase.dart';

class GetPatientPrescriptions implements UseCase<List<Prescription>, PrescriptionParams> {
  final PrescriptionRepository repository;

  GetPatientPrescriptions(this.repository);

  @override
  Future<Either<Failure, List<Prescription>>> call(PrescriptionParams params) async {
    return await repository.getPatientPrescriptions(
      patientId: params.patientId,
      status: params.status,
      limit: params.limit,
    );
  }
}

class PrescriptionParams extends Equatable {
  final String patientId;
  final String? status;
  final int limit;

  const PrescriptionParams({
    required this.patientId,
    this.status,
    this.limit = 50,
  });

  @override
  List<Object?> get props => [patientId, status, limit];
}