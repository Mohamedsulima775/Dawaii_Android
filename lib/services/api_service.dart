
/*
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // إضافة مكتبة ريفربود
import '../core/constants/app_constants.dart' as AppConstants;

// تعريف الـ Provider لكي يتم التعرف عليه في ملف SettingsProvider وبقية التطبيق
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  late final Dio _dio;
  String? _token;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.connectTimeout), // تأكد من توافق النوع مع إصدار Dio
      receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // إضافة الـ Interceptors للتعامل مع التوكن والأخطاء
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) { // استخدام DioException بدلاً من Generic error
        print('API Error [${error.response?.statusCode}]: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        '${AppConstants.apiPath}/$endpoint',
        queryParameters: params,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        '${AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(
        '${AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(
        '${AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('API Error: ${response.statusMessage}');
    }
  }

  // دالة إضافية لتحسين التعامل مع أخطاء Dio
  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout with API server";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout in connection with API server";
      case DioExceptionType.badResponse:
        return "Error: ${error.response?.data['message'] ?? 'Server error'}";
      default:
        return "Something went wrong";
    }
  }
}

 */



import 'package:dio/dio.dart';
import '../core/constants/app_constants.dart' as app_constants;
import '../core/constants/app_constants.dart' as app_constants;
class ApiService {
  late final Dio _dio;
  String? _token;

  ApiService() {

    _dio = Dio(BaseOptions(
      baseUrl: app_constants.AppConstants.baseUrl,
      connectTimeout: app_constants.AppConstants.connectTimeout,
      receiveTimeout: app_constants.AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));



    // Add interceptors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        print('API Error: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(
        '${app_constants.AppConstants.apiPath}/$endpoint',
        queryParameters: params,
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        '${app_constants.AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(
        '${app_constants.AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(
        '${app_constants.AppConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('API Error: ${response.statusMessage}');
    }
  }

  Future<void> updatePatientSettings({
    required String patientId,
    required Map<String, dynamic> settings,
  }) async {
    await put(
      'patients/$patientId/settings',
      data: settings,
    );
  }




}



