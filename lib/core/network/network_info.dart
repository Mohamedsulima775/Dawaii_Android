// lib/core/error/exceptions.dart

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

// lib/core/network/network_info.dart

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl({
    Connectivity? connectivity,
  }) : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> get isConnected async {
    // On web, we can't reliably check internet connectivity without CORS issues
    // The connectivity_plus package uses Navigator.onLine on web which is sufficient
    // If the actual API call fails, it will throw an appropriate error
    if (kIsWeb) {
      final connectivityResult = await _connectivity.checkConnectivity();
      // On web, connectivity_plus uses Navigator.onLine
      return connectivityResult != ConnectivityResult.none;
    }

    // On mobile/desktop, use connectivity_plus
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.asyncMap((result) async {
      return result != ConnectivityResult.none;
    });
  }
}
