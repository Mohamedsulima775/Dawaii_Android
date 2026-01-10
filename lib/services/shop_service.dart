// lib/services/shop_service.dart

import '../core/constants/api_constants.dart';
import '../data/models/cart_item_model.dart';
import '../data/models/order_model.dart';
import '../data/models/product.dart';
import 'api_service.dart';

class ShopService {
  final ApiService _apiService;

  ShopService(this._apiService);

  // Get products
  Future<List<Product>> getProducts({String? category, String? search}) async {
    final response = await _apiService.get(
      ApiConstants.getProducts,
      params: {
        if (category != null) 'category': category,
        if (search != null) 'search': search,
      },
    );

    return (response['message'] as List?)
        ?.map((p) => Product.fromJson(p))
        .toList() ??
        [];
  }

  // Search products
  Future<List<Product>> searchProducts(String query) async {
    final response = await _apiService.get(
      ApiConstants.searchProducts,
      params: {'query': query},
    );

    return (response['message'] as List?)
        ?.map((p) => Product.fromJson(p))
        .toList() ??
        [];
  }

  // Get product details
  Future<Product> getProductDetails(String productId) async {
    final response = await _apiService.get(
      ApiConstants.getProductDetails,
      params: {'product_id': productId},
    );

    return Product.fromJson(response['message']);
  }

  // Create order
  Future<OrderModel> createOrder(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      ApiConstants.createOrder,
      data: data,
    );

    return OrderModel.fromJson(response['message']);
  }

  // Get patient orders
  Future<List<OrderModel>> getPatientOrders(String patientId) async {
    final response = await _apiService.get(
      ApiConstants.getMyOrders,
      params: {'patient_id': patientId},
    );

    return (response['message'] as List?)
        ?.map((o) => OrderModel.fromJson(o))
        .toList() ??
        [];
  }

  // Get order details
  Future<OrderModel> getOrderDetails(String orderId) async {
    final response = await _apiService.get(
      ApiConstants.getOrderDetail,
      params: {'order_id': orderId},
    );

    return OrderModel.fromJson(response['message']);
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    await _apiService.post(
      ApiConstants.cancelOrder,
      data: {'order_id': orderId},
    );
  }
}
