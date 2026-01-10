//lib/core/network/api_client.dart
/*
// الاول
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_constants.dart';
import 'interceptors.dart';

// 2. تعريف الـ Provider الذي سيحل المشكلة في ملف الـ OrderProvider والـ Repository
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add Interceptors
    _dio.interceptors.addAll([
      AuthInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  Dio get dio => _dio;

  // GET Request
  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST Request
  Future<Response> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT Request
  Future<Response> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE Request
  Future<Response> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('انتهت مهلة الاتصال، يرجى المحاولة مرة أخرى');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return Exception('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى');
        } else if (statusCode == 404) {
          return Exception('الصفحة غير موجودة');
        } else if (statusCode == 500) {
          return Exception('خطأ في الخادم، يرجى المحاولة لاحقاً');
        }
        return Exception('حدث خطأ غير متوقع');

      case DioExceptionType.cancel:
        return Exception('تم إلغاء الطلب');

      case DioExceptionType.connectionError:
        return Exception('لا يوجد اتصال بالإنترنت');

      default:
        return Exception('حدث خطأ غير متوقع');
    }
  }
}

 */

// lib/core/network/api_client.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import 'network_info.dart';

// 2. تعريف الـ Provider الذي سيحل المشكلة في ملف الـ OrderProvider والـ Repository
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

class ApiClient {
  final http.Client _client;
  final NetworkInfo _networkInfo;
  String? _authToken;

  ApiClient({
    http.Client? client,
    NetworkInfo? networkInfo,
  })  : _client = client ?? http.Client(),
        _networkInfo = networkInfo ?? NetworkInfoImpl();

  // Set auth token
  void setAuthToken(String? token) {
    _authToken = token;
  }

  // Get auth token
  String? get authToken => _authToken;

  // Clear auth token
  void clearAuthToken() {
    _authToken = null;
  }

  // ==========================================
  // GET REQUEST
  // ==========================================

