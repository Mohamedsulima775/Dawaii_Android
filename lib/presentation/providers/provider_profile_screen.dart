import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/widgets/detail_row.dart';

class ProviderProfileScreen extends StatelessWidget {
  final String providerId;
  const ProviderProfileScreen({super.key, required this.providerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFF2D6A4F),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Color(0xFF2D6A4F)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Dr. Ahmed Hassan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cardiology Specialist',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          DetailRow('Experience', '15 years'),
                          const Divider(height: 24),
                          DetailRow('Education', 'MD, PhD Cardiology'),
                          const Divider(height: 24),
                          DetailRow('Languages', 'Arabic, English'),
                          const Divider(height: 24),
                          DetailRow('Consultation Fee', '\$50'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('About',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                    'Dr. Ahmed is a board-certified cardiologist with over 15 years of experience...',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => context.push('/consultations/book'),
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Book Consultation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
