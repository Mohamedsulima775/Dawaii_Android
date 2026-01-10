// lib/services/prescription_service.dart

import '../core/constants/api_constants.dart';
import '../data/models/prescription_model.dart';
import 'api_service.dart';

class PrescriptionService {
  final ApiService _apiService;

  PrescriptionService(this._apiService);

  // Get patient prescriptions
  Future<List<PrescriptionModel>> getPatientPrescriptions(String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getMyPrescriptions,
      params: {'patient_id': patientId},
    );

    return (response['message'] as List?)
        ?.map((p) => PrescriptionModel.fromJson(p))
        .toList() ??
        [];
  }

  // Get prescription details
  Future<PrescriptionModel> getPrescriptionDetails(String prescriptionId) async {
    final response = await _apiService.get(
      ApiConstants.getPrescriptionDetails,
      params: {'prescription_id': prescriptionId},
    );

    return PrescriptionModel.fromJson(response['message']);
  }
}
