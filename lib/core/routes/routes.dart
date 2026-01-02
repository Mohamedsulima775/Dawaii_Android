
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- AUTH SCREENS ---
import '../../presentation/screens/Prescriptions/create_schedule_screen.dart';
import '../../presentation/screens/Prescriptions/prescription_detail_screen.dart';
import '../../presentation/screens/auth/forget_password.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/splash_screen.dart';
import '../../presentation/screens/auth/onboarding_screen.dart';

// --- HOME & MAIN ---
import '../../presentation/screens/consultations/consultation_detail_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/shop/chronic_diseases_page.dart';
import '../../presentation/screens/shop/medical_devices_screen.dart';
import '../../presentation/screens/shop/supplements_screen.dart';
import '../../presentation/screens/shop/wellness_screen.dart';
import '../../presentation/screens/widgets/main_shell.dart';

// --- MEDICATION SCREENS ---
import '../../presentation/screens/medications/Edit_medication_screen.dart';
import '../../presentation/screens/medications/adherence_stats_screen.dart';
import '../../presentation/screens/medications/log_medication_screen.dart';
import '../../presentation/screens/medications/medication_detail_screen.dart';
import '../../presentation/screens/medications/medication_history_screen.dart';
import '../../presentation/screens/medications/medications_screen.dart';
import '../../presentation/screens/medications/add_medications_screen.dart';

// --- SHOP SCREENS ---
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/shop/products_list_screen.dart';
import '../../presentation/screens/shop/product_detail_screen.dart';
import '../../presentation/screens/shop/cart_screen.dart';
import '../../presentation/screens/shop/checkout_screen.dart';

// استيراد الصفحة الجديدة
import '../../presentation/screens/shop/chronic_diseases_screen.dart';

// --- CONSULTATIONS SCREENS ---
import '../../presentation/screens/consultations/consultations_screen.dart';
import '../../presentation/screens/consultations/new_consultation_screen.dart';
import '../../presentation/screens/consultations/chat_screen.dart';

// --- PROFILE & ORDERS SCREENS ---
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/profile/settings_screen.dart';
import '../../presentation/screens/shop//orders_list_screen.dart';
import '../../presentation/screens/shop/order_detail_screen.dart';

// prescription

