//lib/data/repositories/auth_repository.dart

// domain/repositories/auth_repository.dart

import 'package:dartz/dartz.dart';
import 'package:dawaii/domain/entities/patient.dart';
import 'package:dawaii/core/errors/failures.dart';

abstract class AuthRepository {
  /// تسجيل مستخدم جديد
  Future<Either<Failure, AuthResult>> register({
    required String patientName,
    required String mobile,
    required String email,
    required String password,
    String? dateOfBirth,
    String? gender,
  });

  /// تسجيل دخول
  Future<Either<Failure, AuthResult>> login({
    required String mobile,
    required String password,
  });

  /// تسجيل خروج
  Future<Either<Failure, void>> logout();

  /// الحصول على المستخدم الحالي
  Future<Either<Failure, Patient?>> getCurrentUser();

  /// التحقق من حالة تسجيل الدخول
  Future<bool> isLoggedIn();
}

/// نتيجة التسجيل/الدخول
class AuthResult {
  final String token;
  final Patient patient;

  const AuthResult({
    required this.token,
    required this.patient,
  });
}

/*
import 'package:shared_preferences/shared_preferences.dart';
import '../data_sources/remote/auth_api.dart';
import '../models/patient_model.dart';

class AuthRepository {
  final AuthApi _authApi;
  final SharedPreferences _prefs;

  AuthRepository(this._authApi, this._prefs);

  // Login
  Future<LoginResponse> login({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await _authApi.login(
        mobile: mobile,
        password: password,
      );

      // حفظ Token
      await _prefs.setString('auth_token', response.token);
      await _prefs.setString('patient_id', response.patientId);
      await _prefs.setString('patient_name', response.patientName);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Register
  Future<LoginResponse> register({
    required String mobile,
    required String password,
    required String patientName,
    String? email,
  }) async {
    try {
      final response = await _authApi.register(
        mobile: mobile,
        password: password,
        patientName: patientName,
        email: email,
      );

      // حفظ Token
      await _prefs.setString('auth_token', response.token);
      await _prefs.setString('patient_id', response.patientId);
      await _prefs.setString('patient_name', response.patientName);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('patient_id');
    await _prefs.remove('patient_name');
  }

  // Check if logged in
  bool get isLoggedIn => _prefs.getString('auth_token') != null;

  // Get current patient ID
  String? get currentPatientId => _prefs.getString('patient_id');
}

 */

