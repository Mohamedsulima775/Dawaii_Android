import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D6A4F).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_bag, color: Color(0xFF2D6A4F)),
              ),
              title: const Text('Order #12345'),
              subtitle: const Text('Dec 15, 2025 • 3 items\nSAR 450.00'),
              isThreeLine: true,
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Processing',
                    style: TextStyle(
                        color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              onTap: () => context.push('/profile/orders/detail/dummy_id'),
            ),
          );
        },
      ),
    );
  }
}