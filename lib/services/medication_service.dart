// lib/services/medication_service.dart

import '../core/constants/api_constants.dart';
import 'api_service.dart';
import '../data/models/adherence_stats.dart';
import '../data/models/medication_model.dart';

class MedicationService {
  final ApiService _apiService;

  MedicationService(this._apiService);

  // Get all medications for patient
  Future<List<MedicationSchedule>> getMedications(String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getMedications,
      params: {'patient_id': patientId},
    );

    final medications = (response['message'] as List?)
        ?.map((m) => MedicationSchedule.fromJson(m))
        .toList() ??
        [];

    return medications;
  }

  // Get medications due
  Future<List<MedicationSchedule>> getMedicationsDue(String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getMedicationsDue,
      params: {'patient_id': patientId},
    );

    final medications = (response['message'] as List?)
        ?.map((m) => MedicationSchedule.fromJson(m))
        .toList() ??
        [];

    return medications;
  }

  // Get low stock medications
  Future<List<MedicationSchedule>> getLowStockMedications(
      String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getLowStockMedications,
      params: {'patient_id': patientId},
    );

    final medications = (response['message'] as List?)
        ?.map((m) => MedicationSchedule.fromJson(m))
        .toList() ??
        [];

    return medications;
  }

  // Add new medication
  Future<MedicationSchedule> addMedication(
      Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiConstants.addMedication,
      data: data,
    );

    return MedicationSchedule.fromJson(response['message']);
  }

  // Deactivate medication
  Future<void> deactivateMedication(String medicationId) async {
    await _apiService.post(
      ApiConstants.deactivateMedication,
      data: {'medication_id': medicationId},
    );
  }

  // Update stock
  Future<void> updateStock(String medicationId, int newStock) async {
    await _apiService.post(
      ApiConstants.updateStock,
      data: {
        'medication_id': medicationId,
        'new_stock': newStock,
      },
    );
  }

  // Log medication taken
  Future<MedicationLog> logMedicationTaken(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiConstants.logMedicationTaken,
      data: data,
    );

    return MedicationLog.fromJson(response['message']);
  }

  // Get medication logs
  Future<List<MedicationLog>> getMedicationLogs(String medicationId,
      {String? fromDate, String? toDate}) async {
    final response = await _apiService.get(
      ApiConstants.getMedicationLogs,
      params: {
        'medication_id': medicationId,
        if (fromDate != null) 'from_date': fromDate,
        if (toDate != null) 'to_date': toDate,
      },
    );

    return (response['message'] as List?)
        ?.map((l) => MedicationLog.fromJson(l))
        .toList() ??
        [];
  }

  // TODO: Add these endpoints to ApiConstants if needed
  // Get adherence stats
  Future<AdherenceStats> getAdherenceStats(String patientId) async {
    final response = await _apiService.get(
      '/my_medicinal.api.medication_schedule.get_adherence_stats',
      params: {'patient_id': patientId},
    );

    return AdherenceStats.fromJson(response['message']);
  }
}
