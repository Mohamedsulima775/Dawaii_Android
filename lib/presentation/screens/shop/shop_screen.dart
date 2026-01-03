
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


/*
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    // قائمة الفئات الموحدة لتجنب أخطاء السطور 72-90
    final List<CategoryItem> categories = [
      CategoryItem(
        id: '1',
        name: 'Medications',
        nameAr: 'الأدوية',
        icon: Icons.medication_liquid,
        color: Colors.blue,
      ),
      CategoryItem(
        id: '2',
        name: 'Supplements',
        nameAr: 'المكملات',
        icon: Icons.favorite,
        color: Colors.red,
      ),
      CategoryItem(
        id: '3',
        name: 'Devices',
        nameAr: 'الأجهزة الطبية',
        icon: Icons.health_and_safety,
        color: Colors.orange,
      ),
      CategoryItem(
        id: '4',
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

            // 3. Horizontal Categories List - تم الإصلاح هنا
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

            // 5. Products Grid - تم الإصلاح هنا لتمرير كائن Product كامل
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
                    itemName: index == 0 ? 'Glucophage 500mg' : 'Panadol Advance', // الالتزام بـ itemName
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
                }


            ),
          ],
        ),
      ),
    );
  }
}

 */


/*
 //الاول

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:dawaii/data/models/product.dart';
import '../../../data/models/category_item.dart';
import '../widgets/category_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان الثابتة للتطبيق (يمكنك وضعها في ملف constants لاحقاً)
    const primaryColor = Color(0xFF2D6A4F);

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
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CategoryCard(
                    icon: Icons.medication_liquid,
                    label: 'Medications',
                    color: Colors.blue,
                    onTap: () => context.push('/shop/categories/chronic'),
                    category:, // القسم الذي طلبته
                  ),
                  CategoryCard(
                    icon: Icons.favorite,
                    label: 'Supplements',
                    color: Colors.red,
                    onTap: () => context.push('/shop/categories/supplements'),
                    category:,
                  ),
                  CategoryCard(
                    icon: Icons.health_and_safety,
                    label: 'Medical Devices',
                    color: Colors.orange,
                    onTap: () => context.push('/shop/categories/devices'),
                    category: null,
                  ),
                  CategoryCard(
                    icon: Icons.spa,
                    label: 'Wellness',
                    color: Colors.green,
                    onTap: () => context.push('/shop/categories/wellness'),
                    category: null,
                  ),
                ],
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
                childAspectRatio: 0.7, // تحسين النسبة لتناسب التصميم
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProductCard(
                  productName: index == 0 ?'Glucophage 500mg' : 'Panadol Advance',
                  price: 150.0 + (index * 10),
                  onTap: () => context.push('/shop/product/dummy_id_$index'),
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to Cart'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

 */

/*
// الكلاس المعدل ليدعم التفاعل والانتقال
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
            // أيقونة القسم بخلفية ملونة شفافة
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
            // اسم القسم
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




/*
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          IconButton(
            onPressed: () => context.push('/shop/cart'),
            icon: const Badge(
              label: Text('3'),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 12),

            // تم زيادة الارتفاع لـ 120 لمنع الـ Overflow في النص تحت الأيقونة
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  CategoryCard(icon: Icons.medication, label: 'Medications'),
                  CategoryCard(icon: Icons.favorite, label: 'Supplements'),
                  CategoryCard(icon: Icons.health_and_safety, label: 'Medical Devices'),
                  CategoryCard(icon: Icons.spa, label: 'Wellness'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Featured Products
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured Products',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => context.push('/shop/products'),
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // تم تعديل النسبة لـ 0.6 لمنع الـ Overflow داخل الكرت
                childAspectRatio: 0.6,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                // استخدام الـ Widget المنفصل مع المتغيرات الجديدة
                return ProductCard(
                  productName: 'Glucophage 500mg',
                  price: 150.0,
                  onTap: () => context.push('/shop/product/dummy_id'),
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to Cart')),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// قمت بجعله كلاس عام ليتم استخدامه بسهولة ولتنظيم الكود
class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90, // زيادة العرض قليلاً لتناسب النصوص الطويلة
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2D6A4F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF2D6A4F), size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

 */


/*
class _ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final VoidCallback onTap;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Center(
                child: Icon(Icons.medication, size: 60, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('SAR ${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Color(0xFF2D6A4F),
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text('Add to Cart', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */


