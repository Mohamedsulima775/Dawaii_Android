import 'package:flutter/material.dart';

class MedicationLogHistory extends StatelessWidget {
  final List<Map<String, dynamic>> logs;
  final VoidCallback onViewAll;

  const MedicationLogHistory({
    super.key,
    required this.logs,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'السجل الأخير',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onViewAll,
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...logs.map((log) => _LogItem(
              date: log['date'] as String,
              status: log['status'] as String,
              statusColor: _getStatusColor(log['status'] as String),
            )),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'taken':
      case 'تم التناول':
        return Colors.green;
      case 'skipped':
      case 'تم التخطي':
        return Colors.orange;
      case 'missed':
      case 'فائت':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
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
      ),
    );
  }
}
