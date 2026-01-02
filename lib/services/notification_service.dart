import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:io';

/// Top-level function for background messages
/// يجب أن تكون خارج الـ class
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('📬 Background message received: ${message.messageId}');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');
}

class NotificationService {
  // Singleton pattern
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Firebase Messaging instance
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Local Notifications instance
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  // FCM Token (سنرسله للـ Backend)
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  // Callback عند النقر على الإشعار
  Function(Map<String, dynamic>)? onNotificationTap;

  /// Initialize notification service
  Future<void> initialize() async {
    print('🔔 Initializing Notification Service...');

    // 1. Initialize timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Riyadh')); // توقيت السعودية

    // 2. Request permission (مهم جداً!)
    await _requestPermission();

    // 3. Initialize local notifications
    await _initializeLocalNotifications();

    // 4. Setup FCM
    await _setupFCM();

    print('✅ Notification Service initialized successfully!');
  }

  Future<void> enableMedicationReminders() async {
    // تفعيل إشعارات الدواء
    print('Medication reminders enabled');
  }

  Future<void> disableMedicationReminders() async {
    // إيقاف إشعارات الدواء
    print('Medication reminders disabled');
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    print('📱 Requesting notification permission...');

    // iOS & Android 13+
    final settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('⚠️ User granted provisional permission');
    } else {
      print('❌ User declined permission');
    }

    // Additional permission for Android 13+ (POST_NOTIFICATIONS)
    if (Platform.isAndroid) {
      final androidPlugin = _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

// Request exact alarm permission (Android 13+)
      await androidPlugin?.requestNotificationsPermission();

      // Request exact alarm permission (Android 12+)
      await androidPlugin?.requestExactAlarmsPermission();
    }
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    print('📲 Initializing local notifications...');

    // Android settings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS settings
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onLocalNotificationTap,
    );

    // Create notification channel (Android only)
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }

    print('✅ Local notifications initialized');
  }

  /// Create Android notification channel
  Future<void> _createNotificationChannel() async {
    const channel = AndroidNotificationChannel(
      'medication_reminders', // ID
      'تذكيرات الأدوية',      // Name
      description: 'إشعارات مواعيد تناول الأدوية',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    print('✅ Notification channel created');
  }

  /// Setup Firebase Cloud Messaging
  Future<void> _setupFCM() async {
    print('🔥 Setting up FCM...');

    // Get FCM token
    _fcmToken = await _fcm.getToken();
    print('📱 FCM Token: $_fcmToken');

    // TODO: Send token to backend (محمد سيحتاجه)
    // await _sendTokenToBackend(_fcmToken!);

    // Listen to token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      print('🔄 FCM Token refreshed: $newToken');
      // TODO: Send new token to backend
    });

    // Handle messages based on app state

    // 1. Foreground (التطبيق مفتوح)
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 2. Background (التطبيق في الخلفية)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 3. Terminated → Opened (مغلق ثم فتح من الإشعار)
    _fcm.getInitialMessage().then((message) {
      if (message != null) {
        print('📬 App opened from terminated state');
        _handleNotificationOpen(message);
      }
    });

    // 4. Background → Opened (في الخلفية ثم فتح من الإشعار)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);

    print('✅ FCM setup complete');
  }

  /// Handle foreground message (التطبيق مفتوح)
  void _handleForegroundMessage(RemoteMessage message) {
    print('📬 Foreground message received');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Data: ${message.data}');

    // عرض الإشعار محلياً
    showLocalNotification(
      title: message.notification?.title ?? 'إشعار',
      body: message.notification?.body ?? '',
      payload: message.data,
    );
  }

  /// Handle notification tap (عند النقر على الإشعار)
  void _handleNotificationOpen(RemoteMessage message) {
    print('👆 Notification tapped');
    print('Data: ${message.data}');

    // Call callback with data
    if (onNotificationTap != null) {
      onNotificationTap!(message.data);
    }

    // TODO: Navigate based on notification type
    // مثلاً: إذا كان notification عن دواء، افتح صفحة الأدوية
  }

  /// Handle local notification tap
  void _onLocalNotificationTap(NotificationResponse response) {
    print('👆 Local notification tapped');
    print('Payload: ${response.payload}');

    if (response.payload != null) {
      // Parse payload and navigate
      // final data = jsonDecode(response.payload!);
      if (onNotificationTap != null) {
        // onNotificationTap!(data);
      }
    }
  }

  /// Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
    int id = 0,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'medication_reminders',
      'تذكيرات الأدوية',
      channelDescription: 'إشعارات مواعيد تناول الأدوية',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      details,
      payload: payload?.toString(),
    );
  }

  /// Schedule medication reminder (جدولة تذكير الدواء)
  Future<void> scheduleMedicationReminder({
    required int id,
    required String medicationName,
    required DateTime scheduledTime,
    String? notes,
  }) async {
    print('⏰ Scheduling reminder for: $medicationName at $scheduledTime');

    const androidDetails = AndroidNotificationDetails(
      'medication_reminders',
      'تذكيرات الأدوية',
      channelDescription: 'إشعارات مواعيد تناول الأدوية',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(''),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Convert to TZDateTime
    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _localNotifications.zonedSchedule(
      id,
      '⏰ موعد الدواء',
      'حان وقت تناول $medicationName${notes != null ? "\n$notes" : ""}',
      tzScheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // يتكرر يومياً
    );

    print('✅ Reminder scheduled successfully');
  }

  /// Schedule multiple reminders (for medication with multiple times)
  Future<void> scheduleMedicationReminders({
    required String medicationName,
    required List<DateTime> times,
    String? notes,
  }) async {
    for (int i = 0; i < times.length; i++) {
      await scheduleMedicationReminder(
        id: medicationName.hashCode + i, // Unique ID
        medicationName: medicationName,
        scheduledTime: times[i],
        notes: notes,
      );
    }
  }

  /// Cancel specific notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
    print('❌ Notification $id cancelled');
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
    print('❌ All notifications cancelled');
  }

  /// Get pending notifications (للتحقق من الإشعارات المجدولة)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _localNotifications.pendingNotificationRequests();
  }

  /// Send FCM token to backend
  Future<void> sendTokenToBackend(String userId) async {
    if (_fcmToken == null) return;

    try {
      // TODO: استدعاء API لإرسال الـ token لمحمد
      /*
      await apiClient.post(
        '/api/method/update_fcm_token',
        data: {
          'user_id': userId,
          'fcm_token': _fcmToken,
          'platform': Platform.isAndroid ? 'android' : 'ios',
        },
      );
      */
      print('✅ FCM token sent to backend');
    } catch (e) {
      print('❌ Error sending FCM token: $e');
    }
  }
}