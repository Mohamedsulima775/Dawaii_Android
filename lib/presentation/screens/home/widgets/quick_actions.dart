//lib/widgets/quick_actions_widget.dart

import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // جلب الألوان من الثيم
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(
            context,
            icon: Icons.add, // الأيقونة المطلوبة 1
            label: 'إضافة دواء',
            backgroundColor: colorScheme.primary,
            onTap: () {
              // منطق التنقل لصفحة الإضافة
              context.go('/medications/add');
            },
          ),
          _buildActionItem(
            context,
            icon: Icons.alarm, // الأيقونة المطلوبة 2
            label: 'الجدول',
            backgroundColor: colorScheme.secondary,
            onTap: () {
              // منطق التنقل لصفحة التذكيرات/الجدول
            },
          ),
          _buildActionItem(
            context,
            icon: Icons.medical_services, // الأيقونة المطلوبة 3
            label: 'التقارير',
            backgroundColor: colorScheme.tertiary,
            onTap: () {
              // منطق التنقل لصفحة الخدمات الطبية
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Color backgroundColor,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary, // لون الأيقونة من الثيم
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}




/*
import 'package:flutter/material.dart';
class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Icon(Icons.add),
        Icon(Icons.alarm),
        Icon(Icons.medical_services),
      ],
    );
  }
}

 */

