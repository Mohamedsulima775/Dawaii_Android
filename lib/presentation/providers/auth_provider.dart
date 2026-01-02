//lib/presentation/providers/auth_provider.dart

/////// المعدل غير مهم


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/patient_model.dart';

@immutable
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? patientId;
  final String? patientName;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.patientId,
    this.patientName,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? patientId,
    String? patientName,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      error: error,
    );
  }
}

// Fake Repository مؤقت لتشغيل الواجهة
class FakeAuthRepository {
  bool get isLoggedIn => true;
  String get currentPatientId => '123';
  String get currentPatientName => 'مستخدم تجريبي';

  Future<AuthResponse> login({required String mobile, required String password}) async {
    return AuthResponse(patientId: currentPatientId, patientName: currentPatientName);
  }

  Future<AuthResponse> register({required String mobile, required String patientName, String? email, String? password}) async {
    return AuthResponse(patientId: currentPatientId, patientName: currentPatientName);
  }

  Future<void> logout() async {}
}

// Response class وهمية
class AuthResponse {
  final String patientId;
  final String patientName;

  AuthResponse({required this.patientId, required this.patientName});
}

// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final FakeAuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkAuthStatus();
  }


  void _checkAuthStatus() {
    if (_authRepository.isLoggedIn) {
      state = state.copyWith(
        isAuthenticated: true,
        patientId: _authRepository.currentPatientId,
        patientName: _authRepository.currentPatientName,
      );
    }
  }



  Future<void> login({
    required String mobile,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.login(
        mobile: mobile,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        patientId: response.patientId,
        patientName: response.patientName,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> register({
    required String mobile,
    required String password,
    required String patientName,
    String? email,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.register(
        mobile: mobile,
        password: password,
        patientName: patientName,
        email: email,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        patientId: response.patientId,
        patientName: response.patientName,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState();
  }

}

// Provider جاهز للاستخدام
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(FakeAuthRepository());
});

/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_riverpod/legacy.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/patient_model.dart';

// State
@immutable
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? patientId;
  final String? patientName;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.patientId,
    this.patientName,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? patientId,
    String? patientName,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      error: error,
    );
  }
}

// Provider
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    if (_authRepository.isLoggedIn) {
      state = state.copyWith(
        isAuthenticated: true,
        patientId: _authRepository.currentPatientId,
      );
    }
  }

  Future<void> login({
    required String mobile,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.login(
        mobile: mobile,
        password: password,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        patientId: response.patientId,
        patientName: response.patientName,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> register({
    required String mobile,
    required String password,
    required String patientName,
    String? email,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.register(
        mobile: mobile,
        password: password,
        patientName: patientName,
        email: email,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        patientId: response.patientId,
        patientName: response.patientName,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState();
  }
}

// Provider Instance
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  // TODO: Inject dependencies properly
  throw UnimplementedError();
});

 */

