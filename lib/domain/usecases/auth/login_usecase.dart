// domain/usecases/auth/login_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:dawaii/domain/entities/patient.dart';
import 'package:dawaii/core/errors/failures.dart';
import 'package:dawaii/data/repositories/auth_repository.dart';
import '../usecase.dart';

/// UseCase لتسجيل الدخول
class LoginUseCase implements UseCase<AuthResult, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(LoginParams params) async {
    // Validate input
    final validation = params.validate();
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    // Call repository
    return await repository.login(
      mobile: params.mobile,
      password: params.password,
    );
  }
}

/// Parameters لتسجيل الدخول
class LoginParams extends Equatable {
  final String mobile;
  final String password;

  const LoginParams({
    required this.mobile,
    required this.password,
  });

  /// Validate inputs
  String? validate() {
    if (mobile.isEmpty) {
      return 'رقم الجوال مطلوب';
    }

    if (mobile.length != 10) {
      return 'رقم الجوال يجب أن يكون 10 أرقام';
    }

    if (!mobile.startsWith('05')) {
      return 'رقم الجوال يجب أن يبدأ بـ 05';
    }

    if (password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (password.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    return null; // Valid
  }

  @override
  List<Object?> get props => [mobile, password];
}