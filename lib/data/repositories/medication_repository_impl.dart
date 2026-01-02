//lib/data/repositories/medication_repository.dart

import 'dart:convert';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/medication.dart' hide MedicationTime;
import '../../domain/usecases/medication/add_medication_usecase.dart';
import '../../domain/usecases/medication/get_medication_usecase.dart';
import '../../domain/usecases/medication/log_taken_usecase.dart';
import '../data_sources/remote/medication_api.dart';
import '../data_sources/local/local_storage.dart';
import '../models/medication_model.dart';


class MedicationRepository {
  final MedicationApi _api;
  final LocalStorage _localStorage;

  MedicationRepository(this._api, this._localStorage);

  // ==========================================
  // GET MEDICATIONS
  // ==========================================
  Future<List<MedicationSchedule>> getMedications(String patientId) async {
    try {
      // الحصول على البيانات من API
      final medications = await _api.getMedications(); // List<dynamic>
      final medicationModels = medications
          .map((e) => MedicationSchedule.fromJson(e as Map<String, dynamic>))
          .toList();

      // حفظ نسخة محلية Cache
      await _localStorage.saveMedications(
        medicationModels.map((e) => e.toJson()).toList(),
      );

      return medicationModels;
    } catch (e) {
      // إذا فشل API، حاول استخدام النسخة المحلية
      final cached = await _localStorage.getMedications();
      if (cached != null && cached.isNotEmpty) {
        return cached
            .map((e) => MedicationSchedule.fromJson(e))
            .toList();
      }
      rethrow;
    }
  }

  // ==========================================
  // ADD MEDICATION
  // ==========================================
  Future<MedicationSchedule> addMedication({
    required String patientId,
    required String medicationName,
    String? scientificName,
    required String dosage,
    required String frequency,
    required List<MedicationTime> times,
    required int currentStock,
    required String stockUnit,
    String? colorCode,
    String? image,
  }) async {
    final data = {
      'patient_id': patientId,
      'medication_name': medicationName,
      if (scientificName != null) 'scientific_name': scientificName,
      'dosage': dosage,
      'frequency': frequency,
      'times': times.map((e) => e.toJson()).toList(),
      'current_stock': currentStock,
      'stock_unit': stockUnit,
      if (colorCode != null) 'color_code': colorCode,
      if (image != null) 'image': image,
    };

    final response = await _api.addMedication(data); // Map<String, dynamic>
    return MedicationSchedule.fromJson(response);


  }


  // ==========================================
  // LOG TAKEN
  // ==========================================
  Future<void> logTaken({
    required String medicationScheduleId,
    required DateTime takenAt,
  }) async {
    await _api.logMedicationTaken(
      medicationScheduleId: medicationScheduleId,
      notes: null,
    );
  }

  // ==========================================
  // GET MEDICATIONS DUE
  // ==========================================
  Future<List<MedicationSchedule>> getMedicationsDue(
      String patientId,
      int timeWindowMinutes,
      ) async {
    final medications = await _api.getMedicationsDue(); // List<dynamic>
    return medications
        .map((e) => MedicationSchedule.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}






