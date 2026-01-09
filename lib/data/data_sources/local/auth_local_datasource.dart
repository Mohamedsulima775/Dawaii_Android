/*
// lib/data/datasources/local/auth_local_datasource.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../core/error/exceptions.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/patient_model.dart';

abstract class AuthLocalDataSource {
  Future<patient?> getCachedUser();
  Future<void> cacheUser(User user);
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String CACHED_USER = 'CACHED_USER';
  static const String AUTH_TOKEN = 'AUTH_TOKEN';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<User?> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_USER);
      if (jsonString != null) {
        return User.fromJson(jsonDecode(jsonString));
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached user');
    }
  }

  @override
  Future<void> cacheUser(User user) async {
    try {
      await sharedPreferences.setString(
        CACHED_USER,
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      throw CacheException('Failed to cache user');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return sharedPreferences.getString(AUTH_TOKEN);
    } catch (e) {
      throw CacheException('Failed to get token');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await sharedPreferences.setString(AUTH_TOKEN, token);
    } catch (e) {
      throw CacheException('Failed to save token');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(CACHED_USER);
      await sharedPreferences.remove(AUTH_TOKEN);
    } catch (e) {
      throw CacheException('Failed to clear cache');
    }
  }
}

 */