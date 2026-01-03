
/*
import 'package:flutter/material.dart';

// ============================================
// Wellness Page - صفحة العافية
// ============================================

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({Key? key}) : super(key: key);

  @override
  State<WellnessScreen> createState() => _WellnessPageState();
}

class _WellnessPageState extends State<WellnessScreen> {
  final List<WellnessCategory> _categories = [
    WellnessCategory(
      id: 'vitamins',
      name: 'الفيتامينات',
      //icon: Icons.vitamin,
      icon: Icons.spa,
      color: Colors.orange,
      itemCount: 45,
    ),
    WellnessCategory(
      id: 'skincare',
      name: 'العناية بالبشرة',
      icon: Icons.spa,
      color: Colors.pink,
      itemCount: 38,
    ),
    WellnessCategory(
      id: 'haircare',
      name: 'العناية بالشعر',
      icon: Icons.face,
      color: Colors.purple,
      itemCount: 29,
    ),
    WellnessCategory(
      id: 'fitness',
      name: 'اللياقة البدنية',
      icon: Icons.fitness_center,
      color: Colors.green,
      itemCount: 33,
    ),
    WellnessCategory(
      id: 'nutrition',
      name: 'التغذية',
      icon: Icons.restaurant,
      color: Colors.teal,
      itemCount: 52,
    ),
    WellnessCategory(
      id: 'mental',
      name: 'الصحة النفسية',
      icon: Icons.psychology,
      color: Colors.blue,
      itemCount: 18,
    ),
  ];

  String _selectedCategory = 'vitamins';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'العافية والصحة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2D6A4F),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterSheet(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with gradient
          _buildHeader(),

          // Categories
          _buildCategoriesSection(),

          // Products List
          Expanded(
            child: _buildProductsList(),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🌿 عش حياة صحية',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'اكتشف منتجات العافية والصحة',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category.id;

          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category.id),
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected ? category.color : category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: category.color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                          : [],
                    ),
                    child: Icon(
                      category.icon,
                      color: isSelected ? Colors.white : category.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF2D6A4F) : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final products = _getProductsForCategory(_selectedCategory);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(WellnessProduct product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showProductDetails(product),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  image: product.imageUrl != null
                      ? DecorationImage(
                    image: NetworkImage(product.imageUrl!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: product.imageUrl == null
                    ? Icon(Icons.image, color: Colors.grey[400], size: 40)
                    : null,
              ),
              const SizedBox(width: 12),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Description
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Benefits
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: product.benefits.take(2).map((benefit) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF52B788).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            benefit,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF2D6A4F),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),

                    // Price and Rating
                    Row(
                      children: [
                        Text(
                          '${product.price} ريال',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D6A4F),
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.star, color: Colors.amber[600], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProductDetails(WellnessProduct product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Image
                  if (product.imageUrl != null)
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),

                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < product.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber[600],
                          size: 20,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating} (${product.reviews} تقييم)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  const Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Benefits
                  const Text(
                    'الفوائد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...product.benefits.map((benefit) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF52B788),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              benefit,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),

                  // Usage
                  if (product.usage != null) ...[
                    const Text(
                      'طريقة الاستخدام',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.usage!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Price and Add to Cart
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'السعر',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${product.price} ريال',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D6A4F),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _addToCart(product),
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text(
                            'أضف للسلة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D6A4F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('بحث في منتجات العافية'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'ابحث عن منتج...',
            prefixIcon: Icon(Icons.search),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search
          },
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تصفية المنتجات',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.sort),
              title: const Text('الأعلى تقييماً'),
              onTap: () {
                Navigator.pop(context);
                // Implement filter
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('السعر: من الأقل للأعلى'),
              onTap: () {
                Navigator.pop(context);
                // Implement filter
              },
            ),
            ListTile(
              leading: const Icon(Icons.new_releases),
              title: const Text('الأحدث'),
              onTap: () {
                Navigator.pop(context);
                // Implement filter
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart(WellnessProduct product) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${product.name} للسلة'),
        backgroundColor: const Color(0xFF52B788),
        action: SnackBarAction(
          label: 'عرض السلة',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  List<WellnessProduct> _getProductsForCategory(String categoryId) {
    // Mock data - replace with API call
    return [
      WellnessProduct(
        id: '1',
        name: 'فيتامين د 5000 وحدة',
        description: 'مكمل فيتامين د عالي الجودة لدعم صحة العظام والمناعة',
        price: 89.99,
        rating: 4.5,
        reviews: 234,
        category: categoryId,
        benefits: [
          'يدعم صحة العظام والأسنان',
          'يعزز جهاز المناعة',
          'يحسن المزاج والطاقة',
        ],
        usage: 'كبسولة واحدة يومياً مع الطعام',
      ),
      WellnessProduct(
        id: '2',
        name: 'أوميغا 3 زيت السمك',
        description: 'زيت سمك نقي غني بأحماض EPA و DHA',
        price: 129.99,
        rating: 4.8,
        reviews: 456,
        category: categoryId,
        benefits: [
          'يدعم صحة القلب',
          'يحسن وظائف الدماغ',
          'مضاد للالتهابات',
        ],
        usage: 'كبسولتان يومياً مع الوجبات',
      ),
      WellnessProduct(
        id: '3',
        name: 'مالتي فيتامين كومبليت',
        description: 'تركيبة شاملة من الفيتامينات والمعادن',
        price: 149.99,
        rating: 4.6,
        reviews: 389,
        category: categoryId,
        benefits: [
          'يوفر التغذية اليومية الكاملة',
          'يعزز الطاقة والحيوية',
          'يدعم جميع وظائف الجسم',
        ],
        usage: 'قرص واحد يومياً مع الإفطار',
      ),
    ];
  }
}

// ============================================
// Models
// ============================================

class WellnessCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int itemCount;

  WellnessCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.itemCount,
  });
}

class WellnessProduct {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final int reviews;
  final String category;
  final List<String> benefits;
  final String? usage;
  final String? imageUrl;

  WellnessProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.category,
    required this.benefits,
    this.usage,
    this.imageUrl,
  });
}

 */

// المعتمد


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