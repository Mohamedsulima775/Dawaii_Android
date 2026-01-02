import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/shop/product_card.dart';

import '../widgets/filter_bottom_sheet.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // لجعل الحواف الدائرية تظهر بشكل صحيح
      builder: (context) => const FilterBottomSheet(), // 2. هذا هو التعديل المطلوب بالضبط
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدوية والمنتجات'),
        actions: [
          IconButton(
            onPressed: () => _showFilter(context),
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () => context.push('/shop/cart'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55, // للحماية من الـ Overflow
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ProductCard(
            productName: 'دواء تجريبي $index',
            price: 100.0 + (index * 10),
            inStock: index % 3 != 0,
            rating: 4.5,
            onTap: () => context.push('/shop/product/dummy_id'),
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تمت الإضافة إلى السلة')),
              );
            },
          );
        },
      ),
    );
  }
}

/*
class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدوية والمنتجات'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          IconButton(
            onPressed: () => context.push('/shop/cart'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65, // قمت بتقليل النسبة قليلاً لتناسب الأزرار والتقييم الجديد
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ProductCard(
            // التعديل هنا: استخدام المسميات الجديدة من كود ProductCard الخاص بك
            productName: 'دواء تجريبي $index',
            price: 100.0 + (index * 10),
            inStock: index % 3 != 0, // مثال: جعل بعض الأدوية غير متوفرة
            rating: 4.5,
            onTap: () => context.push('/shop/product/dummy_id'),
            onAddToCart: () {
              // سيتم ربط هذا لاحقاً بسلة المشتريات
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تمت الإضافة إلى السلة')),
              );
            },
          );
        },
      ),
    );
  }
}

 */

