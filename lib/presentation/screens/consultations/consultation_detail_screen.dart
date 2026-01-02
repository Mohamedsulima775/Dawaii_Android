import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/widgets/detail_row.dart';

class ConsultationDetailScreen extends StatelessWidget {
  final String consultationId;
  const ConsultationDetailScreen({super.key, required this.consultationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consultation Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Dr. Ahmed Hassan'),
                subtitle: const Text('Cardiology • 15 years exp'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow('Type', 'Chat Consultation'),
                    const Divider(height: 24),
                    DetailRow('Date', 'Dec 20, 2025'),
                    const Divider(height: 24),
                    DetailRow('Time', '10:00 AM'),
                    const Divider(height: 24),
                    DetailRow('Status', 'Scheduled'),
                    const Divider(height: 24),
                    DetailRow('Fee', '\$50'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push('/consultations/chat/$consultationId'),
                icon: const Icon(Icons.chat),
                label: const Text('Start Chat'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Cancel Consultation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

