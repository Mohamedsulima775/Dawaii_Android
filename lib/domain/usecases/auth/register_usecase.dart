
// domain/usecases/auth/register_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/patient.dart';
import 'package:dawaii/core/errors/failures.dart';
import 'package:dawaii/data/repositories/auth_repository.dart';
import '../usecase.dart';

/// UseCase لتسجيل مستخدم جديد
class RegisterUseCase implements UseCase<AuthResult, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(RegisterParams params) async {
    // Validate input
    final validation = params.validate();
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    // Call repository
    return await repository.register(
      patientName: params.patientName,
      mobile: params.mobile,
      email: params.email,
      password: params.password,
      dateOfBirth: params.dateOfBirth,
      gender: params.gender,
    );
  }
}

/// Parameters للتسجيل
class RegisterParams extends Equatable {
  final String patientName;
  final String mobile;
  final String email;
  final String password;
  final String? dateOfBirth;
  final String? gender;

  const RegisterParams({
    required this.patientName,
    required this.mobile,
    required this.email,
    required this.password,
    this.dateOfBirth,
    this.gender,
  });

  /// Validate inputs
  String? validate() {
    // Name validation
    if (patientName.isEmpty) {
      return 'الاسم مطلوب';
    }

    if (patientName.length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }

    // Mobile validation
    if (mobile.isEmpty) {
      return 'رقم الجوال مطلوب';
    }

    if (mobile.length != 10) {
      return 'رقم الجوال يجب أن يكون 10 أرقام';
    }

    if (!mobile.startsWith('05')) {
      return 'رقم الجوال يجب أن يبدأ بـ 05';
    }

    // Email validation
    if (email.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    // Password validation
    if (password.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (password.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    // Date of birth validation (optional)
    if (dateOfBirth != null && dateOfBirth!.isNotEmpty) {
      try {
        final dob = DateTime.parse(dateOfBirth!);
        final now = DateTime.now();

        if (dob.isAfter(now)) {
          return 'تاريخ الميلاد غير صحيح';
        }

        final age = now.year - dob.year;
        if (age > 150) {
          return 'تاريخ الميلاد غير صحيح';
        }
      } catch (e) {
        return 'تاريخ الميلاد غير صحيح';
      }
    }

    // Gender validation (optional)
    if (gender != null && gender!.isNotEmpty) {
      if (gender != 'ذكر' && gender != 'أنثى' &&
          gender != 'male' && gender != 'female') {
        return 'الجنس غير صحيح';
      }
    }

    return null; // Valid
  }

  @override
  List<Object?> get props => [
    patientName,
    mobile,
    email,
    password,
    dateOfBirth,
    gender,
  ];
}