
// ============================================
// lib/models/brand.dart
// ============================================

class Brand {
  final String id;
  final String name;
  final String? logo;        // قد يأتي تحت مسمى image أو logo في الـ API
  final String? description;
  final bool isPopular;      // مطلوب في getter popularBrands
  final bool isFeatured;     // مطلوب في getter featuredBrands
  final String? website;
  final int? productCount;   // مفيد لعرض عدد المنتجات التابعة للماركة

  Brand({
    required this.id,
    required this.name,
    this.logo,
    this.description,
    this.isPopular = false,
    this.isFeatured = false,
    this.website,
    this.productCount,
  });

  /// ===============================
  /// From JSON
  /// ===============================
  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      // ملاحظة: ERPNext أحياناً يستخدم 'name' كـ ID فريد للحقول
      id: json['name'] ?? json['id'] ?? '',
      name: json['brand_name'] ?? json['name'] ?? 'Unknown Brand',
      logo: json['image'] ?? json['logo'],
      description: json['description'],
      // التأكد من تحويل القيم القادمة من API (سواء كانت 1/0 أو true/false)
      isPopular: json['is_popular'] == 1 || json['is_popular'] == true,
      isFeatured: json['is_featured'] == 1 || json['is_featured'] == true,
      website: json['website'],
      productCount: json['product_count'],
    );
  }

  /// ===============================
  /// To JSON
  /// ===============================
  Map<String, dynamic> toJson() {
    return {
      'name': id,
      'brand_name': name,
      'image': logo,
      'description': description,
      'is_popular': isPopular,
      'is_featured': isFeatured,
      'website': website,
      'product_count': productCount,
    };
  }
}
