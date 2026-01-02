import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultationsScreen extends StatelessWidget {
  const ConsultationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Consultations'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ConsultationsList(status: 'Active'),
            _ConsultationsList(status: 'Past'),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/consultations/New'),
          icon: const Icon(Icons.add),
          label: const Text('New'),
        ),
      ),
    );
  }
}

class _ConsultationsList extends StatelessWidget {
  final String status;
  const _ConsultationsList({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('Dr. Ahmed Hassan'),
            subtitle: const Text('Dec 20, 2025 - 10:00 AM\nChat Consultation'),
            isThreeLine: true,
            trailing: status == 'Active'
                ? ElevatedButton(
              onPressed: () => context.push('/consultations/chat/dummy_id'),
              child: const Text('Chat'),

            )
                : null,
            onTap: () => context.push('/consultations/detail/dummy_id'),
          ),
        );
      },
    );
  }
}