
/*
//category_screen

// lib/features/shop/presentation/pages/category_products_page.dart

import 'package:dawaii/presentation/screens/shop/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/product.dart';


class CategoryCard extends StatefulWidget {
  final String categoryName;
  final String? categoryNameAr;
  final IconData categoryIcon;
  final Color? categoryColor;

  const CategoryCard ({
    Key? key,
    required this.categoryName,
    this.categoryNameAr,
    required this.categoryIcon,
    this.categoryColor,
  }) : super(key: key);

  @override
  State<CategoryCard > createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryCard > {
  String _selectedFilter = 'All';
  String _sortBy = 'Name';

  String get id =>'productId';

  @override
  Widget build(BuildContext context) {
    // Mock products - Replace with API call
    final products = _getMockProducts(widget.categoryName);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.categoryNameAr ?? widget.categoryName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${products.length} منتج',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Open search
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Open cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Header
          _buildCategoryHeader(),

          // Filters Bar
          _buildFiltersBar(),

          // Products Grid
          Expanded(
            child: products.isEmpty
                ? _buildEmptyState()
                : _buildProductsGrid(products),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.categoryColor?.withOpacity(0.1) ??
                  Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              widget.categoryIcon,
              color: widget.categoryColor ?? Colors.blue,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.categoryNameAr ?? widget.categoryName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'أدوية وعلاجات متنوعة',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          // Filter Dropdown
          Expanded(
            child: _buildFilterButton(),
          ),
          const SizedBox(width: 12),
          // Sort Dropdown
          Expanded(
            child: _buildSortButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return PopupMenuButton<String>(
      initialValue: _selectedFilter,
      onSelected: (value) {
        setState(() => _selectedFilter = value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_list, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              'فلتر: $_selectedFilter',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'All', child: Text('الكل')),
        const PopupMenuItem(value: 'In Stock', child: Text('متوفر')),
        const PopupMenuItem(value: 'Out of Stock', child: Text('غير متوفر')),
        const PopupMenuItem(value: 'On Sale', child: Text('عروض')),
      ],
    );
  }

  Widget _buildSortButton() {
    return PopupMenuButton<String>(
      initialValue: _sortBy,
      onSelected: (value) {
        setState(() => _sortBy = value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sort, size: 18, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Text(
              'ترتيب: $_sortBy',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'Name', child: Text('الاسم')),
        const PopupMenuItem(value: 'Price: Low to High', child: Text('السعر: الأقل')),
        const PopupMenuItem(value: 'Price: High to Low', child: Text('السعر: الأعلى')),
        const PopupMenuItem(value: 'Newest', child: Text('الأحدث')),
      ],
    );
  }

  Widget _buildProductsGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        context.push(
          context as String,
          extra: MaterialPageRoute(
            builder: (context) =>ProductDetailScreen(productId:id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.medical_services,
                      size: 60,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                // Stock badge
                if (!product.inStock)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'غير متوفر',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.itemName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (product.itemName != null)
                      Text(
                        product.itemName!,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SAR ${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: product.inStock
                                ? Colors.teal
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد منتجات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'سيتم إضافة منتجات قريباً',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Mock data - Replace with API call
  List<Product> _getMockProducts(String category) {
    if (category == 'Diabetes') {
      return [
        Product(
          id: '1',
          name: 'Glucophage 500mg',
          itemName: 'Metformin',
          price: 150.00,
          stock: 1,
          description: 'دواء لعلاج السكري من النوع الثاني',
          category: 'Diabetes',
        ),
        Product(
          id: '2',
          name: 'Januvia 100mg',
          itemName: 'Sitagliptin',
          price: 320.00,
          stock: 1,
          description: 'علاج السكري من النوع الثاني',
          category: 'Diabetes',
        ),
        Product(
          id: '3',
          name: 'Insulin Pen',
          itemName: 'NovoRapid',
          price: 280.00,
          stock: 1,
          description: 'قلم الأنسولين سريع المفعول',
          category: 'Diabetes',
        ),
        Product(
          id: '4',
          name: 'Glucose Meter',
          price: 120.00,
          stock: 1,
          description: 'جهاز قياس السكر',
          category: 'Diabetes', itemName: '',
        ),
      ];
    } else if (category == 'Hypertension') {
      return [
        Product(
          id: '5',
          name: 'Concor 5mg',
          itemName: 'Bisoprolol',
          price: 85.00,
          stock:1,
          description: 'علاج ضغط الدم المرتفع',
          category: 'Hypertension',
        ),
        Product(
          id: '6',
          name: 'Norvasc 10mg',
          itemName: 'Amlodipine',
          price: 95.00,
          stock: 1,
          description: 'خافض ضغط الدم',
          category: 'Hypertension',
        ),
      ];
    } else if (category == 'Supplements') {
      return [
        Product(
          id: '7',
          name: 'Vitamin D3 5000 IU',
          price: 65.00,
          stock: 1,
          description: 'مكمل فيتامين د',
          category: 'Supplements', itemName: '',
        ),
        Product(
          id: '8',
          name: 'Omega-3 Fish Oil',
          price: 120.00,
          stock: 1,
          description: 'زيت السمك أوميغا 3',
          category: 'Supplements', itemName: '',
        ),
      ];
    }

    return [];
  }
}

 */

