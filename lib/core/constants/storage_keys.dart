
// lib/core/constants/storage_keys.dart

class StorageKeys {
  // Prevent instantiation
  StorageKeys._();

  // ==========================================
  // AUTHENTICATION
  // ==========================================

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userMobile = 'user_mobile';
  static const String isLoggedIn = 'is_logged_in';
  static const String rememberMe = 'remember_me';
  static const String biometricEnabled = 'biometric_enabled';

  // ==========================================
  // USER DATA
  // ==========================================

  static const String userName = 'user_name';
  static const String userProfile = 'user_profile';
  static const String patientId = 'patient_id';
  static const String patientName = 'patient_name';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String bloodGroup = 'blood_group';
  static const String allergies = 'allergies';
  static const String chronicDiseases = 'chronic_diseases';

  // ==========================================
  // SETTINGS
  // ==========================================

  static const String language = 'language';
  static const String theme = 'theme';
  static const String isDarkMode = 'is_dark_mode';
  static const String fontSize = 'font_size';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';

  // ==========================================
  // NOTIFICATIONS
  // ==========================================

  static const String fcmToken = 'fcm_token';
  static const String deviceId = 'device_id';
  static const String medicationRemindersEnabled = 'medication_reminders_enabled';
  static const String orderUpdatesEnabled = 'order_updates_enabled';
  static const String consultationMessagesEnabled = 'consultation_messages_enabled';
  static const String lowStockAlertsEnabled = 'low_stock_alerts_enabled';
  static const String reminderSound = 'reminder_sound';
  static const String reminderVibration = 'reminder_vibration';

  // ==========================================
  // ONBOARDING
  // ==========================================

  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String firstTimeUser = 'first_time_user';

  // ==========================================
  // CACHE
  // ==========================================

  static const String cachedMedications = 'cached_medications';
  static const String cachedOrders = 'cached_orders';
  static const String cachedProducts = 'cached_products';
  static const String cachedConsultations = 'cached_consultations';
  static const String cachedPrescriptions = 'cached_prescriptions';
  static const String cacheTimestamp = 'cache_timestamp';
  static const String lastSyncTime = 'last_sync_time';

  // ==========================================
  // APP STATE
  // ==========================================

  static const String lastRoute = 'last_route';
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';
  static const String lastUpdateCheck = 'last_update_check';
  static const String installDate = 'install_date';

  // ==========================================
  // SEARCH HISTORY
  // ==========================================
  static const String medications = 'medications_key';
  static const String medicationSearchHistory = 'medication_search_history';
  static const String productSearchHistory = 'product_search_history';
  static const String recentSearches = 'recent_searches';

  // ==========================================
  // CART
  // ==========================================

  static const String cartItems = 'cart_items';
  static const String cartCount = 'cart_count';
  static const String cartTotal = 'cart_total';

  // ==========================================
  // FILTERS & PREFERENCES
  // ==========================================

  static const String medicationFilter = 'medication_filter';
  static const String orderFilter = 'order_filter';
  static const String productSortBy = 'product_sort_by';
  static const String defaultPaymentMethod = 'default_payment_method';
  static const String defaultAddress = 'default_address';

  // ==========================================
  // ANALYTICS
  // ==========================================

  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportsEnabled = 'crash_reports_enabled';
  static const String performanceMonitoringEnabled = 'performance_monitoring_enabled';

  // ==========================================
  // SECURITY
  // ==========================================

  static const String lastPasswordChange = 'last_password_change';
  static const String sessionTimeout = 'session_timeout';
  static const String autoLogoutEnabled = 'auto_logout_enabled';
  static const String autoLogoutDuration = 'auto_logout_duration';

  // ==========================================
  // DEBUG
  // ==========================================

  static const String debugMode = 'debug_mode';
  static const String showLogs = 'show_logs';
  static const String apiLogsEnabled = 'api_logs_enabled';

  // ==========================================
  // HELPER METHODS
  // ==========================================

  /// Get cache key with timestamp suffix
  static String getCacheKey(String key) {
    return '${key}_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Get timestamped key for specific data
  static String getTimestampedKey(String key, String id) {
    return '${key}_${id}_timestamp';
  }

  /// Clear all auth-related keys
  static List<String> get authKeys => [
    authToken,
    refreshToken,
    userId,
    userEmail,
    userMobile,
    isLoggedIn,
  ];

  /// Clear all user data keys
  static List<String> get userDataKeys => [
    userName,
    userProfile,
    patientId,
    patientName,
    dateOfBirth,
    gender,
    bloodGroup,
    allergies,
    chronicDiseases,
  ];

  /// Clear all cache keys
  static List<String> get cacheKeys => [
    cachedMedications,
    cachedOrders,
    cachedProducts,
    cachedConsultations,
    cachedPrescriptions,
    cacheTimestamp,
    lastSyncTime,
  ];

  /// Get all keys that should be cleared on logout
  static List<String> get logoutKeys => [
    ...authKeys,
    ...userDataKeys,
    ...cacheKeys,
    fcmToken,
    cartItems,
    cartCount,
    cartTotal,
  ];

  /// Get all keys that should persist across logout
  static List<String> get persistentKeys => [
    language,
    theme,
    isDarkMode,
    fontSize,
    hasSeenOnboarding,
    onboardingCompleted,
    rememberMe,
    biometricEnabled,
    notificationsEnabled,
    soundEnabled,
    vibrationEnabled,
  ];
}