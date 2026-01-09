
// ============================================
// lib/data/models/banner_model.dart
// ============================================

class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? link;
  final bool isActive;
  final int? sortOrder;
  final DateTime? startDate;
  final DateTime? endDate;

  // الحقول المفقودة التي يطلبها الـ Provider
  final int priority;
  final String type;
  final String? category;
  final bool isFeatured;
  final String? actionType;
  final String? actionValue;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.link,
    required this.isActive,
    this.sortOrder,
    this.startDate,
    this.endDate,
    // إضافة الحقول في الـ Constructor
    this.priority = 0,
    this.type = 'general',
    this.category,
    this.isFeatured = false,
    this.actionType,
    this.actionValue,
  });

  /// ===============================
  /// From JSON
  /// ===============================
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['name'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? json['image_url'] ?? '',
      link: json['link'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      sortOrder: json['sort_order'],
      startDate: json['start_date'] != null ? DateTime.tryParse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.tryParse(json['end_date']) : null,

      // تعبئة البيانات الجديدة من الـ JSON
      priority: json['priority'] ?? 0,
      type: json['type'] ?? 'general',
      category: json['category'],
      isFeatured: json['is_featured'] == 1 || json['is_featured'] == true,
      actionType: json['action_type'],
      actionValue: json['action_value'],
    );
  }

  /// ===============================
  /// To JSON (لو احتجته لاحقًا)
  /// ===============================
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': imageUrl,
      'link': link,
      'is_active': isActive,
      'sort_order': sortOrder,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'priority': priority,
      'type': type,
      'category': category,
      'is_featured': isFeatured,
      'action_type': actionType,
      'action_value': actionValue,
    };
  }

  /// ===============================
  /// Helpers
  /// ===============================
  bool get isValid {
    final now = DateTime.now();
    if (!isActive) return false;
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    return true;
  }
}