import '../../presentation/screens/Prescriptions/prescription_list_screen.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  //initialLocation: '/splash',
  routes: [
    // ================= AUTH (Outside Shell) =================

    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // 3. إضافة مسار الـ Onboarding
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/forget-password',
      builder: (context, state) => const ForgetPasswordPage(),
    ),

    // ================= MAIN SHELL (Tabs) =================
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // 1. فرع الرئيسية (Home)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // 2. فرع الأدوية (Medications)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/medications',
              builder: (context, state) => const MedicationsListScreen(),
              routes: [
                GoRoute(path: 'add', builder: (context, state) => const AddMedicationScreen()),
                GoRoute(path: 'adherence', builder: (context, state) => const AdherenceStatsScreen()),
                GoRoute(
                  path: 'detail/:id',
                  builder: (context, state) => MedicationDetailScreen(medicationId: state.pathParameters['id']!),
                ),
                GoRoute(
                  path: 'history/:medicationId',
                  builder: (context, state) => MedicationHistoryScreen(medicationId: state.pathParameters['medicationId']!),
                ),
                GoRoute(
                  path: 'log/:medicationId',
                  builder: (context, state) => LogMedicationScreen(medicationId: state.pathParameters['medicationId']!),
                ),
                GoRoute(
                  path: 'edit/:medicationId',
                  builder: (context, state) => EditMedicationScreen(medicationId: state.pathParameters['medicationId']!),
                ),
              ],
            ),
          ],
        ),

        // 3. فرع المتجر (Shop)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shop',
              builder: (context, state) => const ShopScreen(),
              routes: [
                GoRoute(path: 'products', builder: (context, state) => const ProductsListScreen()),
                GoRoute(path: 'cart', builder: (context, state) => const CartScreen()),
                GoRoute(path: 'checkout', builder: (context, state) => const CheckoutScreen()),
                GoRoute(
                  path: 'product/:id',
                 // builder: (context, state) => ProductDetailsScreen(productId: state.pathParameters['id']!,),
                  builder: (context, state) {
                    final id =
                   state.pathParameters['id']!;
                    return ProductDetailScreen(productId: id);
                    },),

                // --- مسارات الفئات (Categories) ---

                // 1. فئة الأمراض المزمنة (مفعلة)
                GoRoute(
                    path: 'categories/chronic',
                    builder: (context, state) => const ChronicDiseasesScreen()
                ),

                 // 2. فئة المكملات الغذائية (معطلة حتى إنشاء الصفحة)
                GoRoute(
                  path: 'categories/supplements',
                  builder: (context, state) => const SupplementsScreen()
                ),

                // 3. فئة الأجهزة الطبية (معطلة حتى إنشاء الصفحة)
                GoRoute(
                  path: 'categories/devices',
                  builder: (context, state) => const MedicalDevicesScreen()
                ),

                // 4. فئة العناية والجمال (معطلة حتى إنشاء الصفحة)
                GoRoute(
                  path: 'categories/wellness',
                  builder: (context, state) => const WellnessScreen()
                ),

              ],
            ),
          ],
        ),

        // 4. فرع الاستشارات (Consultations)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/consultations',
              builder: (context, state) => const ConsultationsScreen(),
              routes: [
                //GoRoute(path: 'Chat/:id', builder: (context, state) => const ChatScreen(consultationId: 'dummy_id')),
                GoRoute(path: 'New', builder: (context, state) => const NewConsultationScreen()),
                GoRoute(path: 'chat/:id', builder: (context, state) {final id = state.pathParameters['id']!;return ChatScreen(consultationId: id);},),
                GoRoute(
                  path: 'detail/:id', // المسار الكلي: /medications/detail/123
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return ConsultationDetailScreen(consultationId: id);
                  },
                ),
              ],
            ),
          ],
        ),

        // 5. فرع الملف الشخصي (Profile)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(path: 'edit', builder: (context, state) => const EditProfileScreen()),
                GoRoute(path: 'settings', builder: (context, state) => const SettingsScreen()),
                GoRoute(path: 'orders', builder: (context, state) => const OrdersListScreen()),
                GoRoute(path: 'orders/detail/:id', builder: (context, state) => OrderDetailScreen(orderId: state.pathParameters ['id']!),),
               // GoRoute(
                 // path: 'orders/detail/:id',
                 // builder: (context, state) => OrderDetailScreen(orderId: state.pathParameters['id']!),
                //),
                // My Prescriptions (طلبك الجديد)
                GoRoute(path: 'prescriptions', builder: (context, state) => const PrescriptionListScreen()),
                GoRoute(path: 'prescriptions/detail/:id', builder: (context, state) => PrescriptionDetailScreen(prescriptionId: state.pathParameters ['id']!),),
                GoRoute(path: 'prescriptions/create-schedule/:id', builder: (context, state) => CreateScheduleScreen(prescriptionId: state.pathParameters ['id']!),)
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);


/*
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- AUTH SCREENS ---
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';

// --- HOME & MAIN ---
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/shop/order_detail_screen.dart';
import '../../presentation/screens/widgets/main_shell.dart';

// --- MEDICATION SCREENS ---
import '../../presentation/screens/medications/Edit_medication_screen.dart';
import '../../presentation/screens/medications/adherence_stats_screen.dart';
import '../../presentation/screens/medications/log_medication_screen.dart';
import '../../presentation/screens/medications/medication_detail_screen.dart';
import '../../presentation/screens/medications/medication_history_screen.dart';
import '../../presentation/screens/medications/medications_screen.dart';
import '../../presentation/screens/medications/add_medications_screen.dart';

// --- SHOP SCREENS (New) ---
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/shop/products_list_screen.dart';
import '../../presentation/screens/shop/product_detail_screen.dart';
import '../../presentation/screens/shop/cart_screen.dart';
import '../../presentation/screens/shop/checkout_screen.dart';

// --- CONSULTATIONS SCREENS ---
import '../../presentation/screens/consultations/consultations_screen.dart';
import '../../presentation/screens/consultations/new_consultation_screen.dart';
import '../../presentation/screens/consultations/chat_screen.dart';

// --- PROFILE & ORDERS SCREENS (New/Updated) ---
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';
import '../../presentation/screens/profile/settings_screen.dart';
import '../../presentation/screens/shop//orders_list_screen.dart';
//import '../../presentation/screens/shop/order_detail_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    // ================= AUTH (Outside Shell) =================
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // ================= MAIN SHELL (Tabs) =================
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // نمرر الـ navigationShell للملف الخاص بك MainShell ليتمكن من التحكم في التبديل
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // 1. فرع الرئيسية (Home)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // 2. فرع الأدوية (Medications)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/medications',
              builder: (context, state) => const MedicationsListScreen(),
              routes: [
                GoRoute(path: 'add', builder: (context, state) => const AddMedicationScreen()),
                GoRoute(path: 'adherence', builder: (context, state) => const AdherenceStatsScreen()),
                GoRoute(
                  path: 'detail/:id',
                  builder: (context, state) => MedicationDetailScreen(medicationId: state.pathParameters['id']!),
                ),
                GoRoute(
                  path: 'history/:medicationId',
                  builder: (context, state) => MedicationHistoryScreen(medicationId: state.pathParameters['medicationId']!),
                ),
                GoRoute(
                  path: 'log/:medicationId',
                  builder: (context, state) => LogMedicationScreen(medicationId: state.pathParameters['medicationId']!),
                ),
                GoRoute(
                  path: 'edit/:medicationId',
                  builder: (context, state) => EditMedicationScreen(medicationId: state.pathParameters['medicationId']!),
                ),
              ],
            ),
          ],
        ),

        // 3. فرع المتجر (Shop) - المرتبط بـ ERPNext
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shop',
              builder: (context, state) => const ShopScreen(),
              routes: [
                GoRoute(path: 'products', builder: (context, state) => const ProductsListScreen()),
                GoRoute(path: 'cart', builder: (context, state) => const CartScreen()),
                GoRoute(path: 'checkout', builder: (context, state) => CheckoutScreen()),
                GoRoute(path: 'product/:id',
                  builder: (context, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
                ),


              ],
            ),
          ],
        ),

        // 4. فرع الاستشارات (Consultations)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/consultations',
              builder: (context, state) => const ConsultationsScreen(),
              routes: [
                GoRoute(path: 'chat', builder: (context, state) => const ChatScreen(consultationId: 'dummy_id')),
                GoRoute(path: 'new', builder: (context, state) => const NewConsultationScreen()),
              ],
            ),
          ],
        ),

        // 5. فرع الملف الشخصي (Profile) - المرتبط بـ Firebase
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(path: 'edit', builder: (context, state) => const EditProfileScreen()),
                GoRoute(path: 'settings', builder: (context, state) => const SettingsScreen()),
                GoRoute(path: 'orders', builder: (context, state) => const OrdersListScreen()),
                GoRoute(
                  path: 'orders/detail/:id',
                  builder: (context, state) => OrderDetailScreen(orderId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

 */



/*
import 'package:go_router/go_router.dart';
// Screens
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/medications/Edit_medication_screen.dart';
import '../../presentation/screens/medications/adherence_stats_screen.dart';
import '../../presentation/screens/medications/log_medication_screen.dart';
import '../../presentation/screens/medications/medication_detail_screen.dart';
import '../../presentation/screens/medications/medication_history_screen.dart';
import '../../presentation/screens/medications/medications_screen.dart';
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/consultations/consultations_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/consultations/new_consultation_screen.dart';
import '../../presentation/screens/consultations/chat_screen.dart';
import '../../presentation/screens/medications/add_medications_screen.dart';
// Bottom Nav
import 'package:dawaii/presentation/screens/widgets/bottom_nav_bar.dart';

import '../../presentation/screens/widgets/main_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [

    // ================= AUTH =================
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // ================= MAIN SHELL =================
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [

        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: '/medications',
          builder: (context, state) => const MedicationsListScreen(),
        ),

        GoRoute(
          path: '/medications/add',
          builder: (context, state) => const AddMedicationScreen(),
        ),

        GoRoute(
          path: '/medications/adherence',
          builder: (context, state) => const AdherenceStatsScreen(),
        ),

        GoRoute(
          path: '/medications/detail/:id', // المسار الكلي: /medications/detail/123
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return MedicationDetailScreen(medicationId: id);
          },
        ),

        GoRoute(
          path: '/medications/history/:medicationId',
          builder: (context, state) {
            final id = state.pathParameters['medicationId']!;
            return MedicationHistoryScreen(medicationId: id);
          },
        ),

        GoRoute(
          path: '/medications/log/:medicationId',
          builder: (context, state) {
            final id = state.pathParameters['medicationId']!;
            return LogMedicationScreen(medicationId: id);
          },
        ),

        GoRoute(
          path: '/medications/edit/:medicationId',
          builder: (context, state) {
            final id = state.pathParameters['medicationId']!;
            return EditMedicationScreen(medicationId: id);
          },
        ),

        GoRoute(
          path: '/shop',
          builder: (context, state) => const ShopScreen(),
        ),

        GoRoute(
          path: '/consultations',
          builder: (context, state) => const ConsultationsScreen(),
        ),

        GoRoute(
          path: '/consultations/Chat',
          builder: (context, state) => const ChatScreen(consultationId: 'dummy_id',),
        ),

        GoRoute(
          path: '/consultations/New',
          builder: (context, state) => const NewConsultationScreen(),
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

 */


