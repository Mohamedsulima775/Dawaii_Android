// lib/core/constants/api_endpoints.dart
//
// ملف يحتوي على جميع نقاط الـ API للتكامل مع My_medicinal Backend
// يمكن استخدامه للاختبار والتطوير

import 'api_constants.dart';

class ApiEndpoints {
  // Prevent instantiation
  ApiEndpoints._();

  // ==========================================
  // BASE URL
  // ==========================================

  static String get baseUrl => ApiConstants.baseUrl;
  static String get fullBaseUrl => ApiConstants.fullBaseUrl;

  // ==========================================
  // AUTHENTICATION ENDPOINTS
  // ==========================================

  /// POST - تسجيل الدخول
  /// Body: {mobile, password}
  static const String login = '/my_medicinal.api.patient.login';

  /// POST - تسجيل حساب جديد
  /// Body: {patient_name, mobile, email, password, date_of_birth, gender}
  static const String register = '/my_medicinal.api.patient.register';

  /// POST - تجديد التوكن
  /// Body: {refresh_token}
  static const String refreshToken = '/my_medicinal.api.patient.refresh_token';

  /// GET - جلب الملف الشخصي
  /// Headers: Authorization: Bearer {token}
  static const String getProfile = '/my_medicinal.api.patient.get_profile';

  /// POST - تحديث الملف الشخصي
  /// Body: {patient_name, email, date_of_birth, gender, blood_group, allergies}
  static const String updateProfile = '/my_medicinal.api.patient.update_profile';

  /// POST - تسجيل الخروج
  static const String logout = '/my_medicinal.api.patient.logout';

  // ==========================================
  // MEDICATION ENDPOINTS
  // ==========================================

  /// GET - جلب قائمة الأدوية
  /// Query: {patient_id}
  static const String getMedications = '/my_medicinal.api.medication_schedule.get_medications';

  /// GET - جلب الأدوية المستحقة
  /// Query: {patient_id}
  static const String getMedicationsDue = '/my_medicinal.api.medication_schedule.get_medications_due';

  /// GET - جلب الأدوية منخفضة المخزون
  /// Query: {patient_id}
  static const String getLowStockMedications = '/my_medicinal.api.medication_schedule.get_low_stock_medications';

  /// POST - إضافة دواء جديد
  /// Body: {patient_id, medication_name, dosage, frequency, start_date, times, stock}
  static const String addMedication = '/my_medicinal.api.medication_schedule.add_medication';

  /// POST - تسجيل تناول الدواء
  /// Body: {schedule_id, time_id, taken_at}
  static const String logMedicationTaken = '/my_medicinal.api.medication_schedule.log_medication_taken';

  /// POST - تحديث المخزون
  /// Body: {schedule_id, stock}
  static const String updateStock = '/my_medicinal.api.medication_schedule.update_stock';

  /// POST - إلغاء تفعيل دواء
  /// Body: {schedule_id}
  static const String deactivateMedication = '/my_medicinal.api.medication_schedule.deactivate_medication';

  /// GET - جلب سجلات الدواء
  /// Query: {schedule_id}
  static const String getMedicationLogs = '/my_medicinal.api.medication_schedule.get_medication_logs';

  // ==========================================
  // ORDER ENDPOINTS
  // ==========================================

  /// POST - إنشاء طلب جديد
  /// Body: {patient_id, items, delivery_address, delivery_city, delivery_phone, payment_method}
  static const String createOrder = '/my_medicinal.api.order.create_order';

  /// GET - جلب طلباتي
  /// Query: {patient_id}
  static const String getMyOrders = '/my_medicinal.api.order.get_my_orders';

  /// GET - جلب تفاصيل طلب
  /// Query: {order_id}
  static const String getOrderDetail = '/my_medicinal.api.order.get_order_detail';

  /// POST - إلغاء طلب
  /// Body: {order_id}
  static const String cancelOrder = '/my_medicinal.api.order.cancel_order';

  /// POST - تقييم طلب
  /// Body: {order_id, rating, comment}
  static const String rateOrder = '/my_medicinal.api.order.rate_order';

