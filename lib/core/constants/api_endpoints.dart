
class ApiEndpoints {
  static const String baseUrl = 'http://YOUR_IP:8000';

  // Orders
  static const String createOrder = '/api/method/my_medicinal.api.create_order';
  static const String getOrders = '/api/method/my_medicinal.api.get_orders';
  static const String getOrderDetail = '/api/method/my_medicinal.api.get_order_detail';
  static const String cancelOrder = '/api/method/my_medicinal.api.cancel_order';
  static const String rateOrder = '/api/method/my_medicinal.api.rate_order';
  static const String confirmDelivery = '/api/method/my_medicinal.api.confirm_delivery';
}

const String baseUrl = 'http://localhost:8000';
const String apiPath = '/api/method';
// Timeouts
const Duration connectTimeout = Duration(seconds: 30);
const Duration receiveTimeout = Duration(seconds: 30);

// Prescription Status
