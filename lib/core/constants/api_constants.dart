//lib/core/constants/api_constants.dart
/*
// الاول

class ApiConstants {
  // Base URL - غيّره حسب سيرفر محمد
  static const String baseUrl = 'https://your-domain.com';

  // Endpoints
  static const String login = '/api/method/login';
  static const String register = '/api/method/patient.register';

  static const String getMedications = '/api/method/medication.get_list';
  static const String addMedication = '/api/method/medication.add_schedule';
  static const String logTaken = '/api/method/medication.log_taken';

  static const String getProducts = '/api/method/shop.get_products';
  static const String createOrder = '/api/method/order.create';

  static const String getConsultations = '/api/method/consultation.get_list';
  static const String sendMessage = '/api/method/consultation.send_message';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}

 */

// lib/core/constants/api_constants.dart

class ApiConstants {
  // Prevent instantiation
  ApiConstants._();

  // ==========================================
  // BASE URLs
  // ==========================================

  // Development - للتطوير المحلي
  // Android Emulator uses 10.0.2.2 to access host's localhost
  static const String devBaseUrl = 'http://10.0.2.2:8000';

  // Production - للإنتاج
  static const String prodBaseUrl = 'https://dawaii.com';

  // Current base URL - غيّر هذا حسب البيئة
  // استخدم devBaseUrl للتطوير، prodBaseUrl للإنتاج
  static const String baseUrl = devBaseUrl;

  // API base path
  static const String apiPath = '/api/method';
  static const String fullBaseUrl = '$baseUrl$apiPath';

  // ==========================================
  // AUTHENTICATION ENDPOINTS
  // ==========================================

  static const String login = '/my_medicinal.api.patient.login';
  static const String register = '/my_medicinal.api.patient.register';
  static const String refreshToken = '/my_medicinal.api.patient.refresh_token';
  static const String getProfile = '/my_medicinal.api.patient.get_profile';
  static const String updateProfile = '/my_medicinal.api.patient.update_profile';
  static const String logout = '/my_medicinal.api.patient.logout';

  // ==========================================
  // MEDICATION ENDPOINTS
  // ==========================================

  static const String getMedications = '/my_medicinal.api.medication_schedule.get_medications';
  static const String getMedicationsDue = '/my_medicinal.api.medication_schedule.get_medications_due';
  static const String getLowStockMedications = '/my_medicinal.api.medication_schedule.get_low_stock_medications';
  static const String addMedication = '/my_medicinal.api.medication_schedule.add_medication';
  static const String logMedicationTaken = '/my_medicinal.api.medication_schedule.log_medication_taken';
  static const String updateStock = '/my_medicinal.api.medication_schedule.update_stock';
  static const String deactivateMedication = '/my_medicinal.api.medication_schedule.deactivate_medication';
  static const String getMedicationLogs = '/my_medicinal.api.medication_schedule.get_medication_logs';

  // ==========================================
  // ORDER ENDPOINTS
  // ==========================================

  static const String createOrder = '/my_medicinal.api.order.create_order';
  static const String getMyOrders = '/my_medicinal.api.order.get_my_orders';
  static const String getOrderDetail = '/my_medicinal.api.order.get_order_detail';
  static const String cancelOrder = '/my_medicinal.api.order.cancel_order';
  static const String rateOrder = '/my_medicinal.api.order.rate_order';
  static const String confirmDelivery = '/my_medicinal.api.order.confirm_delivery';

  // ==========================================
  // PRODUCT ENDPOINTS
  // ==========================================

  static const String getProducts = '/my_medicinal.api.product.get_products';
  static const String searchProducts = '/my_medicinal.api.product.search_products';
  static const String getProductDetails = '/my_medicinal.api.product.get_product_details';

  // ==========================================
  // CONSULTATION ENDPOINTS
  // ==========================================

  static const String createConsultation = '/my_medicinal.api.consultation.create_consultation';
  static const String getMyConsultations = '/my_medicinal.api.consultation.get_my_consultations';
  static const String sendMessage = '/my_medicinal.api.consultation.send_message';
  static const String getMessages = '/my_medicinal.api.consultation.get_messages';

  // ==========================================
  // PRESCRIPTION ENDPOINTS
  // ==========================================

  static const String getMyPrescriptions = '/my_medicinal.api.prescription.get_my_prescriptions';
  static const String getPrescriptionDetails = '/my_medicinal.api.prescription.get_prescription_details';

  // ==========================================
  // PROVIDER ENDPOINTS
  // ==========================================

  static const String getProviders = '/my_medicinal.api.provider.get_providers';
  static const String getProviderSchedule = '/my_medicinal.api.provider.get_schedule';

  // ==========================================
  // NOTIFICATION ENDPOINTS
  // ==========================================

  static const String registerDevice = '/my_medicinal.api.notifications.register_device';
  static const String sendTestNotification = '/my_medicinal.api.notifications.send_test_notification';
  static const String getMyNotifications = '/my_medicinal.api.notifications.get_my_notifications';
  static const String markNotificationRead = '/my_medicinal.api.notifications.mark_notification_read';

  // ==========================================
  // HEADERS
  // ==========================================

  static Map<String, String> getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ==========================================
  // TIMEOUTS
  // ==========================================

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ==========================================
  // PAGINATION
  // ==========================================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ==========================================
  // RETRY CONFIG
  // ==========================================

  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}

