

// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import 'product_card.dart';
import '../widgets/filter_bottom_sheet.dart';

class ProductsListScreen extends StatelessWidget {
  const ProductsListScreen({super.key});

  // دالة فتح فلاتر البحث
  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.products;
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأدوية والمنتجات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      body: provider.isLoading && products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.error != null
          ? Center(child: Text(provider.error!))
          : products.isEmpty
          ? const Center(child: Text('لا توجد منتجات'))
          : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () => context
                .push('/shop/product/${product.id}'), // التنقل للـ Details
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'تمت إضافة ${product.itemName} إلى السلة'),
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


/*
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
  content: Text('تمت إضافة ${product.itemName} إلى السلة'),

//content: Text('تمت إضافة ${product.name} إلى السلة'),
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

 */