/*
// 1. Auth Screens
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
// ملاحظة: تأكد من وجود الملفات التالية في مجلد auth
import '../../presentation/screens/auth/splash_screen.dart';
 import '../../presentation/screens/auth/onboarding_screen.dart';

// 2. Home Screen
import '../../presentation/screens/home/home_screen.dart';

// 3. Medications Screens (الـ 7 ملفات)
import '../../presentation/screens/medications/medications_screen.dart'; // تم تعديل الاسم ليتوافق مع مجلدك
import '../../presentation/screens/medications/add_medications_screen.dart';
import '../../presentation/screens/medications/medication_detail_screen.dart';
// الملفات الإضافية التي طلبتها
// import '../../presentation/screens/medications/edit_medications_screen.dart';
 //import '../../presentation/screens/medications/log_medication_screen.dart';
 //import '../../presentation/screens/medications/medication_history_screen.dart';
 //import '../../presentation/screens/medications/adherence_stats_screen.dart';

// 4. Shop Screens
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/shop/product_detail_screen.dart';
import '../../presentation/screens/shop/cart_screen.dart';
import '../../presentation/screens/shop/checkout_screen.dart';

// 5. Consultations Screens
import '../../presentation/screens/consultations/consultations_screen.dart';
import '../../presentation/screens/consultations/chat_screen.dart';
import '../../presentation/screens/consultations/new_consultation_screen.dart';

// 6. Profile Screens
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home', // مؤقتاً للدخول المباشر للرئيسية أثناء التطوير
    routes: [
      // --- Auth Routes ---
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // --- Main Shell (يمكنك استخدام ShellRoute لاحقاً للـ BottomNavBar) ---
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      // --- Medications Section (The 7 Screens) ---
      GoRoute(
        path: '/medications',
        builder: (context, state) => const MedicationsListScreen(), // شاشة القائمة
        routes: [
          GoRoute(
            path: 'add', // المسار الكلي: /medications/add
            builder: (context, state) => const AddMedicationScreen(),
          ),
          GoRoute(
            path: 'detail/:id', // المسار الكلي: /medications/detail/123
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return MedicationDetailScreen(medicationId: id);
            },
          ),
          // يمكنك إضافة بقية المسارات الفرعية (edit, log, history) هنا بنفس النمط
        ],
      ),

      // --- Shop Section ---
      GoRoute(
        path: '/shop',
        builder: (context, state) => const ShopScreen(),
        routes: [
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ProductDetailScreen(productId: id);
            },
          ),
          GoRoute(
            path: 'cart',
            builder: (context, state) => const CartScreen(),
          ),
        ],
      ),

      // --- Consultations Section ---
      GoRoute(
        path: '/consultations',
        builder: (context, state) => const ConsultationsScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const NewConsultationScreen(),
          ),
          GoRoute(
            path: 'chat/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ChatScreen(consultationId: id);
            },
          ),
        ],
      ),

      // --- Profile Section ---
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],

    // إدارة الأخطاء في المسارات
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('الصفحة غير موجودة: ${state.error}')),
    ),
  );
});


 */
