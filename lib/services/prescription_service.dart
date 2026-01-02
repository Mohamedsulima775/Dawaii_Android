
import '../data/models/prescription_model.dart';
import '../domain/entities/prescription.dart';
import 'api_service.dart';
//import '../domain/usecases/prescription/get_Patient_Prescriptions.dart';

class PrescriptionService {
  final ApiService _apiService;

  PrescriptionService(this._apiService);

  // Get patient prescriptions
  Future<List<PrescriptionModel>> getPatientPrescriptions(String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_patient_prescriptions',
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
      'my_medicinal.api.get_prescription_details',
      params: {'prescription_id': prescriptionId},
    );

    return PrescriptionModel.fromJson(response['message']);
  }

  // Create schedules from prescription
  Future<void> createSchedulesFromPrescription(
      String prescriptionId, List<Map<String, dynamic>> medications) async {
    await _apiService.post(
      'my_medicinal.api.create_schedules_from_prescription',
      data: {
        'prescription_id': prescriptionId,
        'medications': medications,
      },
    );
  }

  // Download prescription PDF
  Future<String> downloadPrescriptionPdf(String prescriptionId) async {
    final response = await _apiService.post(
      'my_medicinal.api.download_prescription_pdf',
      data: {'prescription_id': prescriptionId},
    );

    return response['message']['pdf_url'];
  }
}