
// lib/providers/category_provider.dart

import 'package:flutter/foundation.dart';

import '../../data/models/category_item.dart';
import '../../services/api_service.dart';

class CategoryProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // ===== State =====
  List<CategoryItem> _categories = [];
  CategoryItem? _selectedCategory;
  bool _isLoading = false;
  String? _error;

  // ===== Getters =====
  List<CategoryItem> get categories => _categories;
  CategoryItem? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ===== Categories by parent (subcategories) =====
  List<CategoryItem> getCategoriesByParent(String? parentId) {
    if (parentId == null) {
      return _categories.where((cat) => cat.parentCategory == null).toList();
    }
    return _categories.where((cat) => cat.parentCategory == parentId).toList();
  }

  // ===== Root categories (top-level) =====
  List<CategoryItem> get rootCategories {
    return _categories.where((cat) => cat.parentCategory == null).toList();
  }

  // ===== Fetch all categories from API =====
  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.product.get_categories',
      );

      if (response['message'] != null) {
        final List<dynamic> data = response['message'];
        _categories =
            data.map((json) => CategoryItem.fromJson(json)).toList();
      }
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching categories: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== Fetch category by ID =====
  Future<void> fetchCategoryById(String categoryId) async {
    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.product.get_category',
        params: {'category_id': categoryId},
      );

      if (response['message'] != null) {
        _selectedCategory = CategoryItem.fromJson(response['message']);
      }
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching category: $e');
    } finally {
      notifyListeners();
    }
  }

  // ===== Select / Clear category =====
  void selectCategory(CategoryItem category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCategory = null;
    notifyListeners();
  }

  // ===== Get category by ID =====
  CategoryItem? getCategoryById(String categoryId) {
    try {
      return _categories.firstWhere((cat) => cat.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  // ===== Subcategories =====
  List<CategoryItem> getSubcategories(String categoryId) {
    return _categories
        .where((cat) => cat.parentCategory == categoryId)
        .toList();
  }

  bool hasSubcategories(String categoryId) {
    return _categories.any((cat) => cat.parentCategory == categoryId);
  }

  // ===== Search categories =====
  List<CategoryItem> searchCategories(String query) {
    if (query.isEmpty) return _categories;

    final lowerQuery = query.toLowerCase();
    return _categories.where((category) {
      return category.name.toLowerCase().contains(lowerQuery) ||
          (category.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // ===== Get category path (breadcrumb) =====
  List<CategoryItem> getCategoryPath(String categoryId) {
    final path = <CategoryItem>[];
    CategoryItem? current = getCategoryById(categoryId);

    while (current != null) {
      path.insert(0, current);
      if (current.parentCategory != null) {
        current = getCategoryById(current.parentCategory!);
      } else {
        break;
      }
    }

    return path;
  }

  // ===== Clear error =====
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // ===== Reset provider =====
  void reset() {
    _categories = [];
    _selectedCategory = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}