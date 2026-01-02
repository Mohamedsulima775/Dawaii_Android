//lib/presentation/screens/home/home_screen.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../data/models/medication_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/medication_provider.dart';
//import 'package:dawaii/domain/entities/medication_schedule.dart'; // تأكد من المسار الصحيح

// Home widgets
import 'widgets/medication_card.dart';
import 'widgets/alert_card.dart';
import 'widgets/quick_actions.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final medicationState =
    ref.watch(medicationProvider(authState.patientId ?? ''));

    // Screen metrics
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    // Responsive card height: between 80 and 160 px, proportional to screen height
    final cardHeight = screenHeight * 0.14; // نسبة أولية
    final responsiveCardHeight = cardHeight.clamp(80.0, 160.0);

    // AppBar expanded height depends on card size + some fixed base
    final appBarExpandedBase = max(160.0, screenHeight * 0.22);
    final appBarExpandedHeight = appBarExpandedBase + responsiveCardHeight * 0.6;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // Keep card width not exceeding a sensible max (useful في landscape / tablets)
        final maxCardWidth = min(constraints.maxWidth - 32.0, 800.0);

        return CustomScrollView(
          slivers: [
            // SliverAppBar (ستبقى toolbar قصيرة عند التمرير؛ المحتوى القابل للطي في flexibleSpace)
            SliverAppBar(
              expandedHeight: appBarExpandedHeight,
              pinned: true, // toolbar (الجزء العلوي) يبقى مرئي — يمكن تغييره حسب الرغبة
              elevation: 0,
              backgroundColor: AppColors.primary,
              actions: [
                IconButton(
                  icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
                  onPressed: () {},
                ),
              ],

              // نترك bottom فارغ هنا — البطاقة ستُبنى كـ SliverPersistentHeader تحت AppBar
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF1B5E20), AppColors.primary],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      // padding ديناميكي يعتمد على حجم البطاقة لتجنّب overlap
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: screenHeight * 0.03,
                        bottom: responsiveCardHeight * 0.6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'مرحباً بعودتك 👋',
                            style: TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            authState.patientName ?? 'مستخدم تجريبي',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              '⭐ الالتزام هذا الشهر: 94%',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // هنا نبني البطاقة كـ SliverPersistentHeader حتى نتحكم في سلوكها أثناء التمرير
            SliverPersistentHeader(
              pinned: false, // البطاقة تتحرك وتختفي عند التمرير لأعلى
              floating: false,
              delegate: _QuickActionsHeaderDelegate(
                maxExtentValue: responsiveCardHeight,
                minExtentValue: 0.0, // تسمح بالانكماش حتى الاختفاء تمامًا
                maxCardWidth: maxCardWidth,
              ),
            ),

            // المحتوى العادي
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 10),
                  _sectionHeader(
                    context,
                    title: 'الأدوية القادمة',
                    onViewAll: () => context.go('/medications'),
                  ),
                  const SizedBox(height: 12),
                  _buildMedicationsSection(context, medicationState),
                  const SizedBox(height: 24),
                  _buildAlertsSection(medicationState),
                  const SizedBox(height: 24),
                  // مسافة إضافية للأسفل (مثلاً لظهور bottom navigation)
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }

  // =======================
  // Alerts Section
  // =======================
  Widget _buildAlertsSection(medicationState) {
    final alerts = medicationState.medications
        .where((MedicationSchedule m) => m.daysUntilDepletion <= 5)
        .toList();

    if (alerts.isEmpty) return const SizedBox();

    return Column(
      children: alerts
          .map<Widget>(
            (med) =>
            AlertCard(
              medication: med,
              title: 'تنبيه',
              subtitle: 'الدواء أوشك على النفاد',
            ),
      )
          .toList(),
    );
  }

  // =======================
  // Medications Section
  // =======================
  Widget _buildMedicationsSection(BuildContext context, medicationState) {
    if (medicationState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (medicationState.medications.isEmpty) {
      return const Center(child: Text('لا توجد أدوية'));
    }

    return Column(
      children: medicationState.medications
          .take(3)
          .map<Widget>(
            (med) => MedicationCard(
          medication: med,
          onTap: () {},
        ),
      )
          .toList(),
    );
  }

  Widget _sectionHeader(BuildContext context,
      {required String title, VoidCallback? onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text('عرض الكل'),
          ),
      ],
    );
  }
}

/// Delegate مخصص لعرض QuickActions كـ SliverPersistentHeader
class _QuickActionsHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtentValue;
  final double minExtentValue;
  final double maxCardWidth;

  _QuickActionsHeaderDelegate({
    required this.maxExtentValue,
    required this.minExtentValue,
    required this.maxCardWidth,
  });

  @override
  double get minExtent => minExtentValue;

  @override
  double get maxExtent => maxExtentValue;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // shrinkOffset = مقدار السكروول الذي "جرّ" العنوان لأعلى
    // سنستخدمه لتحريك البطاقة لأعلى (حتى تختفي) — هذا يمنع التداخل الثابت
    final dy = -shrinkOffset; // تحريك لأعلى بمقدار التمرير
    final visible = (shrinkOffset < maxExtent); // هل البطاقة لازالت مرئية؟

    // width constraint مناسب للـ landscape
    return SizedBox(
      height: maxExtent,
      child: Opacity(
        opacity: visible ? 1.0 : 0.0,
        child: Transform.translate(
          offset: Offset(0, dy),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxCardWidth,
                minWidth: 0,
                maxHeight: maxExtent,
              ),
              child: SizedBox(
                height: maxExtent,
                child: const QuickActionsWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _QuickActionsHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtentValue != maxExtentValue ||
        oldDelegate.minExtentValue != minExtentValue ||
        oldDelegate.maxCardWidth != maxCardWidth;
  }
}








/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/medication_provider.dart';


import 'widgets/medication_card.dart';
import 'widgets/alert_card.dart';
import 'widgets/quick_actions.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final medicationState = ref.watch(
      medicationProvider(authState.patientId!),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'مرحباً بعودتك 👋',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  authState.patientName ?? 'مستخدم',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // TODO: Navigate to notifications
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'الالتزام هذا الشهر:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '94%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Actions
                  const QuickActionsWidget(),

                  const SizedBox(height: 24),

                  // Upcoming Medications
                  _buildSectionHeader(
                    context,
                    'الأدوية القادمة',
                    onViewAll: () {
                     // Navigator.pushNamed(context, '/medications');
                      context.go('/medications');
                    },
                  ),

                  const SizedBox(height: 12),

                  if (medicationState.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (medicationState.medications.isEmpty)
                    _buildEmptyState(context)
                  else
                    ...medicationState.medications
                        .take(3)
                        .map((med) => MedicationCard(medication: med, onTap: () {  },))
                        .toList(),

                  const SizedBox(height: 24),

                  // Low Stock Alerts
                  ...medicationState.medications
                      .where((med) => med.daysUntilDepletion <= 5)
                      .map((med) => AlertCard(medication: med, title: '', subtitle: '',))
                      .toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context,
      String title, {
        VoidCallback? onViewAll,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (onViewAll != null)
          TextButton(
            onPressed: onViewAll,
            child: const Text('عرض الكل'),
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.medication_outlined,
            size: 64,
            color: AppColors.textLight.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'لم تضف أي أدوية بعد',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
             // Navigator.pushNamed(context, '/add-medication');
              context.go('/medications/add');
            },
            child: const Text('إضافة دواء الآن'),
          ),
        ],
      ),
    );
  }
}

 */



