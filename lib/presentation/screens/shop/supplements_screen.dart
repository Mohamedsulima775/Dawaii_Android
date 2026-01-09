// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/category_item.dart';
import '../../../data/models/product.dart';
import '../../providers/product_provider.dart';
import 'product_card.dart';


class SupplementsScreen extends StatefulWidget {
  const SupplementsScreen({super.key});

  @override
  State<SupplementsScreen> createState() => _SupplementsPageState();
}

class _SupplementsPageState extends State<SupplementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedGoalId = 'all';

  final List<CategoryItem> _goals = [
    CategoryItem(id: 'all', name: 'All', nameAr: 'الكل', icon: Icons.grid_view, color: Colors.grey),
    CategoryItem(id: 'muscle', name: 'Muscle', nameAr: 'بناء العضلات', icon: Icons.fitness_center, color: Colors.red),
    CategoryItem(id: 'energy', name: 'Energy', nameAr: 'الطاقة', icon: Icons.bolt, color: Colors.orange),
    CategoryItem(id: 'weight', name: 'Weight', nameAr: 'إنقاص الوزن', icon: Icons.trending_down, color: Colors.green),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // جلب المنتجات عند فتح الشاشة
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('المكملات الغذائية', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // TabBar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'بروتين'),
                Tab(text: 'فيتامينات'),
                Tab(text: 'أمينو'),
                Tab(text: 'أخرى'),
              ],
            ),
          ),

          // Goals Filter
          _buildGoalsFilter(),

          // Products Grid
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsGrid(provider, 'protein'),
                _buildProductsGrid(provider, 'vitamins'),
                _buildProductsGrid(provider, 'amino'),
                _buildProductsGrid(provider, 'other'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsFilter() {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoalId == goal.id;
          return GestureDetector(
            onTap: () => setState(() => _selectedGoalId = goal.id),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[600] : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isSelected ? Colors.grey[600]! : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(goal.icon, color: isSelected ? Colors.white : Colors.red[400], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    goal.nameAr ?? goal.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid(ProductProvider provider, String type) {
    // تصفية حسب النوع والفئة المختارة
    final List<Product> products = provider.products.where((p) {
      final matchesType = p.category == type || type == 'other';
      final matchesGoal = _selectedGoalId == 'all' || p.category == _selectedGoalId;
      return matchesType && matchesGoal;
    }).toList();

    if (provider.isLoading && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
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
              : () {}, // ✅ دالة فارغة بدل null
        );

      },
    );
  }
}



/*
//الاولة

import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/data/models/product.dart';
import 'package:dawaii/data/models/category_item.dart';

class SupplementsScreen extends StatefulWidget {
  const SupplementsScreen({super.key});

  @override
  State<SupplementsScreen> createState() => _SupplementsPageState();
}

class _SupplementsPageState extends State<SupplementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedGoalId = 'all';

  // قائمة الأهداف الفرعية (بناء العضلات، الطاقة...)
  final List<CategoryItem> _goals = [
    CategoryItem(id: 'all', name: 'All', nameAr: 'الكل', icon: Icons.grid_view, color: Colors.grey),
    CategoryItem(id: 'muscle', name: 'Muscle', nameAr: 'بناء العضلات', icon: Icons.fitness_center, color: Colors.red),
    CategoryItem(id: 'energy', name: 'Energy', nameAr: 'الطاقة', icon: Icons.bolt, color: Colors.orange),
    CategoryItem(id: 'weight', name: 'Weight', nameAr: 'إنقاص الوزن', icon: Icons.trending_down, color: Colors.green),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      backgroundColor: Colors.grey[50], // خلفية الصفحة رمادي خفيف جداً
      appBar: AppBar(
        title: const Text('المكملات الغذائية', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. شريط الـ TabBar المستقل تماماً (خارج الـ AppBar)
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // لون خلفية أبيض ليفصله عن الـ AppBar الأخضر
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4), // ظل ليعطي إحساس بالانفصال
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelColor: primaryColor, // لون النص المختار
              unselectedLabelColor: Colors.grey[600], // لون النص غير المختار
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: 'بروتين'),
                Tab(text: 'فيتامينات'),
                Tab(text: 'أمينو'),
                Tab(text: 'أخرى'),
              ],
            ),
          ),

          // 2. شريط الأهداف (الذي يحتوي على الكل، بناء العضلات...)
          _buildGoalsFilter(),

          // 3. عرض المنتجات (يتأثر بالـ TabBar)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductsGrid('protein'),
                _buildProductsGrid('vitamins'),
                _buildProductsGrid('amino'),
                _buildProductsGrid('other'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت شريط الأهداف الأفقي
  Widget _buildGoalsFilter() {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoalId == goal.id;

          return GestureDetector(
            onTap: () => setState(() => _selectedGoalId = goal.id),
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                // لون رمادي غامق عند الاختيار كما في الصورة المطلوبة
                color: isSelected ? Colors.grey[600] : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? Colors.grey[600]! : Colors.grey[300]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                      goal.icon,
                      color: isSelected ? Colors.white : Colors.red[400],
                      size: 20
                  ),
                  const SizedBox(width: 8),
                  Text(
                    goal.nameAr ?? goal.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ويدجت شبكة المنتجات
  Widget _buildProductsGrid(String type) {
    // محاكاة لبيانات المنتجات بناءً على الموديل الخاص بك
    final List<Product> products = List.generate(4, (index) => Product(
      id: 'sup_${type}_$index',
      itemName: index % 2 == 0 ? 'Whey Protein Gold' : 'Omega 3 Vitamins',
      price: 150.0 + (index * 25),
      stock: 10,
      inStock: true,
      imageUrl: 'https://via.placeholder.com/150',
    ));

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // نسبة العرض للطول للكرت
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => context.push('/shop/product/${products[index].id}'),
          onAddToCart: () {
            // منطق إضافة للسلة
          },
        );
      },
    );
  }
}

 */




