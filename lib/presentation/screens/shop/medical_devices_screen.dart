
// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/category_item.dart';
import '../../providers/product_provider.dart';
import 'product_card.dart';


class MedicalDevicesScreen extends StatefulWidget {
  const MedicalDevicesScreen({super.key});

  @override
  State<MedicalDevicesScreen> createState() => _MedicalDevicesPageState();
}

class _MedicalDevicesPageState extends State<MedicalDevicesScreen> {
  String _selectedCategoryId = 'all';

  final List<CategoryItem> _categories = [
    CategoryItem(id: 'all', name: 'All', nameAr: 'الكل', icon: Icons.apps, color: Colors.grey),
    CategoryItem(id: 'monitoring', name: 'Monitoring', nameAr: 'أجهزة القياس', icon: Icons.monitor_heart, color: const Color(0xFFE74C3C)),
    CategoryItem(id: 'respiratory', name: 'Respiratory', nameAr: 'تنفسية', icon: Icons.air, color: const Color(0xFFF39C12)),
    CategoryItem(id: 'mobility', name: 'Mobility', nameAr: 'أدوات مساعدة', icon: Icons.accessible, color: const Color(0xFF16A085)),
  ];

  @override
  void initState() {
    super.initState();
    // جلب جميع الأجهزة عند فتح الصفحة
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    const primaryColor = Color(0xFF2D6A4F);

    // تصفية الأجهزة حسب الفئة المحددة
    final devices = _selectedCategoryId == 'all'
        ? provider.products
        : provider.products
        .where((p) => p.category == _selectedCategoryId)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('الأجهزة الطبية', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 1. Info Banner
          _buildInfoBanner(),

          // 2. Categories Chips
          _buildCategoriesBar(),

          // 3. Devices Grid
          Expanded(
            child: provider.isLoading && devices.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : provider.error != null
                ? Center(child: Text(provider.error!))
                : _buildDevicesGrid(devices),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF52B788).withOpacity(0.1),
      child: const Row(
        children: [
          Icon(Icons.verified_user, color: Color(0xFF2D6A4F), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'جميع الأجهزة معتمدة طبياً وضمن الضمان',
              style: TextStyle(color: Color(0xFF1B4332), fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategoryId == cat.id;
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(cat.nameAr ?? cat.name),
              onSelected: (_) => setState(() => _selectedCategoryId = cat.id),
              selectedColor: cat.color.withOpacity(0.2),
              checkmarkColor: cat.color,
              labelStyle: TextStyle(
                color: isSelected ? cat.color : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDevicesGrid(List devices) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return ProductCard(
          product: device,
          onTap: () => context.push('/shop/product/${device.id}'),
          onAddToCart: device.isInStock
              ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تمت إضافة ${device.itemName} إلى السلة'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: const Color(0xFF2D6A4F),
              ),
            );
          }
              : () {},
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


class MedicalDevicesScreen extends StatefulWidget {
  const MedicalDevicesScreen({super.key});

  @override
  State<MedicalDevicesScreen> createState() => _MedicalDevicesPageState();
}

class _MedicalDevicesPageState extends State<MedicalDevicesScreen> {
  String _selectedCategoryId = 'all';

  // استخدام CategoryItem الموحد للفئات
  final List<CategoryItem> _categories = [
    CategoryItem(id: 'all', name: 'All', nameAr: 'الكل', icon: Icons.apps, color: Colors.grey),
    CategoryItem(id: 'monitoring', name: 'Monitoring', nameAr: 'أجهزة القياس', icon: Icons.monitor_heart, color: const Color(0xFFE74C3C)),
    CategoryItem(id: 'respiratory', name: 'Respiratory', nameAr: 'تنفسية', icon: Icons.air, color: const Color(0xFFF39C12)),
    CategoryItem(id: 'mobility', name: 'Mobility', nameAr: 'أدوات مساعدة', icon: Icons.accessible, color: const Color(0xFF16A085)),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('الأجهزة الطبية', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 1. شريط المعلومات (Info Banner)
          _buildInfoBanner(),

          // 2. فلاتر الفئات (Chips) باستخدام بيانات CategoryItem
          _buildCategoriesBar(),

          // 3. شبكة المنتجات (Devices Grid) باستخدام ProductCard الموحد
          Expanded(
            child: _buildDevicesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF52B788).withOpacity(0.1),
      child: const Row(
        children: [
          Icon(Icons.verified_user, color: Color(0xFF2D6A4F), size: 20),
          SizedBox(width: 10),
          Text(
            'جميع الأجهزة معتمدة طبياً وضمن الضمان',
            style: TextStyle(color: Color(0xFF1B4332), fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategoryId == cat.id;
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              selected: isSelected,
              label: Text(cat.nameAr ?? cat.name),
              onSelected: (_) => setState(() => _selectedCategoryId = cat.id),
              selectedColor: cat.color.withOpacity(0.2),
              checkmarkColor: cat.color,
              labelStyle: TextStyle(color: isSelected ? cat.color : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDevicesGrid() {
    // بيانات تجريبية متوافقة مع موديل Product الخاص بك
    final devices = List.generate(4, (index) => Product(
      id: 'dev_$index',
      itemName: index == 0 ? 'جهاز قياس الضغط Omron' : 'ترمومتر Braun',
      price: 150.0 + (index * 50),
      stock: 15,
      inStock: true,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4.8,
    ));

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65, // متناسق مع ProductCard
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: devices.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: devices[index],
          onTap: () => context.push('/shop/product/${devices[index].id}'),
          onAddToCart: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تمت إضافة الجهاز للسلة'), behavior: SnackBarBehavior.floating),
            );
          },
        );
      },
    );
  }
}

 */
