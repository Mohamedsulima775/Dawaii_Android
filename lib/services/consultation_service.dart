// lib/services/consultation_service.dart

import '../core/constants/api_constants.dart';
import '../data/models/consultation_model.dart';
import 'api_service.dart';

class ConsultationService {
  final ApiService _apiService;

  ConsultationService(this._apiService);

  // Get consultations
  Future<List<Consultation>> getConsultations(String patientId,
      {String? status}) async {
    final response = await _apiService.get(
      ApiConstants.getMyConsultations,
      params: {
        'patient_id': patientId,
        if (status != null) 'status': status,
      },
    );

    return (response['message'] as List?)
        ?.map((c) => Consultation.fromJson(c))
        .toList() ??
        [];
  }

  // Create consultation
  Future<Consultation> createConsultation(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiConstants.createConsultation,
      data: data,
    );

    return Consultation.fromJson(response['message']);
  }

  // Get consultation messages
  Future<List<ConsultationMessage>> getConsultationMessages(
      String consultationId) async {
    final response = await _apiService.get(
      ApiConstants.getMessages,
      params: {'consultation_id': consultationId},
    );

    return (response['message'] as List?)
        ?.map((m) => ConsultationMessage.fromJson(m))
        .toList() ??
        [];
  }

  // Send message
  Future<ConsultationMessage> sendMessage(
      String consultationId, String message, {String? attachment}) async {
    final response = await _apiService.post(
      ApiConstants.sendMessage,
      data: {
        'consultation_id': consultationId,
        'message': message,
        if (attachment != null) 'attachment': attachment,
      },
    );

    return ConsultationMessage.fromJson(response['message']);
  }
}
