
// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category_item.dart';
import '../../providers/product_provider.dart';
import 'product_card.dart';
import '../widgets/category_card.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // جلب المنتجات المميزة عند فتح الصفحة
    Future.microtask(() =>
        context.read<ProductProvider>().fetchFeaturedProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCategories(String categoryId) {
    context.push('/shop/categories/$categoryId');
  }

  void _seeAllProducts() {
    context.push('/shop/products');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final products = provider.products;
    const primaryColor = Color(0xFF2D6A4F);

    final List<CategoryItem> categories = [
      CategoryItem(
        id: 'chronic',
        name: 'Medications',
        nameAr: 'الأدوية',
        icon: Icons.medication_liquid,
        color: Colors.blue,
      ),
      CategoryItem(
        id: 'supplements',
        name: 'Supplements',
        nameAr: 'المكملات',
        icon: Icons.favorite,
        color: Colors.red,
      ),
      CategoryItem(
        id: 'devices',
        name: 'Devices',
        nameAr: 'الأجهزة الطبية',
        icon: Icons.health_and_safety,
        color: Colors.orange,
      ),
      CategoryItem(
        id: 'wellness',
        name: 'Wellness',
        nameAr: 'العناية بالذات',
        icon: Icons.spa,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => context.push('/shop/cart'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => provider.filterProducts(value),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: const Icon(Icons.search, color: primaryColor),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 2. Categories Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // 3. Horizontal Categories List
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 100,
                      child: CategoryCard(
                        category: categories[index],
                        onTap: () => _showCategories(categories[index].id),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 4. Featured Products Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _seeAllProducts,
                    child: const Text(
                      'See All',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            // 5. Products Grid
            provider.isLoading && products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : provider.error != null
                ? Center(child: Text(provider.error!))
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () =>
                      context.push('/shop/product/${product.id}'),
                  onAddToCart: product.isInStock
                      ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'تمت إضافة ${product.itemName} إلى السلة'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: primaryColor,
                      ),
                    );
                  }
                      : () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*
// الاول
//shop_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/shop/product_card.dart';
import '../widgets/category_card.dart';
import 'package:dawaii/data/models/product.dart';
import 'package:dawaii/data/models/category_item.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    // تم تعديل الـ ID هنا ليتطابق مع الكلمات الموجودة في ملف الـ router
    final List<CategoryItem> categories = [
      CategoryItem(
        id: 'chronic', // يطابق مسار /shop/categories/chronic
        name: 'Medications',
        nameAr: 'الأدوية',
        icon: Icons.medication_liquid,
        color: Colors.blue,
      ),
      CategoryItem(
        id: 'supplements', // يطابق مسار /shop/categories/supplements
        name: 'Supplements',
        nameAr: 'المكملات',
        icon: Icons.favorite,
        color: Colors.red,
      ),
      CategoryItem(
        id: 'devices', // يطابق مسار /shop/categories/devices
        name: 'Devices',
        nameAr: 'الأجهزة الطبية',
        icon: Icons.health_and_safety,
        color: Colors.orange,
      ),
      CategoryItem(
        id: 'wellness', // يطابق مسار /shop/categories/wellness
        name: 'Wellness',
        nameAr: 'العناية بالذات',
        icon: Icons.spa,
        color: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => context.push('/shop/cart'),
            icon: const Badge(
              label: Text('3'),
              backgroundColor: Colors.red,
              child: Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: const Icon(Icons.search, color: primaryColor),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // 2. Categories Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // 3. Horizontal Categories List
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 100,
                      child: CategoryCard(
                        category: categories[index],
                        // الآن عند الضغط سيرسل كلمة (chronic أو supplements) بدلاً من رقم
                        onTap: () => context.push('/shop/categories/${categories[index].id}'),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 4. Featured Products Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => context.push('/shop/products'),
                    child: const Text('See All', style: TextStyle(color: primaryColor)),
                  ),
                ],
              ),
            ),

            // 5. Products Grid
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final product = Product(
                    id: 'id_$index',
                    itemName: index == 0 ? 'Glucophage 500mg' : 'Panadol Advance',
                    price: 150.0 + (index * 10),
                    stock: 10,
                    inStock: true,
                    imageUrl: 'https://via.placeholder.com/150',
                  );

                  return ProductCard(
                    product: product,
                    onTap: () => context.push('/shop/product/${product.id}'),
                    onAddToCart: () {},
                  );
                }),
          ],
        ),
      ),
    );
  }
}

 */




