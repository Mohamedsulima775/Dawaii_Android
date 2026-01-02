
// lib/features/medication/domain/repositories/medication_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/medication.dart';
import '../../domain/entities/medication_log.dart';
import '../../domain/usecases/medication/add_medication_usecase.dart';
import '../../domain/usecases/medication/get_medication_usecase.dart';
import '../../domain/usecases/medication/log_taken_usecase.dart';


abstract class MedicationRepository {
  /// الحصول على قائمة الأدوية
  Future<Either<Failure, List<Medication>>> getMedications(
      GetMedicationsParams params,
      );

  /// إضافة دواء جديد
  Future<Either<Failure, Medication>> addMedication(
      AddMedicationParams params,
      );

  /// تحديث دواء
  Future<Either<Failure, Medication>> updateMedication(
      String id,
      AddMedicationParams params,
      );

  /// حذف دواء
  Future<Either<Failure, void>> deleteMedication(String id);

  /// تسجيل تناول دواء
  Future<Either<Failure, MedicationLog>> logMedicationTaken(
      LogMedicationTakenParams params,
      );

  /// الحصول على سجل التناول
  Future<Either<Failure, List<MedicationLog>>> getMedicationLogs(
      GetMedicationLogsParams params,
      );

  /// تحديث المخزون
  Future<Either<Failure, Medication>> updateStock(
      String id,
      int newStock,
      );

  /// إيقاف/تفعيل دواء
  Future<Either<Failure, Medication>> toggleActive(
      String id,
      bool isActive,
      );
}