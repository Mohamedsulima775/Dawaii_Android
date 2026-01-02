import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProvidersListScreen extends StatelessWidget {
  const ProvidersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Providers'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 30),
              ),
              title: const Text('Dr. Ahmed Hassan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Cardiology • 15 years exp\n\$50 consultation'),
              isThreeLine: true,
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => context.push('/providers/profile/dummy_id'),
            ),
          );
        },
      ),
    );
  }
}
