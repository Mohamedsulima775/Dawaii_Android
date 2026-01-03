
/*
import 'package:flutter/material.dart';

import '../widgets/base_category_screen.dart';

class SupplementsScreen extends StatelessWidget {
  const SupplementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseCategoryScreen(
      title: 'Supplements',
      primaryColor: Colors.redAccent,
      items: [
        {'name': 'Vitamins', 'icon': Icons.wb_sunny_outlined, 'desc': 'Daily essentials'},
        {'name': 'Proteins', 'icon': Icons.fitness_center, 'desc': 'Muscle growth'},
        {'name': 'Minerals', 'icon': Icons.blur_on, 'desc': 'Body health'},
        {'name': 'Omega 3', 'icon': Icons.water_drop, 'desc': 'Heart & Brain'},
      ],
    );
  }
}

 */

/*
import 'package:flutter/material.dart';

// ============================================
// Supplements Page - صفحة المكملات الغذائية
// ============================================

class SupplementsScreen extends StatefulWidget {
  const SupplementsScreen({Key? key}) : super(key: key);

  @override
  State<SupplementsScreen> createState() => _SupplementsPageState();
}

class _SupplementsPageState extends State<SupplementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedGoal = 'all';
  bool _isLoading = false;

  final List<SupplementGoal> _goals = [
    SupplementGoal(id: 'all', name: 'الكل', icon: Icons.apps, color: Colors.grey),
    SupplementGoal(id: 'muscle', name: 'بناء العضلات', icon: Icons.fitness_center, color: Colors.red),
    SupplementGoal(id: 'energy', name: 'الطاقة', icon: Icons.bolt, color: Colors.orange),
    SupplementGoal(id: 'weight', name: 'إنقاص الوزن', icon: Icons.trending_down, color: Colors.green),
    SupplementGoal(id: 'immunity', name: 'المناعة', icon: Icons.shield, color: Colors.blue),
    SupplementGoal(id: 'recovery', name: 'التعافي', icon: Icons.healing, color: Colors.purple),
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFF2D6A4F),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'المكملات الغذائية',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B4332), Color(0xFF2D6A4F), Color(0xFF52B788)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        top: 30,
                        child: Icon(
                          Icons.fitness_center,
                          size: 200,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _showSearchDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    // Navigate to cart
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: const [
                  Tab(text: 'بروتين'),
                  Tab(text: 'فيتامينات'),
                  Tab(text: 'أمينو'),
                  Tab(text: 'أخرى'),
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            // Goals Filter
            _buildGoalsFilter(),

            // Products
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProductsTab('protein'),
                  _buildProductsTab('vitamins'),
                  _buildProductsTab('amino'),
                  _buildProductsTab('other'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalsFilter() {
    return Container(
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoal == goal.id;

          return GestureDetector(
            onTap: () => setState(() => _selectedGoal = goal.id),
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? goal.color : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? goal.color : Colors.grey[300]!,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    goal.icon,
                    color: isSelected ? Colors.white : goal.color,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    goal.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[700],
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

  Widget _buildProductsTab(String type) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final products = _getProductsForType(type);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(SupplementProduct product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showProductDetails(product),
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: product.imageUrl != null
                          ? Image.network(
                        product.imageUrl!,
                        fit: BoxFit.contain,
                      )
                          : Icon(Icons.image, size: 60, color: Colors.grey[400]),
                    ),

                    // Discount Badge
                    if (product.discount != null && product.discount! > 0)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${product.discount}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Favorite Button
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Product Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      product.brand,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Size
                    Text(
                      product.size,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Price and Rating
                    Row(
                      children: [
                        if (product.discount != null && product.discount! > 0) ...[
                          Text(
                            '${product.originalPrice} ر.س',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          '${product.price} ر.س',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D6A4F),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 2),
                            Text(
                              product.rating.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(SupplementProduct product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: product.imageUrl != null
                        ? Image.network(product.imageUrl!, fit: BoxFit.contain)
                        : Icon(Icons.image, size: 100, color: Colors.grey[400]),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand
                        Text(
                          product.brand,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Name
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Rating and Reviews
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < product.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
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
                          'الفوائد الرئيسية',
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

                        // Nutritional Info
                        const Text(
                          'المعلومات الغذائية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: product.nutritionalInfo.entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      entry.value,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Usage
                        const Text(
                          'طريقة الاستخدام',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.usage,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Price and Add to Cart
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product.discount != null && product.discount! > 0) ...[
                                  Text(
                                    '${product.originalPrice} ر.س',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                                Text(
                                  '${product.price} ر.س',
                                  style: const TextStyle(
                                    fontSize: 28,
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
        title: const Text('بحث عن مكمل'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'اسم المنتج أو العلامة التجارية',
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

  void _addToCart(SupplementProduct product) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${product.name} للسلة'),
        backgroundColor: const Color(0xFF52B788),
      ),
    );
  }

  List<SupplementProduct> _getProductsForType(String type) {
    // Mock data - replace with API call
    return [
      SupplementProduct(
        id: '1',
        name: 'واي بروتين جولد ستاندرد',
        brand: 'Optimum Nutrition',
        description: 'بروتين واي عالي الجودة مع أحماض أمينية كاملة',
        price: 299.99,
        originalPrice: 349.99,
        discount: 15,
        rating: 4.8,
        reviews: 1234,
        size: '2.27 كجم',
        benefits: [
          '24 جرام بروتين لكل حصة',
          '5.5 جرام أحماض أمينية BCAA',
          '4 جرام جلوتامين وحمض جلوتاميك',
          'سريع الامتصاص',
        ],
        nutritionalInfo: {
          'البروتين': '24 جم',
          'الكاربوهيدرات': '3 جم',
          'الدهون': '1 جم',
          'السعرات': '120 سعر',
        },
        usage: 'خلط مكيال واحد (30 جم) مع 200 مل من الماء أو الحليب. تناول مرة إلى مرتين يومياً',
        category: 'protein',
        isFavorite: false,
      ),
      SupplementProduct(
        id: '2',
        name: 'كرياتين مونوهيدرات',
        brand: 'MuscleTech',
        description: 'كرياتين نقي لزيادة القوة والحجم العضلي',
        price: 149.99,
        rating: 4.7,
        reviews: 892,
        size: '400 جرام',
        benefits: [
          'يزيد القوة والأداء',
          'يسرع التعافي العضلي',
          'يزيد الكتلة العضلية',
          '100% نقي',
        ],
        nutritionalInfo: {
          'الكرياتين': '5 جم',
          'السعرات': '0 سعر',
        },
        usage: 'ملعقة صغيرة (5 جم) يومياً مع الماء أو العصير',
        category: 'protein',
        isFavorite: true,
      ),
    ];
  }
}

// ============================================
// Models
// ============================================

class SupplementGoal {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  SupplementGoal({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class SupplementProduct {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double? originalPrice;
  final int? discount;
  final double rating;
  final int reviews;
  final String size;
  final List<String> benefits;
  final Map<String, String> nutritionalInfo;
  final String usage;
  final String category;
  final String? imageUrl;
  final bool isFavorite;

  SupplementProduct({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.rating,
    required this.reviews,
    required this.size,
    required this.benefits,
    required this.nutritionalInfo,
    required this.usage,
    required this.category,
    this.imageUrl,
    this.isFavorite = false,
  });
}

 */

