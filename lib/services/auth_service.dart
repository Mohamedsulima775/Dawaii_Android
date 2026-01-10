import '../core/constants/api_constants.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiService.post(
      ApiConstants.login,
      data: {
        'usr': email,
        'pwd': password,
      },
    );

    // Save token
    if (response['message'] != null && response['message']['token'] != null) {
      _apiService.setToken(response['message']['token']);
    }

    return response['message'];
  }

  // Register
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiConstants.register,
      data: data,
    );

    // Save token if returned
    if (response['message'] != null && response['message']['token'] != null) {
      _apiService.setToken(response['message']['token']);
    }

    return response['message'];
  }

  // Logout
  Future<void> logout() async {
    await _apiService.post(ApiConstants.logout);
    _apiService.clearToken();
  }

  // Get profile
  Future<Map<String, dynamic>> getProfile(String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getProfile,
      params: {'patient_id': patientId},
    );

    return response['message'];
  }

  // Update profile
  Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> data) async {
    final response = await _apiService.put(
      ApiConstants.updateProfile,
      data: data,
    );

    return response['message'];
  }
}