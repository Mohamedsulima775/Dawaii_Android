/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Router
import 'package:dawaii/core/routes/routes.dart'; // عدّل المسار حسب مكان router.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp();
  debugPrint('✅ Firebase initialized');

  // FCM Token
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint('📲 FCM TOKEN: $token');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dawaii',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// 1.
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart' as provider_pkg;

// Router
import 'package:dawaii/core/routes/routes.dart';

// Providers & Repositories
import 'package:dawaii/presentation/providers/product_provider.dart';
import 'package:dawaii/data/repositories/product_repository_impl.dart';
import 'package:dawaii/services/api_service.dart';

// Global instances - created once at app start
late final ApiService globalApiService;
late final ProductRepositoryImpl globalProductRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Allow bad certificates for development (remove in production!)
  HttpOverrides.global = MyHttpOverrides();

  // Initialize global services BEFORE runApp
  globalApiService = ApiService();
  globalProductRepository = ProductRepositoryImpl(globalApiService);

  // Firebase init
  await Firebase.initializeApp();
  debugPrint(' Firebase initialized');

  // FCM Token
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint(' FCM TOKEN: $token');

  runApp(
    // IMPORTANT: MultiProvider must wrap everything including ProviderScope
    // This ensures ProductProvider is available to ALL routes
    provider_pkg.MultiProvider(
      providers: [
        provider_pkg.ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(repository: globalProductRepository),
        ),
      ],
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

// HTTP Overrides for SSL issues in development
// WARNING: Remove this in production!
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dawaii',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,

      // 2.
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'), //
        Locale('en', 'US'), //
      ],
      locale: const Locale('ar', 'SA'), //
    );
  }
}