  /// POST - تأكيد استلام الطلب
  /// Body: {order_id}
  static const String confirmDelivery = '/my_medicinal.api.order.confirm_delivery';

  // ==========================================
  // PRODUCT ENDPOINTS
  // ==========================================

  /// GET - جلب المنتجات
  /// Query: {page, limit, category}
  static const String getProducts = '/my_medicinal.api.product.get_products';

  /// GET - البحث في المنتجات
  /// Query: {query, page, limit}
  static const String searchProducts = '/my_medicinal.api.product.search_products';

  /// GET - جلب تفاصيل منتج
  /// Query: {product_id}
  static const String getProductDetails = '/my_medicinal.api.product.get_product_details';

  /// GET - جلب المنتجات المميزة
  static const String getFeaturedProducts = '/my_medicinal.api.product.get_featured_products';

  /// GET - جلب منتجات حسب الفئة
  /// Query: {category}
  static const String getProductsByCategory = '/my_medicinal.api.product.get_products_by_category';

  /// GET - فحص المخزون
  /// Query: {product_id, quantity}
  static const String checkStock = '/my_medicinal.api.product.check_stock';

  // ==========================================
  // CONSULTATION ENDPOINTS
  // ==========================================

  /// POST - إنشاء استشارة جديدة
  /// Body: {patient_id, provider_id, type, description}
  static const String createConsultation = '/my_medicinal.api.consultation.create_consultation';

  /// GET - جلب استشاراتي
  /// Query: {patient_id}
  static const String getMyConsultations = '/my_medicinal.api.consultation.get_my_consultations';

  /// POST - إرسال رسالة
  /// Body: {consultation_id, message, attachment}
  static const String sendMessage = '/my_medicinal.api.consultation.send_message';

  /// GET - جلب الرسائل
  /// Query: {consultation_id}
  static const String getMessages = '/my_medicinal.api.consultation.get_messages';

  // ==========================================
  // PRESCRIPTION ENDPOINTS
  // ==========================================

  /// GET - جلب وصفاتي الطبية
  /// Query: {patient_id}
  static const String getMyPrescriptions = '/my_medicinal.api.prescription.get_my_prescriptions';

  /// GET - جلب تفاصيل وصفة
  /// Query: {prescription_id}
  static const String getPrescriptionDetails = '/my_medicinal.api.prescription.get_prescription_details';

  // ==========================================
  // PROVIDER ENDPOINTS
  // ==========================================

  /// GET - جلب قائمة مقدمي الخدمة
  /// Query: {specialty, page, limit}
  static const String getProviders = '/my_medicinal.api.provider.get_providers';

  /// GET - جلب جدول مقدم الخدمة
  /// Query: {provider_id, date}
  static const String getProviderSchedule = '/my_medicinal.api.provider.get_schedule';

  // ==========================================
  // NOTIFICATION ENDPOINTS
  // ==========================================

  /// POST - تسجيل الجهاز للإشعارات
  /// Body: {patient_id, fcm_token, platform, device_id}
  static const String registerDevice = '/my_medicinal.api.notifications.register_device';

  /// POST - إرسال إشعار تجريبي
  /// Body: {patient_id}
  static const String sendTestNotification = '/my_medicinal.api.notifications.send_test_notification';

  /// GET - جلب إشعاراتي
  /// Query: {patient_id}
  static const String getMyNotifications = '/my_medicinal.api.notifications.get_my_notifications';

  /// POST - تحديد إشعار كمقروء
  /// Body: {notification_id}
  static const String markNotificationRead = '/my_medicinal.api.notifications.mark_notification_read';

  // ==========================================
  // HELPER METHODS
  // ==========================================

  /// بناء URL كامل للـ endpoint
  static String buildUrl(String endpoint) {
    return '${ApiConstants.baseUrl}${ApiConstants.apiPath}$endpoint';
  }

  /// الحصول على Headers مع التوكن
  static Map<String, String> getHeaders({String? token}) {
    return ApiConstants.getHeaders(token: token);
  }
}
