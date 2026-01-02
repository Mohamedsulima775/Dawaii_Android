
// lib/features/prescription/domain/usecases/get_prescription_details.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../data/repositories/prescription_repository.dart';
import '../../entities/prescription.dart';
import '../usecase.dart';

class GetPrescriptionDetails implements UseCase<Prescription, PrescriptionDetailsParams> {
  final PrescriptionRepository repository;

  GetPrescriptionDetails(this.repository);

  @override
  Future<Either<Failure, Prescription>> call(PrescriptionDetailsParams params) async {
    return await repository.getPrescriptionDetails(
      prescriptionId: params.prescriptionId,
    );
  }
}

class PrescriptionDetailsParams extends Equatable {
  final String prescriptionId;

  const PrescriptionDetailsParams({required this.prescriptionId});

  @override
  List<Object> get props => [prescriptionId];
}