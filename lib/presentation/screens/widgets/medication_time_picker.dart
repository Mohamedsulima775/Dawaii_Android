import 'package:flutter/material.dart';

class MedicationTimePicker extends StatefulWidget {
  final List<TimeOfDay> selectedTimes;
  final Function(List<TimeOfDay>) onTimesChanged;

  const MedicationTimePicker({
    super.key,
    required this.selectedTimes,
    required this.onTimesChanged,
  });

  @override
  State<MedicationTimePicker> createState() => _MedicationTimePickerState();
}

class _MedicationTimePickerState extends State<MedicationTimePicker> {
  Future<void> _addTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final updatedTimes = [...widget.selectedTimes, time];
      updatedTimes.sort((a, b) {
        final aMinutes = a.hour * 60 + a.minute;
        final bMinutes = b.hour * 60 + b.minute;
        return aMinutes.compareTo(bMinutes);
      });
      widget.onTimesChanged(updatedTimes);
    }
  }

  void _removeTime(int index) {
    final updatedTimes = [...widget.selectedTimes];
    updatedTimes.removeAt(index);
    widget.onTimesChanged(updatedTimes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'أوقات تناول الدواء',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: _addTime,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('إضافة وقت'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (widget.selectedTimes.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Center(
              child: Text(
                'لم يتم إضافة أوقات بعد',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedTimes.asMap().entries.map((entry) {
              final index = entry.key;
              final time = entry.value;
              return Chip(
                label: Text(time.format(context)),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => _removeTime(index),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              );
            }).toList(),
          ),
      ],
    );
  }
}