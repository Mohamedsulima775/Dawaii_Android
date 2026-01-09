
// domain/failures/failure.dart

import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic data;

  const Failure(
      this.message, {
        this.code,
        this.data,
      });

  @override
  List<Object?> get props => [message, code, data];

  @override
  String toString() => message;
}

// ==========================================
// SERVER FAILURES
// ==========================================

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure(
      super.message, {
        super.code,
        super.data,
      });

  factory ServerFailure.fromException(dynamic exception) {
    if (exception is Map<String, dynamic>) {
      return ServerFailure(
        exception['message'] as String? ?? 'حدث خطأ في الخادم',
        code: exception['code'] as String?,
        data: exception['data'],
      );
    }
    return ServerFailure(exception.toString());
  }
}

class UnexpectedFailure extends Failure {
  const   UnexpectedFailure([super.message = 'حدث خطأ غير متوقع']);
}

/// Failure for bad request (400)
class BadRequestFailure extends ServerFailure {
  const BadRequestFailure(
      super.message, {
        super.code,
        super.data,
      });
}

/// Failure for unauthorized (401)
class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure([
    String message = 'غير مصرح، الرجاء تسجيل الدخول مجدداً',
  ]) : super(message, code: '401');
}

/// Failure for forbidden (403)
class ForbiddenFailure extends ServerFailure {
  const ForbiddenFailure([
    String message = 'غير مسموح بالوصول',
  ]) : super(message, code: '403');
}

/// Failure for not found (404)
class NotFoundFailure extends ServerFailure {
  const NotFoundFailure([
    String message = 'المورد المطلوب غير موجود',
  ]) : super(message, code: '404');
}

/// Failure for validation errors (422)
class ValidationFailure extends ServerFailure {
  final Map<String, List<String>>? errors;

  const ValidationFailure(
      super.message, {
        this.errors,
        super.code,
        super.data,
      });

  String? getFieldError(String field) {
    return errors?[field]?.first;
  }

  bool hasFieldError(String field) {
    return errors?.containsKey(field) ?? false;
  }

  @override
  List<Object?> get props => [message, code, data, errors];

}

/// Failure for internal server error (500)
class InternalServerFailure extends ServerFailure {
  const InternalServerFailure([
    String message = 'خطأ داخلي في الخادم',
  ]) : super(message, code: '500');
}

/// Failure for service unavailable (503)
class ServiceUnavailableFailure extends ServerFailure {
  const ServiceUnavailableFailure([
    String message = 'الخدمة غير متاحة حالياً',
  ]) : super(message, code: '503');
}

// ==========================================
// NETWORK FAILURES
// ==========================================

/// Failure for network connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'خطأ في الاتصال بالإنترنت',
  ]) : super(message);
}

/// Failure for connection timeout
class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure([
    String message = 'انتهت مهلة الاتصال',
  ]) : super(message);
}

/// Failure for no internet connection
class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure([
    String message = 'لا يوجد اتصال بالإنترنت',
  ]) : super(message);
}

// ==========================================
// CACHE FAILURES
// ==========================================

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure([
    String message = 'خطأ في ذاكرة التخزين المؤقت',
  ]) : super(message);
}

/// Failure when cached data is not found
class CacheNotFoundFailure extends CacheFailure {
  const CacheNotFoundFailure([
    String message = 'البيانات المطلوبة غير موجودة في ذاكرة التخزين',
  ]) : super(message);
}

/// Failure when cached data is expired
class CacheExpiredFailure extends CacheFailure {
  const CacheExpiredFailure([
    String message = 'انتهت صلاحية البيانات المخزنة',
  ]) : super(message);
}

// ==========================================
// STORAGE FAILURES
// ==========================================

/// Failure for local storage errors
class StorageFailure extends Failure {
  const StorageFailure([
    String message = 'خطأ في التخزين المحلي',
  ]) : super(message);
}

/// Failure when storage read fails
class StorageReadFailure extends StorageFailure {
  const StorageReadFailure([
    String message = 'فشل في قراءة البيانات من التخزين',
  ]) : super(message);
}

/// Failure when storage write fails
class StorageWriteFailure extends StorageFailure {
  const StorageWriteFailure([
    String message = 'فشل في كتابة البيانات إلى التخزين',
  ]) : super(message);
}

// ==========================================
// AUTHENTICATION FAILURES
// ==========================================

/// Failure for authentication errors
class AuthFailure extends Failure {
  const AuthFailure([
    String message = 'خطأ في المصادقة',
  ]) : super(message);
}

/// Failure for invalid credentials
class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure([
    String message = 'بيانات الدخول غير صحيحة',
  ]) : super(message);
}

/// Failure for account not found
class AccountNotFoundFailure extends AuthFailure {
  const AccountNotFoundFailure([
    String message = 'الحساب غير موجود',
  ]) : super(message);
}

