
// lib/features/shop/presentation/pages/chronic_diseases_page.dart

/*
import 'package:flutter/material.dart';
import 'base_category_screen.dart';


class ChronicDiseasesScreen extends StatelessWidget {
  const ChronicDiseasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diseases = [
      DiseaseCategory(
        name: 'Diabetes',
        nameAr: 'السكري',
        icon: Icons.water_drop,
        color: const Color(0xFFE3F2FD),
        iconColor: Colors.blue[700]!,
        description: 'أدوية وأجهزة قياس السكر',
      ),
      DiseaseCategory(
        name: 'Hypertension',
        nameAr: 'ضغط الدم',
        icon: Icons.favorite,
        color: const Color(0xFFFFEBEE),
        iconColor: Colors.red[700]!,
        description: 'أدوية ضغط الدم وأجهزة القياس',
      ),
      DiseaseCategory(
        name: 'Asthma',
        nameAr: 'الربو',
        icon: Icons.air,
        color: const Color(0xFFE8F5E9),
        iconColor: Colors.green[700]!,
        description: 'بخاخات وأدوية الربو',
      ),
      DiseaseCategory(
        name: 'Heart Disease',
        nameAr: 'أمراض القلب',
        icon: Icons.monitor_heart,
        color: const Color(0xFFFCE4EC),
        iconColor: Colors.pink[700]!,
        description: 'أدوية القلب والشرايين',
      ),
      DiseaseCategory(
        name: 'Cholesterol',
        nameAr: 'الكوليسترول',
        icon: Icons.bloodtype,
        color: const Color(0xFFFFF3E0),
        iconColor: Colors.orange[700]!,
        description: 'أدوية خفض الكوليسترول',
      ),
      DiseaseCategory(
        name: 'Thyroid',
        nameAr: 'الغدة الدرقية',
        icon: Icons.science,
        color: const Color(0xFFE0F2F1),
        iconColor: Colors.teal[700]!,
        description: 'أدوية الغدة الدرقية',
      ),
      DiseaseCategory(
        name: 'Arthritis',
        nameAr: 'التهاب المفاصل',
        icon: Icons.accessibility_new,
        color: const Color(0xFFF3E5F5),
        iconColor: Colors.purple[700]!,
        description: 'مسكنات ومضادات الالتهاب',
      ),
      DiseaseCategory(
        name: 'Kidney Disease',
        nameAr: 'أمراض الكلى',
        icon: Icons.filter_alt,
        color: const Color(0xFFEDE7F6),
        iconColor: Colors.deepPurple[700]!,
        description: 'أدوية الكلى والمسالك البولية',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chronic Diseases',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Colors.blue,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'أدوية الأمراض المزمنة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'اختر نوع المرض لعرض المنتجات',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Diseases Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return _buildDiseaseCard(context, diseases[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseCard(BuildContext context, DiseaseCategory disease) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryCard (
              categoryName: disease.name,
              categoryNameAr: disease.nameAr,
              categoryIcon: disease.icon,
              categoryColor: disease.iconColor,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: disease.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                disease.icon,
                size: 40,
                color: disease.iconColor,
              ),
            ),

            const SizedBox(height: 16),

            // Name
            Text(
              disease.nameAr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // English Name
            Text(
              disease.name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                disease.description,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model
class DiseaseCategory {
  final String name;
  final String nameAr;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final String description;

  DiseaseCategory({
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.description,
  });
}

 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/data/models/category_item.dart'; // الموديل الموحد
import '../widgets/category_card.dart'; // الـ Widget الموحد

class ChronicDiseasesScreen extends StatelessWidget {
  const ChronicDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدمنا CategoryItem لتوحيد البيانات مع بقية التطبيق
    final List<CategoryItem> diseases = [
      CategoryItem(
        id: 'diabetes',
        name: 'Diabetes',
        nameAr: 'السكري',
        icon: Icons.water_drop,
        color: const Color(0xFF2196F3),
      ),
      CategoryItem(
        id: 'hypertension',
        name: 'Hypertension',
        nameAr: 'ضغط الدم',
        icon: Icons.favorite,
        color: const Color(0xFFF44336),
      ),
      CategoryItem(
        id: 'asthma',
        name: 'Asthma',
        nameAr: 'الربو',
        icon: Icons.air,
        color: const Color(0xFF4CAF50),
      ),
      CategoryItem(
        id: 'heart',
        name: 'Heart Disease',
        nameAr: 'أمراض القلب',
        icon: Icons.monitor_heart,
        color: const Color(0xFFE91E63),
      ),
      CategoryItem(
        id: 'cholesterol',
        name: 'Cholesterol',
        nameAr: 'الكوليسترول',
        icon: Icons.bloodtype,
        color: const Color(0xFFFF9800),
      ),
      CategoryItem(
        id: 'thyroid',
        name: 'Thyroid',
        nameAr: 'الغدة الدرقية',
        icon: Icons.science,
        color: const Color(0xFF009688),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => context.pop(), // استخدام GoRouter
        ),
        title: const Text(
          'Chronic Diseases',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Header القسم العلوي
          _buildHeader(),

          // شبكة الأمراض المزمنة باستخدام الـ Widget الموحد
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8, // تناسب مع الكرت الجديد
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: diseases.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: diseases[index],
                  onTap: () {
                    // الانتقال لصفحة المنتجات الخاصة بهذا المرض
                    context.push('/shop/products?category=${diseases[index].id}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.medical_services, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('أدوية الأمراض المزمنة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('اختر نوع المرض لعرض المنتجات',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
