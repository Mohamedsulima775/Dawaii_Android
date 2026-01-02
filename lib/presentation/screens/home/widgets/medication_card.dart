//lib/presentation/screens/home/widgets/medication_card.dart:

/*
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/medication_model.dart';

class MedicationCard extends StatelessWidget {
  final MedicationSchedule medication;
  final VoidCallback onTap;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.medication_outlined,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication.medicationName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    medication.formattedNextDoseTime,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

 */


import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/medication_model.dart';
import 'package:intl/intl.dart';

class MedicationCard extends StatelessWidget {
  final MedicationSchedule medication;
  final VoidCallback onTap; // إضافة خاصية النقر

  const MedicationCard({
    super.key,
    required this.medication,
    required this.onTap, // جعلها مطلوبة في الـ Constructor
  });

  Color _getColorFromCode(String? colorCode) {
    if (colorCode == null) return AppColors.primary;
    try {
      final code = colorCode.replaceAll('#', '');
      return Color(int.parse('FF$code', radix: 16));
    } catch (e) {
      return AppColors.primary;
    }
  }

  String _getNextTime() {
    if (medication.times.isEmpty) return 'غير محدد';

    final now = TimeOfDay.now();

    for (final time in medication.times) {
      final parts = time.time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final timeOfDay = TimeOfDay(hour: hour, minute: minute);

      if (timeOfDay.hour > now.hour ||
          (timeOfDay.hour == now.hour && timeOfDay.minute > now.minute)) {
        return time.time;
      }
    }
    return medication.times.first.time;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorFromCode(medication.colorCode);
    final nextTime = _getNextTime();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          right: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Material( // إضافة Material و InkWell لتفعيل تأثير اللمس
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap, // تفعيل النقر هنا
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // أيقونة الدواء
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.medication,
                    color: color,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                // معلومات الدواء
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication.medicationName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'الجرعة القادمة: $nextTime',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildStockBadge(),
                        ],
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.arrow_forward_ios, // تغيير الأيقونة لتناسب الاتجاه العربي إذا لزم
                  size: 16,
                  color: AppColors.textHint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStockBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '${medication.currentStock} ${medication.stockUnit}',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

