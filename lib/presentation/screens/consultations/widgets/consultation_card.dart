import 'package:flutter/material.dart';

class ConsultationCard extends StatelessWidget {
  final String providerName;
  final String? providerImageUrl;
  final String specialty;
  final String date;
  final String time;
  final String type;
  final String status;
  final int? unreadCount;
  final VoidCallback onTap;
  final VoidCallback? onChatTap;

  const ConsultationCard({
    super.key,
    required this.providerName,
    this.providerImageUrl,
    required this.specialty,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    this.unreadCount,
    required this.onTap,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status.toLowerCase() == 'active' ||
        status.toLowerCase() == 'in progress';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Provider Avatar
              CircleAvatar(
                radius: 30,
                backgroundImage: providerImageUrl != null
                    ? NetworkImage(providerImageUrl!)
                    : null,
                child: providerImageUrl == null
                    ? const Icon(Icons.person, size: 30)
                    : null,
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            providerName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (unreadCount != null && unreadCount! > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unreadCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _getTypeIcon(type),
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$date - $time',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Button
              if (isActive && onChatTap != null)
                ElevatedButton(
                  onPressed: onChatTap,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('دردشة'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'chat':
        return Icons.chat_bubble_outline;
      case 'video':
        return Icons.video_call;
      case 'voice':
        return Icons.phone;
      default:
        return Icons.medical_services;
    }
  }
}