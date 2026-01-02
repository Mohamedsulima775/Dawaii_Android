import 'package:flutter/material.dart';

class StockIndicatorCard extends StatelessWidget {
  final int currentStock;
  final int daysRemaining;
  final bool isLowStock;

  const StockIndicatorCard({
    super.key,
    required this.currentStock,
    required this.daysRemaining,
    required this.isLowStock,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (currentStock / 100).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'المخزون',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$currentStock حبة',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isLowStock ? Colors.red : const Color(0xFF2D6A4F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$daysRemaining يوم متبقي',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isLowStock ? Colors.red[50] : Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isLowStock ? Icons.warning : Icons.check_circle,
                    color: isLowStock ? Colors.red : Colors.green,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isLowStock ? Colors.red : const Color(0xFF2D6A4F),
              ),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            if (isLowStock) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'مخزون منخفض! قم بإعادة الطلب',
                        style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}