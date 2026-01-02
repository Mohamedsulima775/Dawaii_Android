import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewConsultationScreen extends StatelessWidget {
  const NewConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Consultation')),
      body: const Center(child: Text('Newing Flow Here')),
    );
  }
}
