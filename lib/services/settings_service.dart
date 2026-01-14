
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  // Backend URL - use the production API
  static const String baseUrl = 'https://dawaii.com/api/method';

  // Get authorization token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Get Profile
  Future<Map<String, dynamic>> getProfile(String patientId) async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse('$baseUrl/my_medicinal.api.patient.get_profile'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading profile: $e');
    }
  }

  // Update Profile
  Future<Map<String, dynamic>> updateProfile(
      String patientId,
      Map<String, dynamic> profileData,
      ) async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/my_medicinal.api.patient.update_profile'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'patient_id': patientId,
          'profile_data': json.encode(profileData),
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }

  // Change Password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final token = await _getToken();
      final prefs = await SharedPreferences.getInstance();
      final mobile = prefs.getString('patient_mobile');

      if (mobile == null) {
        throw Exception('User not logged in');
      }

      // Verify current password by trying to login
      final loginResponse = await http.post(
        Uri.parse('$baseUrl/my_medicinal.api.patient.login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mobile': mobile,
          'password': currentPassword,
        }),
      );

      if (loginResponse.statusCode != 200) {
        throw Exception('كلمة المرور الحالية غير صحيحة');
      }

      // Update password using Frappe's update_password API
      final updateResponse = await http.post(
        Uri.parse('$baseUrl/frappe.client.set_value'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'doctype': 'User',
          'name': '$mobile@dawaii.local',
          'fieldname': 'new_password',
          'value': newPassword,
        }),
      );

      if (updateResponse.statusCode != 200) {
        throw Exception('فشل تحديث كلمة المرور');
      }
    } catch (e) {
      throw Exception('Error changing password: $e');
    }
  }

  // Send Test Notification
  Future<void> sendTestNotification() async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse(
            '$baseUrl/my_medicinal.my_medicinal.notifications.send_test_notification'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'title': 'اختبار الإشعارات',
          'body': 'هذا إشعار تجريبي من إعدادات التطبيق 🎉',
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send test notification');
      }
    } catch (e) {
      throw Exception('Error sending test notification: $e');
    }
  }

  // Register Device for FCM
  Future<void> registerDevice({
    required String fcmToken,
    required String deviceType,
    String? deviceId,
  }) async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse(
            '$baseUrl/my_medicinal.my_medicinal.notifications.register_device'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'fcm_token': fcmToken,
          'device_type': deviceType,
          if (deviceId != null) 'device_id': deviceId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to register device');
      }
    } catch (e) {
      throw Exception('Error registering device: $e');
    }
  }

  // Get Notifications
  Future<List<Map<String, dynamic>>> getNotifications({int limit = 20}) async {
    try {
      final token = await _getToken();

      final response = await http.get(
        Uri.parse(
            '$baseUrl/my_medicinal.my_medicinal.notifications.get_my_notifications?limit=$limit'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['message']);
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Error loading notifications: $e');
    }
  }

  // Mark Notification as Read
  Future<void> markNotificationRead(String notificationId) async {
    try {
      final token = await _getToken();

      final response = await http.post(
        Uri.parse(
            '$baseUrl/my_medicinal.my_medicinal.notifications.mark_notification_read'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'notification_id': notificationId,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to mark notification as read');
      }
    } catch (e) {
      throw Exception('Error marking notification as read: $e');
    }
  }
}
