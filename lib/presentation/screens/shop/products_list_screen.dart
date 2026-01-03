
/*
// الاول
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

 */

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

//// المعدل من الشات والمتمد

// lib/features/shop/presentation/pages/products_list_screen.dart

/*
import 'package:dawaii/data/models/product.dart';
import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/filter_bottom_sheet.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});



  // دالة لإظهار BottomSheet الفلاتر
  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  // دالة افتراضية لاستدعاء المنتجات من الـ API لاحقًا
  List<Map<String, dynamic>> _getMockProducts() {
    return List.generate(10, (index) {
      return {
        'id': 'prod_$index',
        'name': 'دواء تجريبي $index',
        'price': 100.0 + (index * 10),
        'inStock': index % 3 != 0,
        'rating': 4.5,
        'imageUrl': null, // لاحقًا يمكن ربط صورة المنتج من API
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = _getMockProducts();
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأدوية والمنتجات', style: TextStyle(fontWeight: FontWeight.bold)),
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
          childAspectRatio: 0.55,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            productName: product['name'],
            imageUrl: product['imageUrl'],
            price: product['price'],
            inStock: product['inStock'],
            rating: product['rating'],
            onTap: () => context.push('/shop/product/${product['id']}'),
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تمت الإضافة إلى السلة'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },// product:productitem,
          );
        },
      ),
    );
  }
}

 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// تأكد من صحة هذه المسارات حسب ترتيب المجلدات عندك
import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:dawaii/data/models/product.dart';

import '../widgets/filter_bottom_sheet.dart';

class ProductsListScreen extends StatelessWidget {
const ProductsListScreen({super.key});

// دالة لإظهار فلاتر البحث
void _showFilter(BuildContext context) {
showModalBottomSheet(
context: context,
isScrollControlled: true,
backgroundColor: Colors.transparent,
builder: (context) => const FilterBottomSheet(),
);
}


  List<Product> _getMockProducts() {
    return List.generate(10, (index) {
      return Product(
        id: 'prod_$index',
        itemName: 'دواء تجريبي $index', // المسمى الصحيح حسب موديلك
        price: 100.0 + (index * 10),
        stock: index % 3 == 0 ? 0 : 5, // تجربة حالة نفاد الكمية
        inStock: index % 3 != 0,
        imageUrl: 'https://via.placeholder.com/150',
      );
    });
  }

@override
Widget build(BuildContext context) {
final products = _getMockProducts();
const primaryColor = Color(0xFF2D6A4F);

return Scaffold(
appBar: AppBar(
title: const Text('الأدوية والمنتجات',
style: TextStyle(fontWeight: FontWeight.bold)),
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
childAspectRatio: 0.65, // تم ضبط النسبة لتناسب كرت المنتج الجديد ومنع الـ Overflow
crossAxisSpacing: 12,
mainAxisSpacing: 12,
),
itemCount: products.length,
itemBuilder: (context, index) {
final product = products[index];

return ProductCard(
product: product, // ✅ الآن نمرر كائن المنتج كاملاً (Entity)
onTap: () => context.push('/shop/product/${product.id}'),
onAddToCart: () {
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('تمت إضافة ${product.name} إلى السلة'),
behavior: SnackBarBehavior.floating,
backgroundColor: primaryColor,
),
);
},
);
},
),
);
}
}