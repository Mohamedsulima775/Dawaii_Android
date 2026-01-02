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
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final InternetConnectionChecker _connectionChecker;

  NetworkInfoImpl({
    Connectivity? connectivity,
    InternetConnectionChecker? connectionChecker,
  })  : _connectivity = connectivity ?? Connectivity(),
        _connectionChecker =
            connectionChecker ?? InternetConnectionChecker.instance;

  @override
  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();

    // If no connectivity, return false immediately
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Check if there's actual internet connection
    return await _connectionChecker.hasConnection;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.asyncMap((result) async {
      if (result == ConnectivityResult.none) {
        return false;
      }
      return await _connectionChecker.hasConnection;
    });
  }
}
