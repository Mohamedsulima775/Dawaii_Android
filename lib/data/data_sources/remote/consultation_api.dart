// lib/data/data_sources/remote/consultation_api.dart

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class ConsultationApi {
  final ApiClient _apiClient;

  ConsultationApi(this._apiClient);

  Future<Map<String, dynamic>> createConsultation({
    required String providerId,
    required String consultationType,
    required String chiefComplaint,
    String? severity,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.createConsultation,
      body: {
        'provider_id': providerId,
        'consultation_type': consultationType,
        'chief_complaint': chiefComplaint,
        if (severity != null) 'severity': severity,
      },
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<List<dynamic>> getMyConsultations({
    String? status,
    int limit = 20,
  }) async {
    final response = await _apiClient.get(
      ApiConstants.getMyConsultations,
      queryParameters: {
        if (status != null) 'status': status,
        'limit': limit,
      },
    );
    return response['message'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> sendMessage({
    required String consultationId,
    required String message,
    String? attachment,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.sendMessage,
      body: {
        'consultation_id': consultationId,
        'message': message,
        if (attachment != null) 'attachment': attachment,
      },
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<List<dynamic>> getMessages({
    required String consultationId,
    int limit = 50,
  }) async {
    final response = await _apiClient.get(
      ApiConstants.getMessages,
      queryParameters: {
        'consultation_id': consultationId,
        'limit': limit,
      },
    );
    return response['message'] as List<dynamic>;
  }
}
