//lib/data/data_sources/remote/auth_api.dart
/*
//الاول

import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/constants/api_constants.dart';
import '../../models/patient_model.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  Future<LoginResponse> login({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        data: {
          'mobile': mobile,
          'password': password,
        },
      );

      return LoginResponse.fromJson(response.data['message']);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> register({
    required String mobile,
    required String password,
    required String patientName,
    String? email,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.register,
        data: {
          'mobile': mobile,
          'password': password,
          'patient_data': {
            'patient_name': patientName,
            'email': email,
          },
        },
      );

      return LoginResponse.fromJson(response.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}

 */

// lib/data/data_sources/remote/auth_api.dart

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class AuthApi {
  final ApiClient _apiClient;

  AuthApi(this._apiClient);

  // ==========================================
  // LOGIN
  // ==========================================

  Future<Map<String, dynamic>> login({
    required String mobile,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.login,
      body: {
        'mobile': mobile,
        'password': password,
      },
    );

    return response['message'] as Map<String, dynamic>;
  }

  // ==========================================
  // REGISTER
  // ==========================================

  Future<Map<String, dynamic>> register({
    required String patientName,
    required String mobile,
    required String password,
    required String dateOfBirth,
    required String gender,
    String? email,
    String? bloodGroup,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.register,
      body: {
        'patient_name': patientName,
        'mobile': mobile,
        'password': password,
        'date_of_birth': dateOfBirth,
        'gender': gender,
        if (email != null) 'email': email,
        if (bloodGroup != null) 'blood_group': bloodGroup,
      },
    );

    return response['message'] as Map<String, dynamic>;
  }

  // ==========================================
  // GET PROFILE
  // ==========================================

  Future<Map<String, dynamic>> getProfile() async {
    final response = await _apiClient.get(ApiConstants.getProfile);
    return response['message'] as Map<String, dynamic>;
  }

  // ==========================================
  // UPDATE PROFILE
  // ==========================================

  Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> data,
      ) async {
    final response = await _apiClient.post(
      ApiConstants.updateProfile,
      body: {'profile_data': data},
    );

    return response['message'] as Map<String, dynamic>;
  }
}
