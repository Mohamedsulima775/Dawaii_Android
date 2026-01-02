

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/prescription.dart';




class PrescriptionDetailScreen extends StatelessWidget {
  final String prescriptionId;
  const PrescriptionDetailScreen({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Prescription #12345',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Date: Dec 15, 2025',
                        style: TextStyle(color: Colors.grey[600])),
                    Text('Valid Until: Mar 15, 2026',
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Dr. Ahmed Hassan'),
                subtitle: const Text('Cardiology'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Medications',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...List.generate(
                        3,
                            (i) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.medication),
                          title: Text('Medication ${i + 1}'),
                          subtitle: const Text('500mg - Twice Daily'),
                          trailing: const Icon(Icons.check_circle,
                              color: Colors.green),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    context.push('/profile/prescriptions/create-schedule/$prescriptionId'),
                icon: const Icon(Icons.add),
                label: const Text('Create Medication Schedules'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


