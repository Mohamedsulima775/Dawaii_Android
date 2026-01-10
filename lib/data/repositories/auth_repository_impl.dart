//lib/data/repositories/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/patient.dart';
import '../data_sources/remote/auth_api.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final FlutterSecureStorage _secureStorage;

  // Storage keys
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyPatientId = 'patient_id';
  static const String _keyPatientName = 'patient_name';

  AuthRepositoryImpl({
    required AuthApi authApi,
    FlutterSecureStorage? secureStorage,
  })  : _authApi = authApi,
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<Either<Failure, AuthResult>> login({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await _authApi.login(
        mobile: mobile,
        password: password,
      );

      // Save tokens and user info securely
      await _secureStorage.write(key: _keyAuthToken, value: response.token);
      await _secureStorage.write(key: _keyPatientId, value: response.patientId);
      await _secureStorage.write(key: _keyPatientName, value: response.patientName);

      // Save refresh token if available
      if (response.refreshToken != null) {
        await _secureStorage.write(key: _keyRefreshToken, value: response.refreshToken);
      }

      // Create Patient entity
      final patient = Patient(
        id: response.patientId,
        name: response.patientName,
      );

      return Right(AuthResult(
        token: response.token,
        patient: patient,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> register({
    required String patientName,
    required String mobile,
    required String email,
    required String password,
    String? dateOfBirth,
    String? gender,
  }) async {
    try {
      final response = await _authApi.register(
        mobile: mobile,
        password: password,
        patientName: patientName,
        email: email,
      );

      // Save tokens and user info securely
      await _secureStorage.write(key: _keyAuthToken, value: response.token);
      await _secureStorage.write(key: _keyPatientId, value: response.patientId);
      await _secureStorage.write(key: _keyPatientName, value: response.patientName);

      // Save refresh token if available
      if (response.refreshToken != null) {
        await _secureStorage.write(key: _keyRefreshToken, value: response.refreshToken);
      }

      // Create Patient entity
      final patient = Patient(
        id: response.patientId,
        name: response.patientName,
      );

      return Right(AuthResult(
        token: response.token,
        patient: patient,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Call logout API if needed
      // await _authApi.logout();

      // Clear all secure storage
      await _secureStorage.delete(key: _keyAuthToken);
      await _secureStorage.delete(key: _keyRefreshToken);
      await _secureStorage.delete(key: _keyPatientId);
      await _secureStorage.delete(key: _keyPatientName);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Patient?>> getCurrentUser() async {
    try {
      final patientId = await _secureStorage.read(key: _keyPatientId);
      final patientName = await _secureStorage.read(key: _keyPatientName);

      if (patientId == null || patientName == null) {
        return const Right(null);
      }

      // TODO: Fetch full patient details from API if needed
      final patient = Patient(
        id: patientId,
        name: patientName,
      );

      return Right(patient);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final token = await _secureStorage.read(key: _keyAuthToken);
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get stored auth token
  Future<String?> getAuthToken() async {
    try {
      return await _secureStorage.read(key: _keyAuthToken);
    } catch (e) {
      return null;
    }
  }

  /// Get stored refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _keyRefreshToken);
    } catch (e) {
      return null;
    }
  }

  /// Refresh auth token
  Future<Either<Failure, String>> refreshAuthToken() async {
    try {
      final refreshToken = await getRefreshToken();

      if (refreshToken == null) {
        return const Left(AuthenticationFailure('No refresh token available'));
      }

      // TODO: Call refresh token API endpoint
      // For now, this is a placeholder
      // final response = await _authApi.refreshToken(refreshToken);
      // await _secureStorage.write(key: _keyAuthToken, value: response.token);
      // return Right(response.token);

      return const Left(ServerFailure('Refresh token not implemented yet'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

// Extension for LoginResponse to handle refresh token
extension LoginResponseExtension on dynamic {
  String? get refreshToken {
    if (this is Map && (this as Map).containsKey('refresh_token')) {
      return (this as Map)['refresh_token'] as String?;
    }
    return null;
  }
}
