import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav_bar.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  void _onTap(int index) {
    // التنقل الذكي: إذا ضغطت على نفس التبويب يرجعك لأول الصفحة
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الـ body سيعرض الفرع المختار حالياً ويحفظ حالته
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.medication_outlined), label: 'Meds'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.chat_outlined), label: 'Consults'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}



/*
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  static const tabs = [
    '/home',
    '/medications',
    '/shop',
    '/consultations',
    '/profile',
  ];

  int _locationToIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = tabs.indexWhere((t) => location.startsWith(t));
    return index < 0 ? 0 : index;
  }

  void _onTap(BuildContext context, int index) {
    context.go(tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _locationToIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }
}

 */