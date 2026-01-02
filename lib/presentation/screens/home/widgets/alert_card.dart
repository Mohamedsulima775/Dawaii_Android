//lib/widgets/alert_card.dart

// alert_card.dart
import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final dynamic medication; // تأكد من نوع البيانات (MedicationModel)

  const AlertCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.medication, // نمرر الدواء هنا
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.red.shade100),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
        ),
        title: Text(
          medication.medicationName, // عرض اسم الدواء الذي أوشك على النفاذ
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        ),
        subtitle: Text(
          'متبقي $subtitle (${medication.currentStock} حبة)', // عرض الكمية
          style: TextStyle(color: Colors.red.shade700),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.red),
        onTap: () {
          // الانتقال لصفحة التفاصيل عند الضغط على التنبيه
          // context.push('/medications/details/${medication.id}');
        },
      ),
    );
  }
}


/*
import 'package:dawaii/data/models/medication_model.dart';
import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const AlertCard({
    super.key,
    required this.title,
    required this.subtitle, required MedicationSchedule medication,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red.shade50,
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.red),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

 */