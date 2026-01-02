import 'package:flutter/material.dart';

class MedicationScheduleCard extends StatelessWidget {
  final List<String> times;
  final List<bool>? completionStatus;

  const MedicationScheduleCard({
    super.key,
    required this.times,
    this.completionStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'مواعيد التناول',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(times.length, (index) {
              final isCompleted = completionStatus != null &&
                  index < completionStatus!.length &&
                  completionStatus![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      isCompleted ? Icons.check_circle : Icons.access_time,
                      color: isCompleted ? Colors.green : Colors.grey,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      times[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: isCompleted ? Colors.green : Colors.black87,
                        fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}