
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

      final model =
      OrderModel.fromJson(response['data']['message']['order']);
      return Right(model);
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

      final list = (response['data']['message']['orders'] as List)
          .map((e) => OrderModel.fromJson(e))
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

      final model =
      OrderModel.fromJson(response['data']['message']['order']);
      return Right(model);
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
