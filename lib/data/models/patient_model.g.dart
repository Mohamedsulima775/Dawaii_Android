// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientModelImpl _$$PatientModelImplFromJson(Map<String, dynamic> json) =>
    _$PatientModelImpl(
      patientId: json['patient_id'] as String,
      patientName: json['patient_name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$$PatientModelImplToJson(_$PatientModelImpl instance) =>
    <String, dynamic>{
      'patient_id': instance.patientId,
      'patient_name': instance.patientName,
      'mobile': instance.mobile,
      'email': instance.email,
      'profile_image': instance.profileImage,
    };

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      token: json['token'] as String,
      patientId: json['patient_id'] as String,
      patientName: json['patient_name'] as String,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'patient_id': instance.patientId,
      'patient_name': instance.patientName,
    };
