//lib/data/models/patient_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_model.freezed.dart';
part 'patient_model.g.dart';

@freezed
class PatientModel with _$PatientModel {
  const factory PatientModel({
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'patient_name') required String patientName,
    required String mobile,
    String? email,
    @JsonKey(name: 'profile_image') String? profileImage,
  }) = _PatientModel;

  factory PatientModel.fromJson(Map<String, dynamic> json) =>
      _$PatientModelFromJson(json);
}

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String token,
    @JsonKey(name: 'patient_id') required String patientId,
    @JsonKey(name: 'patient_name') required String patientName,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

