// lib/data/models/auth_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String token,           // ✅ أضف هذا
    @JsonKey(name: 'patient_id') required String patientId,     // ✅ أضف هذا
    @JsonKey(name: 'patient_name') required String patientName, // ✅ أضف هذا
    required String message,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

/*
  #fonts:
  # - family: Cairo
      fonts:
        - asset: assets/fonts/Cairo-Regular.ttf
        - asset: assets/fonts/Cairo-Bold.ttf
          weight: 700
 */