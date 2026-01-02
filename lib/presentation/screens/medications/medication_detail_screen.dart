
// lib/screens/medication_detail_screen.dart


// الاول
import 'package:dawaii/presentation/screens/medications/widgets/stock_indicator_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MedicationDetailScreen extends StatelessWidget {
  final String medicationId;

  const MedicationDetailScreen({
    super.key,
    required this.medicationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Details'),
        actions: [
          IconButton(
            onPressed: () => context.push('/medications/edit/$medicationId'),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. كارت المعلومات الأساسية
            _buildBasicInfoCard(),

            const SizedBox(height: 16),

            // 2. كارت المواعيد
            _buildScheduleCard(),

            const SizedBox(height: 16),

            // 3. استخدام الـ Widget المنفصل للمخزون (تم حذف الكود المكرر)
            const StockIndicatorCard(
              currentStock: 120,
              daysRemaining: 60,
              isLowStock: false,
            ),

            const SizedBox(height: 16),

            // 4. كارت السجل الأخير
            _buildRecentLogsCard(context),

            const SizedBox(height: 16),

            // 5. قسم الملاحظات
            _buildNotesCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/medications/log/$medicationId'),
        icon: const Icon(Icons.check),
        label: const Text('Log Now'),
      ),
    );
  }

  // --- Widgets داخلية للحفاظ على نظافة الـ Build Method ---

  Widget _buildBasicInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D6A4F).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.medication, color: Color(0xFF2D6A4F), size: 40),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Glucophage 500mg', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Twice Daily', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const _DetailRow(icon: Icons.medical_services, label: 'Dosage', value: '500mg'),
            const SizedBox(height: 12),
            const _DetailRow(icon: Icons.restaurant, label: 'Timing', value: 'After Meal'),
            const SizedBox(height: 12),
            const _DetailRow(icon: Icons.calendar_today, label: 'Duration', value: '3 months'),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const _TimeItem(time: '08:00 AM', isCompleted: true),
            const SizedBox(height: 12),
            const _TimeItem(time: '20:00 PM', isCompleted: false),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLogsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => context.push('/medications/history/$medicationId'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _LogItem(date: 'Today, 08:00 AM', status: 'Taken', statusColor: Colors.green),
            const SizedBox(height: 8),
            const _LogItem(date: 'Yesterday, 20:00 PM', status: 'Taken', statusColor: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard() {
    return const Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Take with plenty of water. Avoid alcohol.', style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }


  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medication'),
        content: const Text(
          'Are you sure you want to delete this medication?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
              // TODO: Delete medication
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
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

class _TimeItem extends StatelessWidget {
  final String time;
  final bool isCompleted;

  const _TimeItem({
    required this.time,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.access_time,
          color: isCompleted ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 12),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            color: isCompleted ? Colors.green : Colors.black87,
            fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _LogItem extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;

  const _LogItem({
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            date,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 12,
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