// المعتمد

// المعتمد
/*
// المعتمد
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

  // توحيد الأهداف باستخدام CategoryItem
  final List<CategoryItem> _goals = [
    CategoryItem(id: 'all', name: 'All', nameAr: 'الكل', icon: Icons.apps, color: Colors.grey),
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
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('المكملات الغذائية', style: TextStyle(fontWeight: FontWeight.bold)),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1B4332), Color(0xFF2D6A4F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(Icons.fitness_center, size: 150, color: Colors.white.withOpacity(0.1)),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'بروتين'),
                  Tab(text: 'فيتامينات'),
                  Tab(text: 'أمينو'),
                  Tab(text: 'أخرى'),
                ],
              ),
            ),
          ];
        },
        body: Column(
          children: [
            // فلتر الأهداف (Goals)
            _buildGoalsFilter(),

            // عرض المنتجات بناءً على التبويب المختار
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
      ),
    );
  }

  Widget _buildGoalsFilter() {
    return Container(
      height: 90,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          final isSelected = _selectedGoalId == goal.id;

          return GestureDetector(
            onTap: () => setState(() => _selectedGoalId = goal.id),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? goal.color : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? goal.color : Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(goal.icon, color: isSelected ? Colors.white : goal.color, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    goal.nameAr ?? goal.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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

  Widget _buildProductsGrid(String type) {
    // توليد بيانات تجريبية تتوافق مع موديل Product الخاص بك
    final products = List.generate(4, (index) => Product(
      id: 'sup_${type}_$index',
      itemName: index == 0 ? 'Whey Protein Gold' : 'BCAA Energy',
      price: 250.0 + (index * 20),
      stock: 5,
      inStock: true,
      imageUrl: 'https://via.placeholder.com/150',
    ));

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () => context.push('/shop/product/${products[index].id}'),
          onAddToCart: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تمت الإضافة للسلة'), behavior: SnackBarBehavior.floating),
            );
          },
        );
      },
    );
  }
}

 */



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

