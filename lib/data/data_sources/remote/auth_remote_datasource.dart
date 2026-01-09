/*
// lib/data/datasources/remote/auth_remote_datasource.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/errors/exceptions.dart';
import '../../models/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? dateOfBirth,
    String? gender,
  });
  Future<void> logout();
  Future<User> getCurrentUser();
  Future<User> updateProfile(Map<String, dynamic> data);
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> resetPassword(String email);
  Future<bool> verifyOTP({required String phone, required String otp});
  Future<void> sendOTP(String phone);
  Future<void> deleteAccount(String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/api/method/my_medicinal.api.patient.login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['message']['user']);
      } else {
        throw ServerException('Login failed');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? dateOfBirth,
    String? gender,
  }) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/api/method/my_medicinal.api.patient.register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'patient_name': name,
          'email': email,
          'password': password,
          'mobile': phone,
          'date_of_birth': dateOfBirth,
          'gender': gender,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['message']['user']);
      } else {
        throw ServerException('Registration failed');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    // Implement logout
  }

  @override
  Future<User> getCurrentUser() async {
    // Implement get current user
    throw UnimplementedError();
  }

  @override
  Future<User> updateProfile(Map<String, dynamic> data) async {
    // Implement update profile
    throw UnimplementedError();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    // Implement change password
  }

  @override
  Future<void> resetPassword(String email) async {
    // Implement reset password
  }

  @override
  Future<bool> verifyOTP({required String phone, required String otp}) async {
    // Implement verify OTP
    return false;
  }

  @override
  Future<void> sendOTP(String phone) async {
    // Implement send OTP
  }

  @override
  Future<void> deleteAccount(String password) async {
    // Implement delete account
  }
}

 */