  Future<Map<String, dynamic>> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    return _retryRequest(() async {
      await _checkConnectivity();

      final uri = _buildUri(endpoint, queryParameters);
      final requestHeaders = _buildHeaders(headers);

      try {
        final response = await _client
            .get(uri, headers: requestHeaders)
            .timeout(ApiConstants.receiveTimeout);

        return _handleResponse(response);
      } on SocketException {
        throw const NetworkException();
      } on http.ClientException {
        throw const NetworkException();
      } on TimeoutException {
        throw const TimeoutException();
      }
    });
  }

  // ==========================================
  // POST REQUEST
  // ==========================================

  Future<Map<String, dynamic>> post(
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
      }) async {
    return _retryRequest(() async {
      await _checkConnectivity();

      final uri = _buildUri(endpoint);
      final requestHeaders = _buildHeaders(headers);

      try {
        final response = await _client
            .post(
          uri,
          headers: requestHeaders,
          body: body != null ? json.encode(body) : null,
        )
            .timeout(ApiConstants.sendTimeout);

        return _handleResponse(response);
      } on SocketException {
        throw const NetworkException();
      } on http.ClientException {
        throw const NetworkException();
      } on TimeoutException {
        throw const TimeoutException();
      }
    });
  }

  // ==========================================
  // PUT REQUEST
  // ==========================================

  Future<Map<String, dynamic>> put(
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
      }) async {
    return _retryRequest(() async {
      await _checkConnectivity();

      final uri = _buildUri(endpoint);
      final requestHeaders = _buildHeaders(headers);

      try {
        final response = await _client
            .put(
          uri,
          headers: requestHeaders,
          body: body != null ? json.encode(body) : null,
        )
            .timeout(ApiConstants.sendTimeout);

        return _handleResponse(response);
      } on SocketException {
        throw const NetworkException();
      } on http.ClientException {
        throw const NetworkException();
      } on TimeoutException {
        throw const TimeoutException();
      }
    });
  }

  // ==========================================
  // DELETE REQUEST
  // ==========================================

  Future<Map<String, dynamic>> delete(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    return _retryRequest(() async {
      await _checkConnectivity();

      final uri = _buildUri(endpoint);
      final requestHeaders = _buildHeaders(headers);

      try {
        final response = await _client
            .delete(uri, headers: requestHeaders)
            .timeout(ApiConstants.receiveTimeout);

        return _handleResponse(response);
      } on SocketException {
        throw const NetworkException();
      } on http.ClientException {
        throw const NetworkException();
      } on TimeoutException {
        throw const TimeoutException();
      }
    });
  }

  // ==========================================
  // MULTIPART REQUEST (for file uploads)
  // ==========================================

  Future<Map<String, dynamic>> multipart(
      String endpoint, {
        required Map<String, String> fields,
        List<http.MultipartFile>? files,
        Map<String, String>? headers,
      }) async {
    await _checkConnectivity();

    final uri = _buildUri(endpoint);
    final requestHeaders = _buildHeaders(headers);

    try {
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(requestHeaders);
      request.fields.addAll(fields);

      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException();
    } on http.ClientException {
      throw const NetworkException();
    } on TimeoutException {
      throw const TimeoutException();
    }
  }

  // ==========================================
  // HELPER METHODS
  // ==========================================

  /// Build URI with query parameters
  Uri _buildUri(String endpoint, [Map<String, dynamic>? queryParameters]) {
    final path = '${ApiConstants.apiPath}$endpoint';

    if (queryParameters != null && queryParameters.isNotEmpty) {
      return Uri.parse(ApiConstants.baseUrl).replace(
        path: path,
        queryParameters: queryParameters.map(
              (key, value) => MapEntry(key, value.toString()),
        ),
      );
    }

    return Uri.parse('${ApiConstants.baseUrl}$path');
  }

  /// Build request headers
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = ApiConstants.getHeaders(token: _authToken);

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }

  /// Retry request with exponential backoff
  Future<Map<String, dynamic>> _retryRequest(
      Future<Map<String, dynamic>> Function() request,
      ) async {
    int retryCount = 0;

    while (retryCount < ApiConstants.maxRetries) {
      try {
        return await request();
      } on NetworkException catch (e) {
        retryCount++;
        if (retryCount >= ApiConstants.maxRetries) {
          rethrow;
        }
        // Exponential backoff: wait before retrying
        await Future.delayed(ApiConstants.retryDelay * retryCount);
      } on TimeoutException catch (e) {
        retryCount++;
        if (retryCount >= ApiConstants.maxRetries) {
          rethrow;
        }
        await Future.delayed(ApiConstants.retryDelay * retryCount);
      } catch (e) {
        // For other exceptions, don't retry
        rethrow;
      }
    }

    // This should never be reached, but just in case
    return await request();
  }

  /// Check internet connectivity
  Future<void> _checkConnectivity() async {
    if (!await _networkInfo.isConnected) {
      throw const NoInternetException();
    }
  }

  /// Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    // Try to parse response body
    Map<String, dynamic> data;
    try {
      data = json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      data = {'message': response.body};
    }

    // Handle success (200-299)
    if (statusCode >= 200 && statusCode < 300) {
      return data;
    }

    // Handle specific error codes
    switch (statusCode) {
      case 400:
        throw BadRequestException(
          data['message'] as String? ?? 'طلب غير صالح',
          data: data,
        );
      case 401:
        throw const UnauthorizedException();
      case 403:
        throw const ForbiddenException();
      case 404:
        throw const NotFoundException();
      case 422:
        throw ValidationException.fromResponse(data);
      case 500:
        throw const InternalServerException();
      case 503:
        throw const ServiceUnavailableException();
      default:
        throw ServerException(
          data['message'] as String? ?? 'حدث خطأ في الخادم',
          code: statusCode.toString(),
          data: data,
        );
    }
  }

  /// Close the client
  void dispose() {
    _client.close();
  }
}





