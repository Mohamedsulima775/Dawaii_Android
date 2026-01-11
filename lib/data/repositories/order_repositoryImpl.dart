
// التعديل للربط

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient _apiClient;

  OrderRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  // Helper method to safely extract list from response
  List _extractList(dynamic data) {
    if (data == null) return [];
    if (data is List) return data;
    if (data is String) return []; // API returned string instead of list
    if (data is Map && data.containsKey('orders')) {
      return _extractList(data['orders']);
    }
    if (data is Map && data.containsKey('data')) {
      return _extractList(data['data']);
    }
    return [];
  }

  // Helper method to safely extract map from response
  Map<String, dynamic>? _extractMap(dynamic data, String key) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) {
      if (data.containsKey(key)) {
        final value = data[key];
        if (value is Map<String, dynamic>) return value;
      }
      // Try nested message
      if (data.containsKey('message')) {
        return _extractMap(data['message'], key);
      }
      if (data.containsKey('data')) {
        return _extractMap(data['data'], key);
      }
    }
    return null;
  }

  // ==========================================
  // Create Order
  // ==========================================
  @override
  Future<Either<Failure, OrderModel>> createOrder({
    required String patientId,
    required List<OrderItem> items,
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
    String paymentMethod = 'cash_on_delivery',
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.createOrder,
        body: {
          'patient_id': patientId,
          'delivery_address': deliveryAddress,
          'delivery_city': deliveryCity,
          'delivery_phone': deliveryPhone,
          'delivery_notes': deliveryNotes,
          'payment_method': paymentMethod,
          'items': items
              .map((e) => {
            'item_code': e.itemCode,
            'item_name': e.itemName,
            'quantity': e.quantity,
            'rate': e.price,
          })
              .toList(),
        },
      );

      // Safely extract order data
      final orderData = _extractMap(response, 'order') ??
          _extractMap(response['data'], 'order') ??
          _extractMap(response['message'], 'order');

      if (orderData != null) {
        final model = OrderModel.fromJson(orderData);
        return Right(model);
      }
      return Left(ServerFailure('Invalid response format'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // ==========================================
  // Get Orders
  // ==========================================
  @override
  Future<Either<Failure, List<OrderModel>>> getOrders({
    required String patientId,
    String? status,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.getMyOrders,
        body: {
          'patient_id': patientId,
          if (status != null) 'status': status,
        },
      );

      // Safely extract orders list
      List ordersData = [];

      // Try different paths
      if (response['data'] != null) {
        final data = response['data'];
        if (data is Map && data['message'] != null) {
          ordersData = _extractList(data['message']);
        } else {
          ordersData = _extractList(data);
        }
      } else if (response['message'] != null) {
        ordersData = _extractList(response['message']);
      } else {
        ordersData = _extractList(response);
      }

      final list = ordersData
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(list);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // ==========================================
  // Get Order By Id
  // ==========================================
  @override
  Future<Either<Failure, OrderModel>> getOrderById(String orderId) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.getOrderDetail,
        body: {'order_id': orderId},
      );

      // Safely extract order data
      final orderData = _extractMap(response, 'order') ??
          _extractMap(response['data'], 'order') ??
          _extractMap(response['message'], 'order');

      if (orderData != null) {
        final model = OrderModel.fromJson(orderData);
        return Right(model);
      }
      return Left(ServerFailure('Invalid response format'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // ==========================================
  // Cancel Order
  // ==========================================
  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      await _apiClient.post(
        ApiConstants.cancelOrder,
        body: {'order_id': orderId},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // ==========================================
  // Rate Order
  // ==========================================
  @override
  Future<Either<Failure, void>> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  }) async {
    try {
      await _apiClient.post(
        ApiConstants.rateOrder,
        body: {
          'order_id': orderId,
          'rating': rating,
          'feedback': feedback,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
