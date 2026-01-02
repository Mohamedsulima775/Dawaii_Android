// lib/services/medication_service.dart

/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/medication_model.dart';
//import '../domain/entities/medication.dart' hide Medication;
//import '../models/medication_model.dart';

class MedicationService {
  // Base URL - غيّر هذا حسب السيرفر
  static const String baseUrl = 'http://your-server.com';

  // Auth token - احصل عليه من SharedPreferences/Secure Storage
  String? _authToken;

  // Set auth token
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Get headers with auth
  Map<String, String> get _headers {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (_authToken != null) 'Authorization': 'Bearer $_authToken',
    };
  }

  // ==========================================
  // GET ALL MEDICATIONS
  // ==========================================
  Future<List<Medication>> getMedications({String? patientId}) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.get_medications'
      );

      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final medications = (data['message'] as List)
            .map((json) => Medication.fromJson(json))
            .toList();
        return medications;
      } else {
        throw Exception('فشل في تحميل الأدوية: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // GET MEDICATIONS DUE NOW
  // ==========================================
  Future<List<Medication>> getMedicationsDue() async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.get_medications_due'
      );

      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final medications = (data['message'] as List)
            .map((json) => Medication.fromJson(json))
            .toList();
        return medications;
      } else {
        throw Exception('فشل في تحميل الأدوية المستحقة');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // GET LOW STOCK MEDICATIONS
  // ==========================================
  Future<List<Medication>> getLowStockMedications({int threshold = 5}) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.get_low_stock_medications'
      ).replace(queryParameters: {
        'threshold': threshold.toString(),
      });

      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final medications = (data['message'] as List)
            .map((json) => Medication.fromJson(json))
            .toList();
        return medications;
      } else {
        throw Exception('فشل في تحميل الأدوية المنخفضة');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // ADD MEDICATION
  // ==========================================
  Future<Map<String, dynamic>> addMedication({
    required String medicationName,
    required String dosage,
    required String frequency,
    required DateTime startDate,
    required int initialStock,
    String? scientificName,
    String? instructions,
    DateTime? endDate,
    String? category,
    List<String>? reminderTimes,
  }) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.add_medication'
      );

      final body = json.encode({
        'medication_name': medicationName,
        'dosage': dosage,
        'frequency': frequency,
        'start_date': startDate.toIso8601String().split('T')[0],
        'initial_stock': initialStock,
        if (scientificName != null) 'scientific_name': scientificName,
        if (instructions != null) 'instructions': instructions,
        if (endDate != null) 'end_date': endDate.toIso8601String().split('T')[0],
        if (category != null) 'category': category,
        if (reminderTimes != null) 'reminder_times': reminderTimes,
      });

      final response = await http.post(
        uri,
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'فشل في إضافة الدواء');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // LOG MEDICATION TAKEN
  // ==========================================
  Future<Map<String, dynamic>> logMedicationTaken({
    required String medicationScheduleId,
    String? notes,
  }) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.log_medication_taken'
      );

      final body = json.encode({
        'medication_schedule_id': medicationScheduleId,
        if (notes != null) 'notes': notes,
      });

      final response = await http.post(
        uri,
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'فشل في تسجيل تناول الدواء');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // UPDATE STOCK
  // ==========================================
  Future<Map<String, dynamic>> updateStock({
    required String medicationScheduleId,
    required int newStock,
  }) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.update_stock'
      );

      final body = json.encode({
        'medication_schedule_id': medicationScheduleId,
        'new_stock': newStock,
      });

      final response = await http.post(
        uri,
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'فشل في تحديث المخزون');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // DEACTIVATE MEDICATION
  // ==========================================
  Future<Map<String, dynamic>> deactivateMedication({
    required String medicationScheduleId,
  }) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.deactivate_medication'
      );

      final body = json.encode({
        'medication_schedule_id': medicationScheduleId,
      });

      final response = await http.post(
        uri,
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'فشل في إيقاف الدواء');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }

  // ==========================================
  // GET MEDICATION LOGS
  // ==========================================
  Future<List<MedicationLog>> getMedicationLogs({
    required String medicationScheduleId,
    int limit = 30,
  }) async {
    try {
      final uri = Uri.parse(
          '$baseUrl/api/method/my_medicinal.api.medication_schedule.get_medication_logs'
      ).replace(queryParameters: {
        'medication_schedule_id': medicationScheduleId,
        'limit': limit.toString(),
      });

      final response = await http.get(uri, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final logs = (data['message'] as List)
            .map((json) => MedicationLog.fromJson(json))
            .toList();
        return logs;
      } else {
        throw Exception('فشل في تحميل السجلات');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال: $e');
    }
  }
}

 */



//الاول
import 'api_service.dart';
import '../data/models/adherence_stats.dart';
import '../data/models/medication_model.dart';

class MedicationService {
  final ApiService _apiService;

  MedicationService(this._apiService);

  // Get all medications for patient
  Future<List<MedicationSchedule>> getMedications(String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_medications',
      params: {'patient_id': patientId},
    );

    final medications = (response['message'] as List?)
        ?.map((m) => MedicationSchedule.fromJson(m))
        .toList() ??
        [];

    return medications;
  }

  // Get single medication
  Future<MedicationSchedule> getMedication(String medicationId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_medication',
      params: {'medication_id': medicationId},
    );

    return MedicationSchedule.fromJson(response['message']);
  }

  // Add new medication
  Future<MedicationSchedule> addMedication(
      Map<String, dynamic> data) async {
    final response = await _apiService.post(
      'my_medicinal.api.add_medication',
      data: data,
    );

    return MedicationSchedule.fromJson(response['message']);
  }

  // Update medication
  Future<MedicationSchedule> updateMedication(
      String medicationId, Map<String, dynamic> data) async {
    final response = await _apiService.put(
      'my_medicinal.api.update_medication',
      data: {
        'medication_id': medicationId,
        ...data,
      },
    );

    return MedicationSchedule.fromJson(response['message']);
  }

  // Delete medication
  Future<void> deleteMedication(String medicationId) async {
    await _apiService.delete(
      'my_medicinal.api.delete_medication',
      data: {'medication_id': medicationId},
    );
  }

  // Update stock
  Future<void> updateStock(String medicationId, int newStock) async {
    await _apiService.post(
      'my_medicinal.api.update_stock',
      data: {
        'medication_id': medicationId,
        'new_stock': newStock,
      },
    );
  }

  // Log medication
  Future<MedicationLog> logMedication(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      'my_medicinal.api.log_medication',
      data: data,
    );

    return MedicationLog.fromJson(response['message']);
  }

  // Get medication logs
  Future<List<MedicationLog>> getMedicationLogs(String medicationId,
      {String? fromDate, String? toDate}) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_medication_history',
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

  // Get adherence stats
  Future<AdherenceStats> getAdherenceStats(String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_adherence_stats',
      params: {'patient_id': patientId},
    );

    return AdherenceStats.fromJson(response['message']);
  }

  // Get today's medications
  Future<List<MedicationSchedule>> getTodayMedications(
      String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_today_medications',
      params: {'patient_id': patientId},
    );

    return (response['message'] as List?)
        ?.map((m) => MedicationSchedule.fromJson(m))
        .toList() ??
        [];
  }
}
