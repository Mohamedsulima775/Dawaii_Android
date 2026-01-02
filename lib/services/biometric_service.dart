import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider لتوفير الخدمة في أنحاء التطبيق
final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// التحقق مما إذا كان الجهاز يدعم القياسات الحيوية
  Future<bool> canAuthenticate() async {
    try {
      final bool canCheckBiometrics = await _auth.canCheckBiometrics;
      final bool isSupported = await _auth.isDeviceSupported();
      return canCheckBiometrics || isSupported;
    } on PlatformException catch (e) {
      print('Error checking biometrics: $e');
      return false;
    }
  }

  /// تنفيذ عملية التحقق (بصمة / وجه)
  Future<bool> authenticate() async {
    try {
      final availableBiometrics = await _auth.getAvailableBiometrics();

      if (availableBiometrics.isEmpty) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'يرجى التحقق من هويتك لفتح تطبيق دوائي',
      );
    } on PlatformException catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }
}