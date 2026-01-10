//lib/presentation/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/network/api_client.dart';
import '../../data/data_sources/remote/auth_api.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/patient.dart';

// ============================================================================
// STATE
// ============================================================================

@immutable
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final Patient? patient;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.patient,
    this.error,
  });

  // Helper getters for backward compatibility
  String? get patientId => patient?.id;
  String? get patientName => patient?.name;

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    Patient? patient,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      patient: patient ?? this.patient,
      error: error,
    );
  }
}

// ============================================================================
// PROVIDERS
// ============================================================================

/// Secure Storage Provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// API Client Provider
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

/// Auth API Provider
final authApiProvider = Provider<AuthApi>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthApi(apiClient);
});

/// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authApi = ref.watch(authApiProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(
    authApi: authApi,
    secureStorage: secureStorage,
  );
});

// ============================================================================
// NOTIFIER
// ============================================================================

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkAuthStatus();
  }

  /// Check if user is already logged in
  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await _authRepository.isLoggedIn();

    if (isLoggedIn) {
      final result = await _authRepository.getCurrentUser();

      result.fold(
        (failure) {
          // Failed to get user, clear auth state
          state = const AuthState();
        },
        (patient) {
          if (patient != null) {
            state = state.copyWith(
              isAuthenticated: true,
              patient: patient,
            );
          }
        },
      );
    }
  }

  /// Login with mobile and password
  Future<void> login({
    required String mobile,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _authRepository.login(
      mobile: mobile,
      password: password,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (authResult) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          patient: authResult.patient,
        );
      },
    );
  }

  /// Register new user
  Future<void> register({
    required String mobile,
    required String password,
    required String patientName,
    required String email,
    String? dateOfBirth,
    String? gender,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _authRepository.register(
      mobile: mobile,
      password: password,
      patientName: patientName,
      email: email,
      dateOfBirth: dateOfBirth,
      gender: gender,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (authResult) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          patient: authResult.patient,
        );
      },
    );
  }

  /// Logout current user
  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// ============================================================================
// AUTH PROVIDER
// ============================================================================

/// Main Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});