/// Failure for account already exists
class AccountAlreadyExistsFailure extends AuthFailure {
  const AccountAlreadyExistsFailure([
    String message = 'الحساب موجود مسبقاً',
  ]) : super(message);
}

/// Failure for token expiration
class TokenExpiredFailure extends AuthFailure {
  const TokenExpiredFailure([
    String message = 'انتهت صلاحية الجلسة، الرجاء تسجيل الدخول مجدداً',
  ]) : super(message);
}

// ==========================================
// PERMISSION FAILURES
// ==========================================

/// Failure for permission-related errors
class PermissionFailure extends Failure {
  const PermissionFailure([
    String message = 'الصلاحية غير ممنوحة',
  ]) : super(message);
}

/// Failure for camera permission
class CameraPermissionFailure extends PermissionFailure {
  const CameraPermissionFailure([
    String message = 'صلاحية الكاميرا غير ممنوحة',
  ]) : super(message);
}

/// Failure for storage permission
class StoragePermissionFailure extends PermissionFailure {
  const StoragePermissionFailure([
    String message = 'صلاحية التخزين غير ممنوحة',
  ]) : super(message);
}

/// Failure for notification permission
class NotificationPermissionFailure extends PermissionFailure {
  const NotificationPermissionFailure([
    String message = 'صلاحية الإشعارات غير ممنوحة',
  ]) : super(message);
}

// ==========================================
// PARSING FAILURES
// ==========================================

/// Failure for data parsing errors
class ParsingFailure extends Failure {
  const ParsingFailure([
    String message = 'خطأ في معالجة البيانات',
  ]) : super(message);
}

/// Failure for invalid JSON
class InvalidJsonFailure extends ParsingFailure {
  const InvalidJsonFailure([
    String message = 'تنسيق JSON غير صالح',
  ]) : super(message);
}

// ==========================================
// BUSINESS LOGIC FAILURES
// ==========================================

/// Failure for business logic errors
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure(super.message, {super.code, super.data});
}

/// Failure for insufficient stock
class InsufficientStockFailure extends BusinessLogicFailure {
  const InsufficientStockFailure([
    String message = 'المخزون غير كافٍ',
  ]) : super(message);
}

/// Failure for medication already exists
class MedicationAlreadyExistsFailure extends BusinessLogicFailure {
  const MedicationAlreadyExistsFailure([
    String message = 'الدواء موجود مسبقاً',
  ]) : super(message);
}

/// Failure for order cannot be cancelled
class OrderCannotBeCancelledFailure extends BusinessLogicFailure {
  const OrderCannotBeCancelledFailure([
    String message = 'لا يمكن إلغاء الطلب في هذه المرحلة',
  ]) : super(message);
}

// ==========================================
// FILE FAILURES
// ==========================================

/// Failure for file-related errors
class FileFailure extends Failure {
  const FileFailure(super.message, {super.code, super.data});
}

/// Failure for file not found
class FileNotFoundFailure extends FileFailure {
  const FileNotFoundFailure([
    String message = 'الملف غير موجود',
  ]) : super(message);
}

/// Failure for file too large
class FileTooLargeFailure extends FileFailure {
  const FileTooLargeFailure([
    String message = 'حجم الملف كبير جداً',
  ]) : super(message);
}

/// Failure for invalid file format
class InvalidFileFormatFailure extends FileFailure {
  const InvalidFileFormatFailure([
    String message = 'تنسيق الملف غير صالح',
  ]) : super(message);
}

// ==========================================
// UNKNOWN FAILURE
// ==========================================

/// Failure for unknown/unhandled errors
class UnknownFailure extends Failure {
  const UnknownFailure([
    String message = 'حدث خطأ غير متوقع',
  ]) : super(message);
}



// ==========================================
// HELPER FUNCTIONS
// ==========================================

/// Convert exception to failure
Failure exceptionToFailure(dynamic exception) {
  if (exception is String) {
    return UnknownFailure(exception);
  }

  // Map exception types to failures
  final exceptionType = exception.runtimeType.toString();

  if (exceptionType.contains('Network') || exceptionType.contains('Socket')) {
    return const NetworkFailure();
  }

  if (exceptionType.contains('Timeout')) {
    return const TimeoutFailure();
  }

  if (exceptionType.contains('Format') || exceptionType.contains('Parse')) {
    return const ParsingFailure();
  }

  if (exceptionType.contains('Auth') || exceptionType.contains('Unauthorized')) {
    return const UnauthorizedFailure();
  }

  if (exceptionType.contains('Cache')) {
    return const CacheFailure();
  }

  if (exceptionType.contains('Storage')) {
    return const StorageFailure();
  }

  // Default to unknown failure
  return UnknownFailure(exception.toString());
}