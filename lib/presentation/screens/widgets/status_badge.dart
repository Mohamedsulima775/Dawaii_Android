import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const StatusBadge({
    super.key,
    required this.text,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for common statuses
  factory StatusBadge.active() {
    return const StatusBadge(
      text: 'نشط',
      color: Colors.green,
      icon: Icons.check_circle,
    );
  }

  factory StatusBadge.inactive() {
    return const StatusBadge(
      text: 'غير نشط',
      color: Colors.grey,
      icon: Icons.pause_circle,
    );
  }

  factory StatusBadge.pending() {
    return const StatusBadge(
      text: 'قيد الانتظار',
      color: Colors.orange,
      icon: Icons.schedule,
    );
  }

  factory StatusBadge.completed() {
    return const StatusBadge(
      text: 'مكتمل',
      color: Colors.blue,
      icon: Icons.check_circle_outline,
    );
  }
}