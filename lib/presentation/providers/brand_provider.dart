
// lib/providers/brand_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/brand.dart';
import '../../services/api_service.dart';


class BrandProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State
  List<Brand> _brands = [];
  Brand? _selectedBrand;
  bool _isLoading = false;
  String? _error;

  // Getters
  List<Brand> get brands => _brands;
  Brand? get selectedBrand => _selectedBrand;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get popular brands
  List<Brand> get popularBrands {
    return _brands.where((brand) => brand.isPopular == true).toList();
  }

  // Get featured brands
  List<Brand> get featuredBrands {
    return _brands.where((brand) => brand.isFeatured == true).toList();
  }

  // Fetch all brands
  Future<void> fetchBrands() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.product.get_brands',
      );

      if (response['message'] != null) {
        final List<dynamic> data = response['message'];
        _brands = data.map((json) => Brand.fromJson(json)).toList();

        // Sort alphabetically
        _brands.sort((a, b) => a.name.compareTo(b.name));

        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching brands: $e');
    }
  }

  // Fetch brand by ID
  Future<void> fetchBrandById(String brandId) async {
    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.product.get_brand',
        params: {'brand_id': brandId},
      );

      if (response['message'] != null) {
        _selectedBrand = Brand.fromJson(response['message']);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error fetching brand: $e');
    }
  }

  // Select brand
  void selectBrand(Brand brand) {
    _selectedBrand = brand;
    notifyListeners();
  }

  // Clear selection
  void clearSelection() {
    _selectedBrand = null;
    notifyListeners();
  }

  // Get brand by ID
  Brand? getBrandById(String brandId) {
    try {
      return _brands.firstWhere((brand) => brand.id == brandId);
    } catch (e) {
      return null;
    }
  }

  // Search brands
  List<Brand> searchBrands(String query) {
    if (query.isEmpty) return _brands;

    final lowerQuery = query.toLowerCase();
    return _brands.where((brand) {
      return brand.name.toLowerCase().contains(lowerQuery) ||
          (brand.description?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  // Sort brands
  void sortBrands(String sortBy) {
    switch (sortBy) {
      case 'name_asc':
        _brands.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'name_desc':
        _brands.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'popular':
        _brands.sort((a, b) {
          if (a.isPopular == b.isPopular) return 0;
          return a.isPopular ? -1 : 1;
        });
        break;
      default:
        break;
    }
    notifyListeners();
  }

  // Get brands by letter (for alphabetical index)
  Map<String, List<Brand>> getBrandsByLetter() {
    final Map<String, List<Brand>> brandsByLetter = {};

    for (var brand in _brands) {
      final firstLetter = brand.name[0].toUpperCase();
      if (!brandsByLetter.containsKey(firstLetter)) {
        brandsByLetter[firstLetter] = [];
      }
      brandsByLetter[firstLetter]!.add(brand);
    }

    return brandsByLetter;
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Reset
  void reset() {
    _brands = [];
    _selectedBrand = null;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
