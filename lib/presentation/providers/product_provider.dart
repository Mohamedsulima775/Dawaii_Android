// lib/providers/product_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';



class ProductProvider with ChangeNotifier {
  final ProductRepository repository;

  ProductProvider({required this.repository});

  // State
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  Product? _selectedProduct;
  bool _isLoading = false;
  String? _error;

  // Pagination
  int _currentPage = 1;
  final int _itemsPerPage = 20;
  bool _hasMore = true;

  // Getters
  List<Product> get products =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  Product? get selectedProduct => _selectedProduct;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMore => _hasMore;

  // ===============================
  // Fetch All Products
  // ===============================
  Future<void> fetchProducts({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _products.clear();
    }

    _isLoading = true;
    notifyListeners();

    final result = await repository.getProducts(
      page: _currentPage,
      limit: _itemsPerPage,
    );

    result.fold(
          (failure) => _error = failure.message,
          (newProducts) {
        _products.addAll(newProducts);
        _hasMore = newProducts.length == _itemsPerPage;
        _currentPage++;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  // ===============================
  // Fetch Product By ID
  // ===============================
  Future<void> fetchProductById(String id) async {
    _isLoading = true;
    notifyListeners();

    final result = await repository.getProductById(id);

    result.fold(
          (failure) => _error = failure.message,
          (product) => _selectedProduct = product,
    );

    _isLoading = false;
    notifyListeners();
  }

  // ===============================
  // Fetch By Category
  // ===============================
  Future<void> fetchProductsByCategory(String categoryId) async {
    _isLoading = true;
    notifyListeners();

    final result = await repository.getProductsByCategory(categoryId);

    result.fold(
          (failure) => _error = failure.message,
          (products) => _products = products,
    );

    _isLoading = false;
    notifyListeners();
  }

  // ===============================
  // Featured
  // ===============================
  Future<void> fetchFeaturedProducts() async {
    _error = null;
    _isLoading = true;
    notifyListeners();

    final result = await repository.getFeaturedProducts();

    result.fold(
          (failure) => _error = failure.message,
          (products) => _products = products,
    );

    _isLoading = false;
    notifyListeners();
  }

  // ===============================
  // Local Filter (UI only)
  // ===============================
  void filterProducts(String query) {
    _filteredProducts = _products
        .where((p) => p.itemName.toLowerCase().contains(query.toLowerCase()),)

    // .where((p) => p.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void clearFilters() {
    _filteredProducts.clear();
    notifyListeners();
  }

  void reset() {
    _products.clear();
    _filteredProducts.clear();
    _selectedProduct = null;
    _currentPage = 1;
    _hasMore = true;
    _error = null;
    notifyListeners();
  }
}