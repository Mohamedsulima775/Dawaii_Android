

import 'package:flutter/material.dart';

class MedicationHistoryScreen extends StatelessWidget {
  final String medicationId;
  const MedicationHistoryScreen({super.key, required this.medicationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication History')),
      body: const Center(child: Text('History Timeline Here')),
    );
  }
}