//lib/core/network/interceptors.dart
/*
//الاول

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // إضافة Token لكل طلب
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired - يمكن هنا عمل refresh أو تسجيل خروج
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      // TODO: Navigate to login screen
    }

    super.onError(err, handler);
  }
}

 */

// lib/core/network/interceptors.dart

import 'package:http/http.dart' as http;
import '../utils/logger.dart';

class ApiInterceptor extends http.BaseClient {
  final http.Client _client;
  final Logger _logger;

  ApiInterceptor({
    http.Client? client,
    Logger? logger,
  })  : _client = client ?? http.Client(),
        _logger = logger ?? Logger();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Log request
    _logRequest(request);

    // Add timestamp to headers
    request.headers['X-Request-Time'] = DateTime.now().toIso8601String();

    try {
      // Send request
      final response = await _client.send(request);

      // Log response
      await _logResponse(response, request);

      return response;
    } catch (e) {
      // Log error
      _logger.error('Request failed: ${request.url}', error: e);
      rethrow;
    }
  }

  /// Log request details
  void _logRequest(http.BaseRequest request) {
    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.info('📤 REQUEST');
    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.info('Method: ${request.method}');
    _logger.info('URL: ${request.url}');
    _logger.info('Headers: ${_sanitizeHeaders(request.headers)}');

    if (request is http.Request && request.body.isNotEmpty) {
      _logger.info('Body: ${_sanitizeBody(request.body)}');
    }

    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  }

  /// Log response details
  Future<void> _logResponse(
      http.StreamedResponse response,
      http.BaseRequest request,
      ) async {
    final responseBody = await response.stream.bytesToString();

    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.info('📥 RESPONSE');
    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    _logger.info('URL: ${request.url}');
    _logger.info('Status Code: ${response.statusCode}');
    _logger.info('Headers: ${response.headers}');
    _logger.info('Body: ${_sanitizeBody(responseBody)}');
    _logger.info('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  }

  /// Sanitize headers (remove sensitive data)
  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    final sanitized = Map<String, String>.from(headers);

    // Mask sensitive headers
    if (sanitized.containsKey('Authorization')) {
      final auth = sanitized['Authorization']!;
      if (auth.length > 20) {
        sanitized['Authorization'] = '${auth.substring(0, 20)}...';
      }
    }

    return sanitized;
  }

  /// Sanitize body (limit size for logging)
  String _sanitizeBody(String body) {
    const maxLength = 1000;

    if (body.length <= maxLength) {
      return body;
    }

    return '${body.substring(0, maxLength)}... (truncated)';
  }
}
