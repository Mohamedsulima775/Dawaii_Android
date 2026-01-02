
// lib/core/network/api_endpoints.dart


// lib/core/constants/app_constants.dart

class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // ==========================================
  // APP INFO
  // ==========================================

  static const String appName = 'دوائي';
  static const String appNameEn = 'Dawaii';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // ==========================================
  // SUPPORTED LANGUAGES
  // ==========================================

  static const String defaultLanguage = 'ar';
  static const List<String> supportedLanguages = ['ar', 'en'];

  // ==========================================
  // DATE & TIME FORMATS
  // ==========================================

  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String displayDateFormat = 'dd/MM/yyyy';
  static const String displayTimeFormat = 'hh:mm a';
  static const String displayDateTimeFormat = 'dd/MM/yyyy hh:mm a';

  // ==========================================
  // MEDICATION FREQUENCIES
  // ==========================================

  static const Map<String, String> medicationFrequencies = {
    'Daily': 'يومي',
    'Twice Daily': 'مرتين يومياً',
    'Three Times Daily': '3 مرات يومياً',
    'Four Times Daily': '4 مرات يومياً',
    'Weekly': 'أسبوعي',
    'As Needed': 'عند الحاجة',
  };

  // ==========================================
  // ORDER STATUS
  // ==========================================

  static const Map<String, String> orderStatuses = {
    'Pending': 'قيد الانتظار',
    'Confirmed': 'مؤكد',
    'Processing': 'قيد المعالجة',
    'Out for Delivery': 'قيد التوصيل',
    'Delivered': 'تم التوصيل',
    'Cancelled': 'ملغي',
  };

  static const Map<String, String> orderStatusColors = {
    'Pending': '#FFA726',      // Orange
    'Confirmed': '#42A5F5',    // Blue
    'Processing': '#9575CD',   // Purple
    'Out for Delivery': '#26C6DA', // Cyan
    'Delivered': '#66BB6A',    // Green
    'Cancelled': '#EF5350',    // Red
  };

  // ==========================================
  // CONSULTATION STATUS
  // ==========================================

  static const Map<String, String> consultationStatuses = {
    'Pending': 'قيد الانتظار',
    'Active': 'نشط',
    'Completed': 'مكتمل',
    'Cancelled': 'ملغي',
  };

  // ==========================================
  // PAYMENT METHODS
  // ==========================================

  static const Map<String, String> paymentMethods = {
    'Cash': 'كاش',
    'Credit Card': 'بطاقة ائتمان',
    'Debit Card': 'بطاقة مدين',
    'STC Pay': 'STC Pay',
    'Apple Pay': 'Apple Pay',
    'Mada': 'مدى',
  };

  // ==========================================
  // GENDER
  // ==========================================

  static const Map<String, String> genders = {
    'Male': 'ذكر',
    'Female': 'أنثى',
  };

  // ==========================================
  // BLOOD GROUPS
  // ==========================================

  static const List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  // ==========================================
  // VALIDATION RULES
  // ==========================================

  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int mobileLength = 10;
  static const String mobilePrefix = '05';

  // ==========================================
  // REGEX PATTERNS
  // ==========================================

  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String mobilePattern = r'^05[0-9]{8}$';
  static const String passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$';

  // ==========================================
  // CACHE DURATIONS
  // ==========================================

  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 30);
  static const Duration longCacheDuration = Duration(hours: 24);

  // ==========================================
  // LIMITS
  // ==========================================

  static const int maxCartItems = 50;
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const int maxImageSize = 5 * 1024 * 1024; // 5 MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  static const List<String> allowedFileExtensions = ['pdf', 'doc', 'docx'];

  // ==========================================
  // NOTIFICATION CHANNELS
  // ==========================================

  static const String medicationChannelId = 'medication_reminders';
  static const String medicationChannelName = 'تذكيرات الأدوية';
  static const String medicationChannelDescription = 'إشعارات لتذكيرك بتناول أدويتك';

  static const String orderChannelId = 'order_updates';
  static const String orderChannelName = 'تحديثات الطلبات';
  static const String orderChannelDescription = 'إشعارات بحالة طلباتك';

  static const String consultationChannelId = 'consultation_messages';
  static const String consultationChannelName = 'رسائل الاستشارات';
  static const String consultationChannelDescription = 'إشعارات الرسائل الجديدة في الاستشارات';

  // ==========================================
  // ERROR MESSAGES
  // ==========================================

  static const String networkError = 'خطأ في الاتصال بالإنترنت';
  static const String serverError = 'خطأ في الخادم، الرجاء المحاولة لاحقاً';
  static const String unknownError = 'حدث خطأ غير متوقع';
  static const String validationError = 'الرجاء التحقق من البيانات المدخلة';
  static const String authError = 'خطأ في المصادقة، الرجاء تسجيل الدخول مجدداً';
  static const String timeoutError = 'انتهت مهلة الطلب، الرجاء المحاولة مجدداً';

  // ==========================================
  // SUCCESS MESSAGES
  // ==========================================

  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String registerSuccess = 'تم إنشاء الحساب بنجاح';
  static const String updateSuccess = 'تم التحديث بنجاح';
  static const String deleteSuccess = 'تم الحذف بنجاح';
  static const String saveSuccess = 'تم الحفظ بنجاح';

  // ==========================================
  // URLS
  // ==========================================

  static const String privacyPolicyUrl = 'https://dawaii.com/privacy';
  static const String termsOfServiceUrl = 'https://dawaii.com/terms';
  static const String supportEmail = 'support@dawaii.com';
  static const String supportPhone = '+966501234567';
  static const String whatsappNumber = '966501234567';

  // ==========================================
  // SOCIAL MEDIA
  // ==========================================

  static const String facebookUrl = 'https://facebook.com/dawaii';
  static const String twitterUrl = 'https://twitter.com/dawaii';
  static const String instagramUrl = 'https://instagram.com/dawaii';

  // ==========================================
  // ONBOARDING
  // ==========================================

  static const int onboardingPageCount = 3;

  static const List<Map<String, String>> onboardingPages = [
    {
      'title': 'مرحباً بك في دوائي',
      'description': 'تطبيقك الموثوق لإدارة الأدوية والعناية الصحية',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'تتبع أدويتك',
      'description': 'احصل على تذكيرات في الوقت المناسب ولا تفوت أي جرعة',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'استشارات طبية',
      'description': 'تواصل مع الأطباء واحصل على الاستشارات الطبية بسهولة',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  // ==========================================
  // ANIMATIONS
  // ==========================================

  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // ==========================================
  // SPACING
  // ==========================================

  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // ==========================================
  // BORDER RADIUS
  // ==========================================

  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 999.0;

  // ==========================================
  // ELEVATION
  // ==========================================

  static const double elevationXS = 1.0;
  static const double elevationSM = 2.0;
  static const double elevationMD = 4.0;
  static const double elevationLG = 8.0;
  static const double elevationXL = 16.0;

  // ==========================================
  // API CONFIG (أضف هذا القسم)
  // ==========================================

  static const String baseUrl = 'https://dawaii-api.example.com'; // ضع رابط السيرفر الخاص بك هنا
  static const String apiPath = '/api/method'; // حسب هيكلة الـ ERPNext أو السيرفر لديك
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}





/*
//الاول
class AppConstants {
  // API
  static const String baseUrl = 'http://localhost:8000';
  static const String apiPath = '/api/method';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String isFirstTimeKey = 'is_first_time';

  // Pagination
  static const int pageSize = 20;

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Frequencies
  static const List<String> frequencies = [
    'Once Daily',
    'Twice Daily',
    'Three Times Daily',
    'Four Times Daily',
    'As Needed',
  ];

  // Meal Times
  static const List<String> mealTimes = [
    'Before Meal',
    'After Meal',
    'Anytime',
  ];

  // Consultation Types
  static const List<String> consultationTypes = [
    'Chat',
    'Video Call',
    'Voice Call',
    'In-Person',
  ];

  // Order Status
  static const List<String> orderStatuses = [
    'Pending',
    'Confirmed',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  // Prescription Status
  static const List<String> prescriptionStatuses = [
    'Active',
    'Partially Filled',
    'Filled',
    'Expired',
  ];
}

 */