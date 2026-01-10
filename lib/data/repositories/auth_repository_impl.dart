//lib/data/repositories/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/patient.dart';
import '../data_sources/remote/auth_api.dart';
import '../models/patient_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _authApi;
  final SharedPreferences _prefs;

  AuthRepositoryImpl({
    required AuthApi authApi,
    required SharedPreferences prefs,
  })  : _authApi = authApi,
        _prefs = prefs;

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

      // Save token and user info
      await _prefs.setString('auth_token', response.token);
      await _prefs.setString('patient_id', response.patientId);
      await _prefs.setString('patient_name', response.patientName);

      // Create Patient entity (you may need to adjust this based on your Patient model)
      final patient = Patient(
        id: response.patientId,
        name: response.patientName,
        // Add other required fields
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

      // Save token and user info
      await _prefs.setString('auth_token', response.token);
      await _prefs.setString('patient_id', response.patientId);
      await _prefs.setString('patient_name', response.patientName);

      // Create Patient entity
      final patient = Patient(
        id: response.patientId,
        name: response.patientName,
        // Add other required fields
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

      // Clear local storage
      await _prefs.remove('auth_token');
      await _prefs.remove('patient_id');
      await _prefs.remove('patient_name');

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Patient?>> getCurrentUser() async {
    try {
      final patientId = _prefs.getString('patient_id');
      final patientName = _prefs.getString('patient_name');

      if (patientId == null || patientName == null) {
        return const Right(null);
      }

      // TODO: Fetch full patient details from API if needed
      final patient = Patient(
        id: patientId,
        name: patientName,
        // Add other fields
      );

      return Right(patient);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return _prefs.getString('auth_token') != null;
  }
}
