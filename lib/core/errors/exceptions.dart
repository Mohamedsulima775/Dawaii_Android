
/*
// الاول

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});

  @override
  String toString() => message;
}

class NetworkException extends ServerException {
  NetworkException({required String message}) : super(message: message);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException({required String message}) : super(message: message);
}

class NotFoundException extends ServerException {
  NotFoundException({required String message}) : super(message: message);
}

 */

// lib/core/errors/exceptions.dart

/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException(this.message, {this.code, this.data});

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

// ==========================================
// SERVER EXCEPTIONS
// ==========================================

/// Exception thrown when server returns an error
class ServerException extends AppException {
  const ServerException(
      super.message, {
        super.code,
        super.data,
      });

  factory ServerException.fromResponse(Map<String, dynamic> response) {
    return ServerException(
      response['message'] as String? ?? 'حدث خطأ في الخادم',
      code: response['code'] as String?,
      data: response['data'],
    );
  }
}

/// Exception for 400 Bad Request
class BadRequestException extends ServerException {
  const BadRequestException(
      super.message, {
        super.code,
        super.data,
      });
}

/// Exception for 401 Unauthorized
class UnauthorizedException extends ServerException {
  const UnauthorizedException([
    String message = 'غير مصرح، الرجاء تسجيل الدخول مجدداً',
  ]) : super(message, code: '401');
}

/// Exception for 403 Forbidden
class ForbiddenException extends ServerException {
  const ForbiddenException([
    String message = 'غير مسموح بالوصول',
  ]) : super(message, code: '403');
}

/// Exception for 404 Not Found
class NotFoundException extends ServerException {
  const NotFoundException([
    String message = 'المورد المطلوب غير موجود',
  ]) : super(message, code: '404');
}

/// Exception for 422 Validation Error
class ValidationException extends ServerException {
  final Map<String, List<String>>? errors;

  const ValidationException(
      super.message, {
        this.errors,
        super.code,
        super.data,
      });

  factory ValidationException.fromResponse(Map<String, dynamic> response) {
    final errors = response['errors'] as Map<String, dynamic>?;
    return ValidationException(
      response['message'] as String? ?? 'خطأ في التحقق من البيانات',
      errors: errors?.map(
            (key, value) => MapEntry(
          key,
          (value as List).map((e) => e.toString()).toList(),
        ),
      ),
      code: response['code'] as String?,
      data: response['data'],
    );
  }

  String? getFieldError(String field) {
    return errors?[field]?.first;
  }

  bool hasFieldError(String field) {
    return errors?.containsKey(field) ?? false;
  }
}

/// Exception for 500 Internal Server Error
class InternalServerException extends ServerException {
  const InternalServerException([
    String message = 'خطأ داخلي في الخادم',
  ]) : super(message, code: '500');
}

/// Exception for 503 Service Unavailable
class ServiceUnavailableException extends ServerException {
  const ServiceUnavailableException([
    String message = 'الخدمة غير متاحة حالياً',
  ]) : super(message, code: '503');
}

// ==========================================
// NETWORK EXCEPTIONS
// ==========================================

/// Exception for network connectivity issues
class NetworkException extends AppException {
  const NetworkException([
    String message = 'خطأ في الاتصال بالإنترنت',
  ]) : super(message);
}

/// Exception for connection timeout
class TimeoutException extends NetworkException {
  const TimeoutException([
    String message = 'انتهت مهلة الاتصال',
  ]) : super(message);
}

/// Exception for no internet connection
class NoInternetException extends NetworkException {
  const NoInternetException([
    String message = 'لا يوجد اتصال بالإنترنت',
  ]) : super(message);
}

// ==========================================
// CACHE EXCEPTIONS
// ==========================================

/// Exception for cache-related errors
class CacheException extends AppException {
  const CacheException([
    String message = 'خطأ في ذاكرة التخزين المؤقت',
  ]) : super(message);
}

/// Exception when cached data is not found
class CacheNotFoundException extends CacheException {
  const CacheNotFoundException([
    String message = 'البيانات المطلوبة غير موجودة في ذاكرة التخزين',
  ]) : super(message);
}

/// Exception when cached data is expired
class CacheExpiredException extends CacheException {
  const CacheExpiredException([
    String message = 'انتهت صلاحية البيانات المخزنة',
  ]) : super(message);
}

// ==========================================
// STORAGE EXCEPTIONS
// ==========================================

/// Exception for local storage errors
class StorageException extends AppException {
  const StorageException([
    String message = 'خطأ في التخزين المحلي',
  ]) : super(message);
}

/// Exception when storage read fails
class StorageReadException extends StorageException {
  const StorageReadException([
    String message = 'فشل في قراءة البيانات من التخزين',
  ]) : super(message);
}

/// Exception when storage write fails
class StorageWriteException extends StorageException {
  const StorageWriteException([
    String message = 'فشل في كتابة البيانات إلى التخزين',
  ]) : super(message);
}

