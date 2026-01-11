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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp();
  debugPrint(' Firebase initialized');

  // FCM Token
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint(' FCM TOKEN: $token');

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
    // Create ApiService and ProductRepository
    final apiService = ApiService();
    final productRepository = ProductRepositoryImpl(apiService);

    return provider_pkg.MultiProvider(
      providers: [
        provider_pkg.ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(repository: productRepository),
        ),
      ],
      child: MaterialApp.router(
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
      ),
    );
  }
}




