
// lib/providers/banner_provider.dart

import 'package:flutter/foundation.dart';
import '../../data/models/banner_model.dart';
import '../../services/api_service.dart';

class BannerProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State
  List<BannerModel> _banners = [];
  List<BannerModel> _homeBanners = [];
  List<BannerModel> _categoryBanners = [];
  List<BannerModel> _productBanners = [];
  BannerModel? _selectedBanner;
  bool _isLoading = false;
  String? _error;
  int _currentBannerIndex = 0;

  // Getters
  List<BannerModel> get banners => _banners;
  List<BannerModel> get homeBanners => _homeBanners;
  List<BannerModel> get categoryBanners => _categoryBanners;
  List<BannerModel> get productBanners => _productBanners;
  BannerModel? get selectedBanner => _selectedBanner;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentBannerIndex => _currentBannerIndex;

  // Get active banners
  List<BannerModel> get activeBanners {
    final now = DateTime.now();
    return _banners.where((banner) {
      if (!banner.isActive) return false;
      if (banner.startDate != null && now.isBefore(banner.startDate!)) {
        return false;
      }
      if (banner.endDate != null && now.isAfter(banner.endDate!)) {
        return false;
      }
      return true;
    }).toList();
  }

  // Fetch all banners
  Future<void> fetchBanners() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.content.get_banners',
      );

      if (response['message'] != null) {
        final List<dynamic> data = response['message'];
        _banners = data.map((json) => BannerModel.fromJson(json)).toList();

        // Sort by priority
        _banners.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));

        // Filter by type
        _filterBannersByType();

        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching banners: $e');
    }
  }

  // Filter banners by type
  void _filterBannersByType() {
    _homeBanners = activeBanners
        .where((banner) => banner.type == 'home' || banner.type == 'main')
        .toList();

    _categoryBanners = activeBanners
        .where((banner) => banner.type == 'category')
        .toList();

    _productBanners = activeBanners
        .where((banner) => banner.type == 'product')
        .toList();
  }

  // Fetch banners by location
  Future<void> fetchBannersByLocation(String location) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.content.get_banners_by_location',
        params: {'location': location},
      );

      if (response['message'] != null) {
        final List<dynamic> data = response['message'];
        _banners = data.map((json) => BannerModel.fromJson(json)).toList();
        _banners.sort((a, b) => (b.priority ?? 0).compareTo(a.priority ?? 0));
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      debugPrint('Error fetching banners by location: $e');
    }
  }

  // Fetch banner by ID
  Future<void> fetchBannerById(String bannerId) async {
    try {
      final response = await _apiService.get(
        '/api/method/my_medicinal.api.content.get_banner',
        params: {'banner_id': bannerId},
      );

      if (response['message'] != null) {
        _selectedBanner = BannerModel.fromJson(response['message']);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error fetching banner: $e');
    }
  }

  // Track banner click
  Future<void> trackBannerClick(String bannerId) async {
    try {
      await _apiService.post(
        '/api/method/my_medicinal.api.content.track_banner_click',
        data: {'banner_id': bannerId},
      );
    } catch (e) {
      debugPrint('Error tracking banner click: $e');
    }
  }

  // Track banner impression
  Future<void> trackBannerImpression(String bannerId) async {
    try {
      await _apiService.post(
        '/api/method/my_medicinal.api.content.track_banner_impression',
        data: {'banner_id': bannerId},
      );
    } catch (e) {
      debugPrint('Error tracking banner impression: $e');
    }
  }

  // Set current banner index (for carousel)
  void setCurrentBannerIndex(int index) {
    _currentBannerIndex = index;
    notifyListeners();
  }

  // Next banner
  void nextBanner() {
    if (_homeBanners.isEmpty) return;
    _currentBannerIndex = (_currentBannerIndex + 1) % _homeBanners.length;
    notifyListeners();
  }

  // Previous banner
  void previousBanner() {
    if (_homeBanners.isEmpty) return;
    _currentBannerIndex =
        (_currentBannerIndex - 1 + _homeBanners.length) % _homeBanners.length;
    notifyListeners();
  }

  // Get banners by category
  List<BannerModel> getBannersByCategory(String category) {
    return activeBanners
        .where((banner) => banner.category == category)
        .toList();
  }

  // Get featured banners
  List<BannerModel> getFeaturedBanners() {
    return activeBanners
        .where((banner) => banner.isFeatured == true)
        .toList();
  }

  // Get banners by priority
  List<BannerModel> getBannersByPriority({int minPriority = 0}) {
    return activeBanners
        .where((banner) => (banner.priority ?? 0) >= minPriority)
        .toList();
  }

  // Check if banner is active now
  bool isBannerActive(BannerModel banner) {
    if (!banner.isActive) return false;

    final now = DateTime.now();

    if (banner.startDate != null && now.isBefore(banner.startDate!)) {
      return false;
    }

    if (banner.endDate != null && now.isAfter(banner.endDate!)) {
      return false;
    }

    return true;
  }

  // Get banner by ID
  BannerModel? getBannerById(String bannerId) {
    try {
      return _banners.firstWhere((banner) => banner.id == bannerId);
    } catch (e) {
      return null;
    }
  }

  // Handle banner action
  void handleBannerAction(BannerModel banner) {
    // Track click
    trackBannerClick(banner.id);

    // You can handle navigation here or emit an event
    // For example, navigate to product, category, or external URL
    debugPrint('Banner clicked: ${banner.title}');
    debugPrint('Action type: ${banner.actionType}');
    debugPrint('Action value: ${banner.actionValue}');
  }

  // Refresh banners
  Future<void> refreshBanners() async {
    await fetchBanners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Clear selection
  void clearSelection() {
    _selectedBanner = null;
    notifyListeners();
  }

  // Reset
  void reset() {
    _banners = [];
    _homeBanners = [];
    _categoryBanners = [];
    _productBanners = [];
    _selectedBanner = null;
    _isLoading = false;
    _error = null;
    _currentBannerIndex = 0;
    notifyListeners();
  }
}
