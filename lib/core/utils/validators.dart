
/*
//الاول
import 'package:intl/intl.dart';
/// Check if date is valid
static bool isValidDate(String? dateStr) {
if (dateStr == null || dateStr.isEmpty) return false;
return parseDate(dateStr) != null;
}

/// Check if time is valid (HH:mm format)
static bool isValidTime(String? timeStr) {
if (timeStr == null || timeStr.isEmpty) return false;

final regex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
return regex.hasMatch(timeStr);
}

/// Check if age is valid (between min and max)
static bool isValidAge(DateTime dateOfBirth, {int min = 0, int max = 150}) {
final age = getAge(dateOfBirth);
return age >= min && age <= max;
}
}

 */

// lib/core/utils/validators.dart

import '../constants/app_constants.dart';

class Validators {
  // Prevent instantiation
  Validators._();

  // ==========================================
  // COMMON VALIDATORS
  // ==========================================

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? 'الرجاء إدخال ${fieldName}'
          : 'هذا الحقل مطلوب';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }

    final emailRegex = RegExp(AppConstants.emailPattern);
    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }

    return null;
  }

  static String? mobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الجوال';
    }

    // Remove spaces and dashes
    final cleanedValue = value.replaceAll(RegExp(r'[\s-]'), '');

    if (cleanedValue.length != AppConstants.mobileLength) {
      return 'رقم الجوال يجب أن يكون ${AppConstants.mobileLength} أرقام';
    }

    if (!cleanedValue.startsWith(AppConstants.mobilePrefix)) {
      return 'رقم الجوال يجب أن يبدأ بـ ${AppConstants.mobilePrefix}';
    }

    final mobileRegex = RegExp(AppConstants.mobilePattern);
    if (!mobileRegex.hasMatch(cleanedValue)) {
      return 'رقم الجوال غير صالح';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }

    if (value.length < AppConstants.minPasswordLength) {
      return 'كلمة المرور يجب أن تكون ${AppConstants.minPasswordLength} أحرف على الأقل';
    }

    if (value.length > AppConstants.maxPasswordLength) {
      return 'كلمة المرور يجب ألا تتجاوز ${AppConstants.maxPasswordLength} حرف';
    }

    // Check if password contains at least one letter and one number
    if (!value.contains(RegExp(r'[A-Za-z]')) ||
        !value.contains(RegExp(r'[0-9]'))) {
      return 'كلمة المرور يجب أن تحتوي على أحرف وأرقام';
    }

    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'الرجاء تأكيد كلمة المرور';
    }

    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }

    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرجاء إدخال الاسم';
    }

    if (value.trim().length < AppConstants.minNameLength) {
      return 'الاسم يجب أن يكون ${AppConstants.minNameLength} أحرف على الأقل';
    }

    if (value.trim().length > AppConstants.maxNameLength) {
      return 'الاسم يجب ألا يتجاوز ${AppConstants.maxNameLength} حرف';
    }

    return null;
  }

  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return required(value, fieldName);
    }

    if (value.length < minLength) {
      return fieldName != null
          ? '$fieldName يجب أن يكون $minLength أحرف على الأقل'
          : 'يجب أن يكون $minLength أحرف على الأقل';
    }

    return null;
  }

  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value != null && value.length > maxLength) {
      return fieldName != null
          ? '$fieldName يجب ألا يتجاوز $maxLength حرف'
          : 'يجب ألا يتجاوز $maxLength حرف';
    }

    return null;
  }

  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return required(value, fieldName);
    }

    if (int.tryParse(value) == null) {
      return fieldName != null
          ? '$fieldName يجب أن يكون رقماً'
          : 'يجب أن يكون رقماً';
    }

    return null;
  }

  static String? positiveNumber(String? value, [String? fieldName]) {
    final numericError = numeric(value, fieldName);
    if (numericError != null) return numericError;

    final number = int.parse(value!);
    if (number <= 0) {
      return fieldName != null
          ? '$fieldName يجب أن يكون رقماً موجباً'
          : 'يجب أن يكون رقماً موجباً';
    }

    return null;
  }

  // ==========================================
  // COMBINE VALIDATORS
  // ==========================================

  static String? Function(String?) combine(
      List<String? Function(String?)> validators,
      ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
