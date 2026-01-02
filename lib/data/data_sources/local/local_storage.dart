
/*
//الاول
import '../../models/medication_model.dart';
class LocalStorage {
  LocalStorage();

  /// حفظ الأدوية محليًا (وهمي حاليًا)
  Future<void> saveMedications(List<MedicationSchedule> medications) async {
    // TODO: implement real local storage later
  }

  /// جلب الأدوية من التخزين المحلي (وهمي حاليًا)
  Future<List<MedicationSchedule>> getMedications() async {
    // TODO: implement real local storage later
    return [];
  }
}

 */

// lib/data/data_sources/local/local_storage.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../core/errors/exceptions.dart';
//import '../../models/medication_model.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  // ==========================================
  // AUTH
  // ==========================================

  Future<void> saveAuthToken(String token) async {
    try {
      await _prefs.setString(StorageKeys.authToken, token);
    } catch (e) {
      throw StorageWriteException('فشل في حفظ التوكن: $e');
    }
  }

  String? getAuthToken() {
    try {
      return _prefs.getString(StorageKeys.authToken);
    } catch (e) {
      throw StorageReadException('فشل في قراءة التوكن: $e');
    }
  }

  Future<void> deleteAuthToken() async {
    try {
      await _prefs.remove(StorageKeys.authToken);
    } catch (e) {
      throw StorageDeleteException('فشل في حذف التوكن: $e');
    }
  }

  bool get isLoggedIn => getAuthToken() != null;

  // ==========================================
  // USER DATA
  // ==========================================

  Future<void> saveUserId(String userId) async {
    await _prefs.setString(StorageKeys.userId, userId);
  }

  String? getUserId() {
    return _prefs.getString(StorageKeys.userId);
  }

  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _prefs.setString(
      StorageKeys.userProfile,
      jsonEncode(profile),
    );
  }

  // ==========================================
  // SETTINGS
  // ==========================================

  Future<void> saveLanguage(String language) async {
    await _prefs.setString(StorageKeys.language, language);
  }

  String getLanguage() {
    return _prefs.getString(StorageKeys.language) ?? 'ar';
  }

  Future<void> saveDarkMode(bool isDark) async {
    await _prefs.setBool(StorageKeys.isDarkMode, isDark);
  }

  bool getDarkMode() {
    return _prefs.getBool(StorageKeys.isDarkMode) ?? false;
  }

  // ==========================================
  // FCM TOKEN
  // ==========================================

  Future<void> saveFCMToken(String token) async {
    await _prefs.setString(StorageKeys.fcmToken, token);
  }

  String? getFCMToken() {
    return _prefs.getString(StorageKeys.fcmToken);
  }

  // ==========================================
  // ONBOARDING
  // ==========================================

  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(StorageKeys.hasSeenOnboarding, true);
  }

  bool hasSeenOnboarding() {
    return _prefs.getBool(StorageKeys.hasSeenOnboarding) ?? false;
  }

  // ==========================================
  // MEDICATIONS (LOCAL CACHE)
  // ==========================================

  // ✅ حفظ الأدوية بشكل JSON List<String>
  Future<void> saveMedications(List<Map<String, dynamic>> medications) async {
    try {
      final encoded = medications.map((e) => jsonEncode(e)).toList();
      await _prefs.setStringList(StorageKeys.medications, encoded);
    } catch (e) {
      throw StorageWriteException('فشل في حفظ الأدوية: $e');
    }
  }

  // ✅ استرجاع الأدوية
  Future<List<Map<String, dynamic>>?> getMedications() async {
    try {
      final data = _prefs.getStringList(StorageKeys.medications);
      if (data == null) return null;
      return data.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    } catch (e) {
      throw StorageReadException('فشل في قراءة الأدوية: $e');
    }
  }

  // ==========================================
  // CLEAR ALL
  // ==========================================

  Future<void> clearAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw StorageException('فشل في مسح البيانات: $e');
    }
  }

  Future<void> clearAuthData() async {
    for (final key in StorageKeys.logoutKeys) {
      await _prefs.remove(key);
    }
  }
}