/*
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChronicDiseasesScreen extends StatelessWidget {
  const ChronicDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الأقسام (يمكنك جلبها من الـ Repository لاحقاً)
    final List<Map<String, dynamic>> chronicCategories = [
      {'name': 'Diabetes', 'icon': Icons.bloodtype, 'color': Colors.red},
      {'name': 'Hypertension', 'icon': Icons.monitor_heart, 'color': Colors.blue},
      {'name': 'Asthma', 'icon': Icons.air, 'color': Colors.green},
      {'name': 'Heart Disease', 'icon': Icons.favorite, 'color': Colors.orange},
      {'name': 'Cholesterol', 'icon': Icons.opacity, 'color': Colors.purple},
      {'name': 'Thyroid', 'icon': Icons.waves, 'color': Colors.teal},
      {'name': 'Mental Disorder', 'icon': Icons.waves, 'color': Colors.teal},
      {'name': 'Thyroid', 'icon': Icons.waves, 'color': Colors.teal},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chronic Diseases'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: chronicCategories.length,
        itemBuilder: (context, index) {
          final item = chronicCategories[index];
          return _buildCategoryItem(context, item);
        },
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        // هنا يتم الانتقال لصفحة الأدوية الخاصة بهذا القسم
        context.push('/shop/products?category=${item['name']}');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: item['color'].withOpacity(0.1),
              child: Icon(item['icon'], color: item['color'], size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              item['name'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Explore Meds',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

 */
