

import 'package:dawaii/presentation/screens/Prescriptions/prescription_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrescriptionListScreen extends StatelessWidget {
  const PrescriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prescriptions')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF2D6A4F),
                child: Icon(Icons.description, color: Colors.white),
              ),
              title: const Text('Dr. Ahmed Hassan'),
              subtitle: const Text('Dec 15, 2025 • 3 medications'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () => context.push('/profile/prescriptions/detail/dummy_id'),
            ),
          );
        },
      ),
    );
  }
}




