
// lib/widgets/medication_card_widget.dart
/*
import 'package:flutter/material.dart';
import '../../../../data/models/medication_model.dart';


class MedicationCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback? onTap;
  final VoidCallback? onLogTaken;

  const MedicationCard({
    Key? key,
    required this.medication,
    this.onTap,
    this.onLogTaken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Name + Status
              Row(
                children: [
                  // Medication Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: medication.isActive
                          ? Colors.blue.shade50
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.medication,
                      color: medication.isActive
                          ? Colors.blue
                          : Colors.grey,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Name + Scientific Name
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.medicationName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (medication.scientificName != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            medication.scientificName!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Active Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: medication.isActive
                          ? Colors.green.shade50
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      medication.isActive ? 'نشط' : 'موقوف',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: medication.isActive
                            ? Colors.green.shade700
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),

              // Details Row
              Row(
                children: [
                  // Dosage
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.local_pharmacy,
                      label: 'الجرعة',
                      value: medication.dosage,
                      color: Colors.purple,
                    ),
                  ),

                  // Frequency
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.access_time,
                      label: 'التكرار',
                      value: _getFrequencyArabic(medication.frequency),
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Stock Row
              Row(
                children: [
                  // Stock
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.inventory_2,
                      label: 'المخزون',
                      value: '${medication.currentStock} حبة',
                      color: medication.stockColor,
                    ),
                  ),

                  // Days until depletion
                  if (medication.daysUntilDepletion != null)
                    Expanded(
                      child: _buildInfoItem(
                        icon: Icons.warning_amber_rounded,
                        label: 'ينفذ خلال',
                        value: medication.daysUntilDepletion! <= 0
                            ? 'نفذ'
                            : '${medication.daysUntilDepletion} يوم',
                        color: medication.stockColor,
                      ),
                    ),
                ],
              ),

              // Instructions (if available)
              if (medication.instructions != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          medication.instructions!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Action Button (if onLogTaken provided)
              if (onLogTaken != null && medication.isActive) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onLogTaken,
                    icon: const Icon(Icons.check_circle, size: 20),
                    label: const Text('تسجيل التناول'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getFrequencyArabic(String frequency) {
    switch (frequency.toLowerCase()) {
      case 'daily':
        return 'يومي';
      case 'twice daily':
        return 'مرتين يومياً';
      case 'three times daily':
        return '3 مرات يومياً';
      case 'weekly':
        return 'أسبوعي';
      case 'as needed':
        return 'عند الحاجة';
      default:
        return frequency;
    }
  }
}

// Compact version for lists
class MedicationCompactCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback? onTap;

  const MedicationCompactCard({
    Key? key,
    required this.medication,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: medication.stockColor.withOpacity(0.2),
          child: Icon(
            Icons.medication,
            color: medication.stockColor,
          ),
        ),
        title: Text(
          medication.medicationName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${medication.dosage} • ${medication.currentStock} حبة',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: medication.daysUntilDepletion != null &&
            medication.daysUntilDepletion! <= 5
            ? Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: medication.stockColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            medication.daysUntilDepletion! <= 0
                ? 'نفذ'
                : '${medication.daysUntilDepletion}د',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: medication.stockColor,
            ),
          ),
        )
            : null,
      ),
    );
  }
}
*/



// الاول
import 'package:flutter/material.dart';
import '../../widgets/detail_row.dart';

class MedicationDetailInfo extends StatelessWidget {
  final String medicationName;
  final String dosage;
  final String frequency;
  final String? beforeAfterMeal;
  final String? duration;

  const MedicationDetailInfo({
    super.key,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    this.beforeAfterMeal,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header with Icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.medication,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicationName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        frequency,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            // Details
            _DetailRow(
              icon: Icons.medical_services,
              label: 'الجرعة',
              value: dosage,
            ),
            if (beforeAfterMeal != null) ...[
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.restaurant,
                label: 'التوقيت',
                value: beforeAfterMeal!,
              ),
            ],
            if (duration != null) ...[
              const SizedBox(height: 12),
              _DetailRow(
                icon: Icons.calendar_today,
                label: 'المدة',
                value: duration!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}


class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}



