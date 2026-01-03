
/*
import 'package:flutter/material.dart';

// ============================================
// Medical Devices Page - صفحة الأجهزة الطبية
// ============================================

class MedicalDevicesScreen extends StatefulWidget {
  const MedicalDevicesScreen({Key? key}) : super(key: key);

  @override
  State<MedicalDevicesScreen> createState() => _MedicalDevicesPageState();
}

class _MedicalDevicesPageState extends State<MedicalDevicesScreen> {
  String _selectedCategory = 'all';
  String _sortBy = 'popular';
  bool _isLoading = false;

  final List<DeviceCategory> _categories = [
    DeviceCategory(
      id: 'all',
      name: 'الكل',
      icon: Icons.apps,
      color: Colors.grey[700]!,
    ),
    DeviceCategory(
      id: 'monitoring',
      name: 'أجهزة القياس',
      icon: Icons.monitor_heart,
      color: const Color(0xFFE74C3C),
    ),
    DeviceCategory(
      id: 'therapeutic',
      name: 'أجهزة علاجية',
      icon: Icons.healing,
      color: const Color(0xFF3498DB),
    ),
    DeviceCategory(
      id: 'diagnostic',
      name: 'أجهزة تشخيصية',
      icon: Icons.medical_services,
      color: const Color(0xFF9B59B6),
    ),
    DeviceCategory(
      id: 'mobility',
      name: 'أدوات مساعدة',
      icon: Icons.accessible,
      color: const Color(0xFF16A085),
    ),
    DeviceCategory(
      id: 'respiratory',
      name: 'تنفسية',
      icon: Icons.air,
      color: const Color(0xFFF39C12),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'الأجهزة الطبية',
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
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              setState(() => _sortBy = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'popular', child: Text('الأكثر شعبية')),
              const PopupMenuItem(value: 'price_low', child: Text('السعر: الأقل')),
              const PopupMenuItem(value: 'price_high', child: Text('السعر: الأعلى')),
              const PopupMenuItem(value: 'rating', child: Text('التقييم')),
              const PopupMenuItem(value: 'newest', child: Text('الأحدث')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Info Banner
          _buildInfoBanner(),

          // Categories Chips
          _buildCategoriesChips(),

          // Products Grid
          Expanded(
            child: _buildProductsGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showFilterDialog,
        backgroundColor: const Color(0xFF2D6A4F),
        icon: const Icon(Icons.tune),
        label: const Text('تصفية'),
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2D6A4F), Color(0xFF52B788)],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'جميع الأجهزة معتمدة من هيئة الغذاء والدواء',
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesChips() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category.id;

          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category.icon,
                    size: 18,
                    color: isSelected ? Colors.white : category.color,
                  ),
                  const SizedBox(width: 6),
                  Text(category.name),
                ],
              ),
              onSelected: (selected) {
                setState(() => _selectedCategory = category.id);
              },
              backgroundColor: Colors.grey[100],
              selectedColor: category.color,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsGrid() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final devices = _getDevicesForCategory(_selectedCategory);

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
        return _buildDeviceCard(devices[index]);
      },
    );
  }

  Widget _buildDeviceCard(MedicalDevice device) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showDeviceDetails(device),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: device.imageUrl != null
                          ? Image.network(
                        device.imageUrl!,
                        fit: BoxFit.contain,
                      )
                          : Icon(Icons.medical_services, size: 70, color: Colors.grey[300]),
                    ),

                    // FDA Approved Badge
                    if (device.isFdaApproved)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'معتمد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Discount Badge
                    if (device.discount != null && device.discount! > 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '-${device.discount}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Device Info
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand
                    Text(
                      device.brand,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Name
                    Text(
                      device.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          device.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${device.reviews})',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Price
                    Row(
                      children: [
                        if (device.discount != null && device.discount! > 0) ...[
                          Text(
                            '${device.originalPrice} ر.س',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          '${device.price} ر.س',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D6A4F),
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

  void _showDeviceDetails(MedicalDevice device) {
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
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[50],
                    child: device.imageUrl != null
                        ? Image.network(device.imageUrl!, fit: BoxFit.contain)
                        : Icon(Icons.medical_services, size: 120, color: Colors.grey[300]),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand and FDA Badge
                        Row(
                          children: [
                            Text(
                              device.brand,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (device.isFdaApproved)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.verified, color: Colors.green, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      'معتمد FDA',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Name
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Rating
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < device.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 22,
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '${device.rating} (${device.reviews} تقييم)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

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
                          device.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Features
                        const Text(
                          'المميزات',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...device.features.map((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF52B788).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color(0xFF2D6A4F),
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 20),

                        // Specifications
                        const Text(
                          'المواصفات التقنية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            children: device.specifications.entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        entry.value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Usage Instructions
                        const Text(
                          'طريقة الاستخدام',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          device.usage,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Warranty
                        if (device.warranty != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.shield, color: Colors.blue[700], size: 24),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'الضمان',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        device.warranty!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),

                        // Price and Purchase Button
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (device.discount != null && device.discount! > 0) ...[
                                  Text(
                                    '${device.originalPrice} ر.س',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[500],
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                                Text(
                                  '${device.price} ر.س',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2D6A4F),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _purchaseDevice(device),
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text(
                                  'اشترِ الآن',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2D6A4F),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
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
        title: const Text('بحث عن جهاز'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'اسم الجهاز أو رقم الموديل',
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

  void _showFilterDialog() {
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
              'تصفية حسب',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.verified),
              title: const Text('معتمد من FDA فقط'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Implement filter
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('العروض الخاصة'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Implement filter
                },
              ),
            ),
            const Divider(),
            const Text(
              'نطاق السعر',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            RangeSlider(
              values: const RangeValues(0, 5000),
              min: 0,
              max: 10000,
              divisions: 100,
              labels: const RangeLabels('0', '5000'),
              onChanged: (values) {
                // Implement price filter
              },
            ),
          ],
        ),
      ),
    );
  }

  void _purchaseDevice(MedicalDevice device) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تمت إضافة ${device.name} للسلة'),
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

  List<MedicalDevice> _getDevicesForCategory(String categoryId) {
    // Mock data - replace with API call
    return [
      MedicalDevice(
        id: '1',
        name: 'جهاز قياس السكر OneTouch',
        brand: 'OneTouch',
        description: 'جهاز قياس السكر الدقيق مع ذاكرة 500 قراءة',
        price: 299.99,
        rating: 4.8,
        reviews: 567,
        category: 'monitoring',
        isFdaApproved: true,
        features: [
          'دقة عالية في القياس',
          'ذاكرة تصل إلى 500 قراءة',
          'شاشة كبيرة سهلة القراءة',
          'نتائج خلال 5 ثوان',
          'حجم عينة صغير',
        ],
        specifications: {
          'وقت القياس': '5 ثوان',
          'حجم العينة': '0.4 ميكرولتر',
          'نطاق القياس': '20-600 مجم/ديسيلتر',
          'الذاكرة': '500 قراءة',
          'البطارية': 'ليثيوم 3 فولت',
          'الشاشة': 'LCD كبيرة',
        },
        usage: 'اغسل يديك جيداً، ضع شريط الاختبار، وخز الإصبع، ضع قطرة الدم على الشريط، انتظر 5 ثوان للنتيجة',
        warranty: 'ضمان 3 سنوات من الشركة المصنعة',
      ),
      MedicalDevice(
        id: '2',
        name: 'جهاز قياس الضغط الرقمي Omron',
        brand: 'Omron',
        description: 'جهاز قياس ضغط الدم الأوتوماتيكي للذراع',
        price: 449.99,
        rating: 4.9,
        reviews: 1234,
        category: 'monitoring',
        isFdaApproved: true,
        discount: 15,
        originalPrice: 529.99,
        features: [
          'قياس تلقائي بالكامل',
          'كشف عدم انتظام ضربات القلب',
          'ذاكرة لـ 60 قراءة',
          'مؤشر ضغط الدم العالي',
          'شهادة جمعية القلب الأمريكية',
        ],
        specifications: {
          'نطاق القياس': '0-299 ملم زئبق',
          'الدقة': '±3 ملم زئبق',
          'طريقة القياس': 'ذبذبات',
          'مقاس الكفة': '22-42 سم',
          'الذاكرة': '60 قراءة',
          'البطارية': '4 بطاريات AA',
        },
        usage: 'اجلس بهدوء لمدة 5 دقائق، ضع الكفة على الذراع الأيسر، اضغط زر البدء، انتظر النتيجة',
        warranty: 'ضمان 5 سنوات',
      ),
      MedicalDevice(
        id: '3',
        name: 'جهاز قياس الحرارة بالأشعة تحت الحمراء',
        brand: 'Braun',
        description: 'ترمومتر رقمي لقياس حرارة الجسم بدون لمس',
        price: 189.99,
        rating: 4.7,
        reviews: 892,
        category: 'monitoring',
        isFdaApproved: true,
        features: [
          'قياس بدون لمس (1-5 سم)',
          'نتيجة فورية خلال ثانية',
          'تنبيه الحمى بالألوان',
          'ذاكرة 32 قراءة',
          'وضع صامت',
        ],
        specifications: {
          'نطاق القياس': '34-43 درجة مئوية',
          'الدقة': '±0.2 درجة',
          'وقت القياس': '1 ثانية',
          'المسافة': '1-5 سم',
          'الذاكرة': '32 قراءة',
        },
        usage: 'وجّه الجهاز نحو الجبهة على مسافة 1-5 سم، اضغط الزر، اقرأ النتيجة',
        warranty: 'ضمان سنتين',
      ),
    ];
  }
}

// ============================================
// Models
// ============================================

class DeviceCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  DeviceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class MedicalDevice {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double? originalPrice;
  final int? discount;
  final double rating;
  final int reviews;
  final String category;
  final bool isFdaApproved;
  final List<String> features;
  final Map<String, String> specifications;
  final String usage;
  final String? warranty;
  final String? imageUrl;

  MedicalDevice({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    this.originalPrice,
    this.discount,
    required this.rating,
    required this.reviews,
    required this.category,
    this.isFdaApproved = false,
    required this.features,
    required this.specifications,
    required this.usage,
    this.warranty,
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
