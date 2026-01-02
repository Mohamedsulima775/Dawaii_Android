

import '../data/models/healthcare_provider.dart';
import 'api_service.dart';

class ProviderService {
  final ApiService _apiService;

  ProviderService(this._apiService);

  // Get providers
  Future<List<HealthcareProvider>> getProviders({String? specialty}) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_providers',
      params: {
        if (specialty != null) 'specialty': specialty,
      },
    );

    return (response['message'] as List?)
        ?.map((p) => HealthcareProvider.fromJson(p))
        .toList() ??
        [];
  }

  // Get provider profile
  Future<HealthcareProvider> getProviderProfile(String providerId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_provider_profile',
      params: {'provider_id': providerId},
    );

    return HealthcareProvider.fromJson(response['message']);
  }

  // Get provider availability
  Future<Map<String, List<String>>> getProviderAvailability(
      String providerId, String date) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_provider_availability',
      params: {
        'provider_id': providerId,
        'date': date,
      },
    );

    return Map<String, List<String>>.from(response['message']);
  }
}