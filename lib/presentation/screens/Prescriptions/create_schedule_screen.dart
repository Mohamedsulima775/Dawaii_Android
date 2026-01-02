

import 'package:flutter/material.dart';

class CreateScheduleScreen extends StatelessWidget {
  final String prescriptionId;
  const CreateScheduleScreen({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Schedules')),
      body: const Center(child: Text('Select Medications & Set Times')),
    );
  }
}