/// Exception when storage delete fails
class StorageDeleteException extends StorageException {
  const StorageDeleteException([
    String message = 'فشل في حذف البيانات من التخزين',
  ]) : super(message);
}

// ==========================================
// AUTHENTICATION EXCEPTIONS
// ==========================================

/// Exception for authentication errors
class AuthException extends AppException {
  const AuthException([
    String message = 'خطأ في المصادقة',
  ]) : super(message);
}

/// Exception for invalid credentials
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([
    String message = 'بيانات الدخول غير صحيحة',
  ]) : super(message);
}

/// Exception for account not found
class AccountNotFoundException extends AuthException {
  const AccountNotFoundException([
    String message = 'الحساب غير موجود',
  ]) : super(message);
}

/// Exception for account already exists
class AccountAlreadyExistsException extends AuthException {
  const AccountAlreadyExistsException([
    String message = 'الحساب موجود مسبقاً',
  ]) : super(message);
}

/// Exception for token expiration
class TokenExpiredException extends AuthException {
  const TokenExpiredException([
    String message = 'انتهت صلاحية الجلسة، الرجاء تسجيل الدخول مجدداً',
  ]) : super(message);
}

/// Exception for weak password
class WeakPasswordException extends AuthException {
  const WeakPasswordException([
    String message = 'كلمة المرور ضعيفة',
  ]) : super(message);
}

// ==========================================
// PERMISSION EXCEPTIONS
// ==========================================

/// Exception for permission-related errors
class PermissionException extends AppException {
  const PermissionException([
    String message = 'الصلاحية غير ممنوحة',
  ]) : super(message);
}

/// Exception for camera permission
class CameraPermissionException extends PermissionException {
  const CameraPermissionException([
    String message = 'صلاحية الكاميرا غير ممنوحة',
  ]) : super(message);
}

/// Exception for storage permission
class StoragePermissionException extends PermissionException {
  const StoragePermissionException([
    String message = 'صلاحية التخزين غير ممنوحة',
  ]) : super(message);
}

/// Exception for location permission
class LocationPermissionException extends PermissionException {
  const LocationPermissionException([
    String message = 'صلاحية الموقع غير ممنوحة',
  ]) : super(message);
}

/// Exception for notification permission
class NotificationPermissionException extends PermissionException {
  const NotificationPermissionException([
    String message = 'صلاحية الإشعارات غير ممنوحة',
  ]) : super(message);
}

// ==========================================
// PARSING EXCEPTIONS
// ==========================================

/// Exception for JSON parsing errors
class ParsingException extends AppException {
  const ParsingException([
    String message = 'خطأ في معالجة البيانات',
  ]) : super(message);
}

/// Exception for invalid JSON format
class InvalidJsonException extends ParsingException {
  const InvalidJsonException([
    String message = 'تنسيق JSON غير صالح',
  ]) : super(message);
}

/// Exception for missing required field
class MissingFieldException extends ParsingException {
  final String fieldName;

  const MissingFieldException(this.fieldName)
      : super('الحقل المطلوب "$fieldName" مفقود');
}

// ==========================================
// BUSINESS LOGIC EXCEPTIONS
// ==========================================

/// Exception for business logic errors
class BusinessLogicException extends AppException {
  const BusinessLogicException(super.message, {super.code, super.data});
}

/// Exception for insufficient stock
class InsufficientStockException extends BusinessLogicException {
  const InsufficientStockException([
    String message = 'المخزون غير كافٍ',
  ]) : super(message);
}

/// Exception for medication already exists
class MedicationAlreadyExistsException extends BusinessLogicException {
  const MedicationAlreadyExistsException([
    String message = 'الدواء موجود مسبقاً',
  ]) : super(message);
}

/// Exception for order cannot be cancelled
class OrderCannotBeCancelledException extends BusinessLogicException {
  const OrderCannotBeCancelledException([
    String message = 'لا يمكن إلغاء الطلب في هذه المرحلة',
  ]) : super(message);
}

// ==========================================
// FILE EXCEPTIONS
// ==========================================

/// Exception for file-related errors
class FileException extends AppException {
  const FileException(super.message, {super.code, super.data});
}

/// Exception for file not found
class FileNotFoundException extends FileException {
  const FileNotFoundException([
    String message = 'الملف غير موجود',
  ]) : super(message);
}

/// Exception for file too large
class FileTooLargeException extends FileException {
  const FileTooLargeException([
    String message = 'حجم الملف كبير جداً',
  ]) : super(message);
}

/// Exception for invalid file format
class InvalidFileFormatException extends FileException {
  const InvalidFileFormatException([
    String message = 'تنسيق الملف غير صالح',
  ]) : super(message);
}



// ==========================================
// UNKNOWN EXCEPTION
// ==========================================

/// Exception for unknown/unhandled errors
class UnknownException extends AppException {
  const UnknownException([
    String message = 'حدث خطأ غير متوقع',
  ]) : super(message);
}
