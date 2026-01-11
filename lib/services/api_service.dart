
// api_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../core/constants/api_constants.dart';

class ApiService {
  late final Dio _dio;
  String? _token;

  ApiService() {

    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
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
         //ignore: avoid_print
        debugPrint('API Error: ${error.message}');
        //print('API Error: ${error.message}');
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
        endpoint,
        queryParameters: params,
      );

      /*final response = await _dio.get(
        '${app_constants.AppConstants.apiPath}/$endpoint',
        queryParameters: params,
      );

       */
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.apiPath}/$endpoint',
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
        '${ApiConstants.apiPath}/$endpoint',
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
        '${ApiConstants.apiPath}/$endpoint',
        data: data,
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Handle different response types
      final data = response.data;

      if (data == null) {
        return {'message': 'Success', 'data': null};
      }

      if (data is Map<String, dynamic>) {
        return data;
      }

      if (data is String) {
        // Try to parse as JSON if it's a string
        try {
          final parsed = data.isNotEmpty ? Map<String, dynamic>.from(
            (data.startsWith('{') || data.startsWith('['))
              ? _parseJson(data)
              : {'message': data}
          ) : {'message': 'Success'};
          return parsed;
        } catch (e) {
          return {'message': data};
        }
      }

      if (data is List) {
        return {'message': data, 'data': data};
      }

      // Fallback for other types
      return {'message': data.toString()};
    } else {
      throw Exception('API Error: ${response.statusMessage}');
    }
  }

  // Helper method to parse JSON string
  dynamic _parseJson(String jsonString) {
    try {
      return json.decode(jsonString);
    } catch (e) {
      return {'raw': jsonString};
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
  // مفيد للـ UI لاحقًا
  // دالة إضافية لتحسين التعامل مع أخطاء Dio
  String handleDioError(DioException error) {
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



