//lib/data/data_sources/remote/medication_api.dart
/*
//الاول
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/medication_model.dart';

class MedicationApi {
  final ApiClient _apiClient;

  MedicationApi(this._apiClient);

  // Get all medications for patient
  Future<List<MedicationSchedule>> getMedications(String patientId) async {
    final response = await _apiClient.get(
      ApiConstants.getMedications,
      queryParameters: {'patient_id': patientId},
    );

    final List data = response.data['message'];
    return data.map((json) => MedicationSchedule.fromJson(json)).toList();
  }

  // Add new medication schedule
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
    final response = await _apiClient.post(
      ApiConstants.addMedication,
      data: {
        'patient_id': patientId,
        'medication_name': medicationName,
        'scientific_name': scientificName,
        'dosage': dosage,
        'frequency': frequency,
        'times': times.map((t) => t.toJson()).toList(),
        'current_stock': currentStock,
        'stock_unit': stockUnit,
        'color_code': colorCode,
        'image': image,
      },
    );

    return MedicationSchedule.fromJson(response.data['message']);
  }

  // Log medication taken
  Future<void> logMedicationTaken({
    required String medicationScheduleId,
    required DateTime takenAt,
  }) async {
    await _apiClient.post(
      ApiConstants.logTaken,
      data: {
        'medication_schedule_id': medicationScheduleId,
        'taken_at': takenAt.toIso8601String(),
      },
    );
  }

  // Get medications due now
  Future<List<MedicationSchedule>> getMedicationsDue(
      String patientId,
      int timeWindowMinutes,
      ) async {
    final response = await _apiClient.get(
      '/api/method/medication.get_medications_due',
      queryParameters: {
        'patient_id': patientId,
        'time_window': timeWindowMinutes,
      },
    );

    final List data = response.data['message'];
    return data.map((json) => MedicationSchedule.fromJson(json)).toList();
  }

  // Update medication stock
  Future<void> updateStock({
    required String scheduleId,
    required int newStock,
  }) async {
    await _apiClient.post(
      '/api/method/medication.update_stock',
      data: {
        'schedule_id': scheduleId,
        'new_stock': newStock,
      },
    );
  }
}

 */

// lib/data/data_sources/remote/medication_api.dart

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class MedicationApi {
  final ApiClient _apiClient;

  MedicationApi(this._apiClient);

  Future<List<dynamic>> getMedications() async {
    final response = await _apiClient.get(ApiConstants.getMedications);
    return response['message'] as List<dynamic>;
  }

  Future<List<dynamic>> getMedicationsDue() async {
    final response = await _apiClient.get(ApiConstants.getMedicationsDue);
    return response['message'] as List<dynamic>;
  }

  Future<List<dynamic>> getLowStockMedications({int threshold = 5}) async {
    final response = await _apiClient.get(
      ApiConstants.getLowStockMedications,
      queryParameters: {'threshold': threshold},
    );
    return response['message'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> addMedication(
      Map<String, dynamic> data,
      ) async {
    final response = await _apiClient.post(
      ApiConstants.addMedication,
      body: data,
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> logMedicationTaken({
    required String medicationScheduleId,
    String? notes,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.logMedicationTaken,
      body: {
        'medication_schedule_id': medicationScheduleId,
        if (notes != null) 'notes': notes,
      },
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> updateStock({
    required String medicationScheduleId,
    required int newStock,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.updateStock,
      body: {
        'medication_schedule_id': medicationScheduleId,
        'new_stock': newStock,
      },
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> deactivateMedication({
    required String medicationScheduleId,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.deactivateMedication,
      body: {'medication_schedule_id': medicationScheduleId},
    );
    return response['message'] as Map<String, dynamic>;
  }
}
