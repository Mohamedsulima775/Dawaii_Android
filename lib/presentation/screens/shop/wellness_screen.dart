// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import 'product_card.dart';
//import '../../data/models/product.dart';
import '../../../data/models/category_item.dart';
import '../widgets/category_card.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessPageState();
}

class _WellnessPageState extends State<WellnessScreen> {
  final List<CategoryItem> _categories = [
    CategoryItem(id: 'vitamins', name: 'Vitamins', nameAr: 'الفيتامينات', icon: Icons.medication, color: Colors.orange),
    CategoryItem(id: 'skincare', name: 'Skin Care', nameAr: 'العناية بالبشرة', icon: Icons.spa, color: Colors.pink),
    CategoryItem(id: 'haircare', name: 'Hair Care', nameAr: 'العناية بالشعر', icon: Icons.face, color: Colors.purple),
    CategoryItem(id: 'fitness', name: 'Fitness', nameAr: 'اللياقة البدنية', icon: Icons.fitness_center, color: Colors.green),
  ];

  String _selectedCategoryId = 'vitamins';

  @override
  void initState() {
    super.initState();
    // جلب كل المنتجات عند فتح الشاشة
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('العافية والصحة', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),

          // قائمة الفئات
          Container(
            height: 155,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategoryId == category.id;

                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isSelected ? 1.0 : 0.5,
                    child: CategoryCard(
                      category: category,
                      onTap: () => setState(() => _selectedCategoryId = category.id),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // شبكة المنتجات
          Expanded(
            child: _buildProductsGrid(provider),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D6A4F), Color(0xFF52B788)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: const Center(
        child: Text(
          '  🌿     اكتشف أفضل منتجات العافية والعناية الذاتية',
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProductsGrid(ProductProvider provider) {
    // تصفية المنتجات حسب الفئة المختارة
    final products = provider.products.where((p) {
      return _selectedCategoryId == 'all' || p.category == _selectedCategoryId;
    }).toList();

    if (provider.isLoading && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () => context.push('/shop/product/${product.id}'),
          onAddToCart: product.isInStock
              ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تمت إضافة ${product.itemName} إلى السلة'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF2D6A4F),
              ),
            );
          }
              : () {}, // ✅ دالة فارغة
        );

      },
    );
  }
}


/*
// الاول

import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/data/models/product.dart';
import 'package:dawaii/data/models/category_item.dart';
import '../widgets/category_card.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessPageState();
}

class _WellnessPageState extends State<WellnessScreen> {
  final List<CategoryItem> _categories = [
    CategoryItem(id: 'vitamins', name: 'Vitamins', nameAr: 'الفيتامينات', icon: Icons.medication, color: Colors.orange),
    CategoryItem(id: 'skincare', name: 'Skin Care', nameAr: 'العناية بالبشرة', icon: Icons.spa, color: Colors.pink),
    CategoryItem(id: 'haircare', name: 'Hair Care', nameAr: 'العناية بالشعر', icon: Icons.face, color: Colors.purple),
    CategoryItem(id: 'fitness', name: 'Fitness', nameAr: 'اللياقة البدنية', icon: Icons.fitness_center, color: Colors.green),
  ];

  String _selectedCategoryId = 'vitamins';

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('العافية والصحة', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0, // جعل الـ AppBar مسطحاً ليندمج مع الـ Header
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 1. Header المميز الخاص بالصفحة
          _buildHeader(),

          // 2. قائمة الفئات الأفقية - تم تعديل الارتفاع هنا لحل مشكلة الـ Overflow
          Container(
            height: 155, // زيادة الارتفاع من 130 إلى 145 لضمان ظهور المربعات والنصوص
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategoryId == category.id;

                return Padding(
                  padding: const EdgeInsets.only(left: 15), // تعديل الـ padding لليمن/اليسار حسب الاتجاه
                  child: AnimatedOpacity( // استخدام تحريك سلس عند الاختيار
                    duration: const Duration(milliseconds: 300),
                    opacity: isSelected ? 1.0 : 0.5,
                    child: CategoryCard(
                      category: category,
                      onTap: () => setState(() => _selectedCategoryId = category.id),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // 3. قائمة المنتجات
          Expanded(
            child: _buildProductsGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D6A4F), Color(0xFF52B788)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      // تقليل الـ padding لتقليل المساحة الكلية للهيدر
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: const Center( // جعل النص في المنتصف ليعطي مظهراً أرشق
        child: Text(
          '  🌿     اكتشف أفضل منتجات العافية والعناية الذاتية',
          style: TextStyle(
              color: Colors.white, // تغيير اللون للأبيض الصافي ليكون أوضح بعد حذف العنوان الكبير
              fontSize: 14,
              fontWeight: FontWeight.w500
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    final List<Product> products = List.generate(6, (index) => Product(
      id: 'w_$index',
      itemName: 'منتج صحي $index',
      price: 45.0 + (index * 5),
      stock: 10,
      inStock: true,
      imageUrl: 'https://via.placeholder.com/150',
    ));

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => context.push('/shop/product/${products[index].id}'),
          onAddToCart: () {},
        );
      },
    );
  }
}

 */




