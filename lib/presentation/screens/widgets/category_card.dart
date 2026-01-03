
/*
// base_category
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart' show StatelessWidget, AppBar, Colors, Material, InkWell, Scaffold;
import 'package:flutter/widgets.dart';

class BaseCategoryScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final List<Map<String, dynamic>> items;

  const BaseCategoryScreen({
    required this.title,
    required this.primaryColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.9,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {}, // اربطها بصفحة المنتجات لاحقاً
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'], color: primaryColor, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['desc'],
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

 */

/*
import 'package:flutter/material.dart';
import '../../../data/models/category_item.dart';


// كلاس CategoryCard المعدل
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required CategoryItem category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.2), width: 1),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

 */

/// الاخير

// lib/presentation/widgets/category_card.dart

import 'package:flutter/material.dart';
import '../../../data/models/category_item.dart';

class CategoryCard extends StatelessWidget {
  final CategoryItem category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الجزء العلوي: الحاوية المربعة (تم التغيير هنا)
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.15), // خلفية خفيفة من نفس لون الفئة
              // تم تغيير shape من BoxShape.circle إلى borderRadius لعمل شكل مربع
              borderRadius: BorderRadius.circular(18), // زوايا منحنية تعطي شكلاً مربعاً عصرياً
              border: Border.all(
                color: category.color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              category.icon,
              size: 35,
              color: category.color, // الأيقونة تأخذ اللون الأساسي للفئة
            ),
          ),
          const SizedBox(height: 12),
          // اسم الفئة بالعربي (إذا وجد) أو بالإنجليزي
          Text(
            category.nameAr ?? category.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // نص إضافي صغير للإنجليزي إذا كان العرض بالعربي
          if (category.nameAr != null)
            Text(
              category.name,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
