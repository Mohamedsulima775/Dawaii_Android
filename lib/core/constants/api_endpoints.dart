
class ApiEndpoints {
  static const String baseUrl = 'http://127.0.0.1';

  // Orders
  static const String createOrder = '/api/method/my_medicinal.api.create_order';
  static const String getOrders = '/api/method/my_medicinal.api.get_orders';
  static const String getOrderDetail = '/api/method/my_medicinal.api.get_order_detail';
  static const String cancelOrder = '/api/method/my_medicinal.api.cancel_order';
  static const String rateOrder = '/api/method/my_medicinal.api.rate_order';
  static const String confirmDelivery = '/api/method/my_medicinal.api.confirm_delivery';

  // Authentication
  static const String register = '/api/method/my_medicinal.my_medicinal.api.patient.register';
  static const String login = '/api/method/my_medicinal.my_medicinal.api.patient.login';
  static const String getProfile = '/api/method/my_medicinal.my_medicinal.api.patient.get_profile';
  static const String updateProfile = '/api/method/my_medicinal.my_medicinal.api.patient.update_profile';
  static const String logout = '/api/method/my_medicinal.my_medicinal.api.patient.logout';

  // Medications
  static const String getMedications = '/api/method/my_medicinal.my_medicinal.api.medication.get_schedules';
  static const String addMedication = '/api/method/my_medicinal.my_medicinal.api.medication.add_schedule';
  static const String logMedication = '/api/method/my_medicinal.my_medicinal.api.medication.log_medication';
  // Prescriptions
  static const String getPrescriptions = '/api/method/my_medicinal.my_medicinal.api.prescription.get_prescriptions';

  // Consultations
  static const String getConsultations = '/api/method/my_medicinal.my_medicinal.api.consultation.get_consultations';
  static const String createConsultation = '/api/method/my_medicinal.my_medicinal.api.consultation.create_consultation';

  // Notifications
  static const String registerDevice = '/api/method/my_medicinal.my_medicinal.notifications.register_device';
}

const String baseUrl = 'http://localhost:8000';
const String apiPath = '/api/method';
// Timeouts
const Duration connectTimeout = Duration(seconds: 30);
const Duration receiveTimeout = Duration(seconds: 30);

// Prescription Status