/*
// Product Model
class Product {
  final String id;
  final String name;
  final String? scientificName;
  final double price;
  final bool inStock;
  final String? description;
  final String category;
  final String? imageUrl;

  Product({
    required this.id,
    required this.name,
    this.scientificName,
    required this.price,
    required this.inStock,
    this.description,
    required this.category,
    this.imageUrl,
  });

 */


/*
import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/category_item.dart';
import '../../../data/models/product.dart';
import '../widgets/category_card.dart';
//import '../shop/product_card.dart';



class BaseCategoryScreen extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final List<CategoryItem>? categories;
  final List<Product>? products;

  const BaseCategoryScreen({
    super.key,
    required this.title,
    required this.primaryColor,
    this.categories,
    this.products,
  }) : assert(categories != null || products != null, 'يجب تمرير Categories أو Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: categories != null
            ? GridView.builder(
          itemCount: categories!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.85),
          itemBuilder: (context, index) {
            final category = categories![index];
            return CategoryCard(
              category: category,
              onTap: () {
                // Navigate to products page or API data
              },
            );
          },
        )
            : GridView.builder(
          itemCount: products!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.68),
          itemBuilder: (context, index) {
            final product = products![index];
            return ProductCard(
              product: product,
              onTap: () {},
              onAddToCart: () {},
            );
          },
        ),
      ),
    );
  }
}

 */

// lib/presentation/screens/shop/base_category_screen.dart

import 'package:dawaii/presentation/screens/shop/product_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/category_item.dart';
import '../../../data/models/product.dart';
import '../widgets/category_card.dart';

class BaseCategoryScreen extends StatelessWidget {
  final String title;
  final List<CategoryItem>? categories;
  final List<Product>? products;

  const BaseCategoryScreen({
    super.key,
    required this.title,
    this.categories,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        // إذا كانت هناك فئات، استخدم تصميمها، وإذا كانت منتجات استخدم تصميمها
        itemCount: categories?.length ?? products?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: categories != null ? 0.85 : 0.65, // تغيير النسبة حسب المحتوى
        ),
        itemBuilder: (context, index) {
          if (categories != null) {
            return CategoryCard(
              category: categories![index],
              onTap: () { /* انتقال لقسم المنتجات */ },
            );
          } else {
            return ProductCard(
              product: products![index],
              onTap: () { /* انتقال لتفاصيل المنتج */ },
              onAddToCart: () { /* إضافة للسلة */ },
            );
          }
        },
      ),
    );
  }
}
