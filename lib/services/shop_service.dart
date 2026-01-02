

import '../data/models/cart_item_model.dart';
import '../data/models/order_model.dart';
import '../data/models/product.dart';
import 'api_service.dart';
import '../domain/entities/order.dart';

class ShopService {
  final ApiService _apiService;

  ShopService(this._apiService);

  // Get shop home data
  Future<Map<String, dynamic>> getShopHome() async {
    final response = await _apiService.get('my_medicinal.api.get_shop_home');
    return response['message'];
  }

  // Get products
  Future<List<Product>> getProducts({String? category, String? search}) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_products',
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

  // Get product details
  Future<Product> getProductDetails(String productId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_product_details',
      params: {'product_id': productId},
    );

    return Product.fromJson(response['message']);
  }

  // Get cart
  Future<List<CartItemModel>> getCart(String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_cart',
      params: {'patient_id': patientId},
    );

    return (response['message'] as List?)
        ?.map((i) => CartItemModel.fromJson(i))
        .toList() ??
        [];
  }

  // Add to cart
  Future<void> addToCart(String patientId, String productId, int quantity) async {
    await _apiService.post(
      'my_medicinal.api.add_to_cart',
      data: {
        'patient_id': patientId,
        'product_id': productId,
        'quantity': quantity,
      },
    );
  }

  // Update cart item
  Future<void> updateCartItem(String cartItemId, int quantity) async {
    await _apiService.put(
      'my_medicinal.api.update_cart_item',
      data: {
        'cart_item_id': cartItemId,
        'quantity': quantity,
      },
    );
  }

  // Remove cart item
  Future<void> removeCartItem(String cartItemId) async {
    await _apiService.delete(
      'my_medicinal.api.remove_cart_item',
      data: {'cart_item_id': cartItemId},
    );
  }

  // Apply discount code
  Future<Map<String, dynamic>> applyDiscountCode(String code) async {
    final response = await _apiService.post(
      'my_medicinal.api.apply_discount_code',
      data: {'code': code},
    );

    return response['message'];
  }

  // Create order
  Future<OrderModel> createOrder(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      'my_medicinal.api.create_order',
      data: data,
    );

    return OrderModel.fromJson(response['message']);
  }

  // Get patient orders
  Future<List<OrderModel>> getPatientOrders(String patientId) async {
    final response = await _apiService.get(
      'my_medicinal.api.get_patient_orders',
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
      'my_medicinal.api.get_order_details',
      params: {'order_id': orderId},
    );

    return OrderModel.fromJson(response['message']);
  }

  // Cancel order
  Future<void> cancelOrder(String orderId) async {
    await _apiService.post(
      'my_medicinal.api.cancel_order',
      data: {'order_id': orderId},
    );
  }
}