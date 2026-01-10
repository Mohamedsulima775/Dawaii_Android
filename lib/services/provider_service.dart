// lib/services/provider_service.dart

import '../core/constants/api_constants.dart';
import '../data/models/healthcare_provider.dart';
import 'api_service.dart';

class ProviderService {
  final ApiService _apiService;

  ProviderService(this._apiService);

  // Get providers
  Future<List<HealthcareProvider>> getProviders({String? specialty}) async {
    final response = await _apiService.get(
      ApiConstants.getProviders,
      params: {
        if (specialty != null) 'specialty': specialty,
      },
    );

    return (response['message'] as List?)
        ?.map((p) => HealthcareProvider.fromJson(p))
        .toList() ??
        [];
  }

  // Get provider schedule
  Future<Map<String, dynamic>> getProviderSchedule(
      String providerId, String date) async {
    final response = await _apiService.get(
      ApiConstants.getProviderSchedule,
      params: {
        'provider_id': providerId,
        'date': date,
      },
    );

    return response['message'] as Map<String, dynamic>;
  }
}
