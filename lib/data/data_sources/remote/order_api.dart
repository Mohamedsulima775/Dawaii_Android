
// lib/data/data_sources/remote/order_api.dart

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class OrderApi {
  final ApiClient _apiClient;

  OrderApi(this._apiClient);

  Future<Map<String, dynamic>> createOrder({
    required List<Map<String, dynamic>> items,
    required String deliveryAddress,
    required String paymentMethod,
    String? notes,
  }) async {
    final response = await _apiClient.post(
      ApiConstants.createOrder,
      body: {
        'items': items,
        'delivery_address': deliveryAddress,
        'payment_method': paymentMethod,
        if (notes != null) 'notes': notes,
      },
    );
    return response['message'] as Map<String, dynamic>;
  }

  Future<List<dynamic>> getMyOrders({int limit = 20}) async {
    final response = await _apiClient.get(
      ApiConstants.getMyOrders,
      queryParameters: {'limit': limit},
    );
    return response['message'] as List<dynamic>;
  }
}
