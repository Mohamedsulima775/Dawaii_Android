

import '../data/models/consultation_model.dart';
import 'api_service.dart';
class ConsultationService {
  final ApiService _apiService;

  ConsultationService(this._apiService);

  // Get consultations
  Future<List<Consultation>> getConsultations(String patientId,
      {String? status}) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_consultations',
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

  // Get consultation details
  Future<Consultation> getConsultationDetails(String consultationId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_consultation_details',
      params: {'consultation_id': consultationId},
    );

    return Consultation.fromJson(response['message']);
  }

  // Book consultation
  Future<Consultation> bookConsultation(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      'my_medicinal.api.book_consultation',
      data: data,
    );

    return Consultation.fromJson(response['message']);
  }

  // Cancel consultation
  Future<void> cancelConsultation(String consultationId) async {
    await _apiService.post(
      'my_medicinal.api.cancel_consultation',
      data: {'consultation_id': consultationId},
    );
  }

  // Get consultation messages
  Future<List<ConsultationMessage>> getConsultationMessages(
      String consultationId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_consultation_messages',
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
      'my_medicinal.api.send_message',
      data: {
        'consultation_id': consultationId,
        'message': message,
        if (attachment != null) 'attachment': attachment,
      },
    );

    return ConsultationMessage.fromJson(response['message']);
  }
}