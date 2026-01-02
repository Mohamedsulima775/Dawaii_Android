
import 'package:dartz/dartz.dart' hide Order;
import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:dawaii/domain/entities/patient.dart';
import 'package:dawaii/core/errors/failures.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/order.dart';
import 'package:dawaii/data/repositories/order_repository.dart';

import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import 'order_mapper.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient _apiClient;

  OrderRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  // ==========================================
  // Create Order
  // ==========================================
  @override
  Future<Either<Failure, Order>> createOrder({
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
        ApiEndpoints.createOrder,
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
      return Right(model.toEntity());
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
  Future<Either<Failure, List<Order>>> getOrders({
    required String patientId,
    OrderStatus? status,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.getOrders,
        body: {
          'patient_id': patientId,
          if (status != null) 'status': status.name,
        },
      );

      final list = (response['data']['message']['orders'] as List)
          .map((e) => OrderModel.fromJson(e).toEntity())
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
  Future<Either<Failure, Order>> getOrderById(String orderId) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.getOrderDetail,
        body: {'order_id': orderId},
      );

      final model =
      OrderModel.fromJson(response['data']['message']['order']);
      return Right(model.toEntity());
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
        ApiEndpoints.cancelOrder,
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
        ApiEndpoints.rateOrder,
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

/*
class OrderRepositoryImpl implements OrderRepository {
  final ApiClient apiClient;

  OrderRepositoryImpl({required this.apiClient});

  // =============================
  // CREATE ORDER
  // =============================
  @override
  Future<Either<Failure, Order>> createOrder({
    required String patientId,
    required List<OrderItem> items,
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
    String paymentMethod = 'cash',
  }) async {
    try {
      final itemsData = items.map((item) {
        final cartItem = item as CartItemModel;
        return {
          'item_code': cartItem.itemCode,
          'item_name': cartItem.itemName,
          'quantity': cartItem.quantity,
          'rate': cartItem.price,
        };
      }).toList();

      final response = await apiClient.post(
        ApiEndpoints.createOrder,
        data: {
          'patient_id': patientId,
          'items': itemsData,
          'delivery_address': deliveryAddress,
          if (deliveryCity != null) 'delivery_city': deliveryCity,
          if (deliveryPhone != null) 'delivery_phone': deliveryPhone,
          if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
          'payment_method': paymentMethod,
        },
      );

      if (response.data['message']['success'] == true) {
        final model =
        OrderModel.fromJson(response.data['message']['order']);
        return Right(_mapOrderModelToEntity(model));
      }

      return Left(
        ServerFailure(
          response.data['message']['message'] ?? 'فشل إنشاء الطلب',
        ),
      );
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // =============================
  // GET ORDERS
  // =============================
  @override
  Future<Either<Failure, List<Order>>> getOrders({
    required String patientId,
    OrderStatus? status,
  }) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.getOrders,
        data: {
          'patient_id': patientId,
          if (status != null) 'status': status.name,
        },
      );

      if (response.data['message']['success'] == true) {
        final orders = (response.data['message']['orders'] as List)
            .map(
              (json) => _mapOrderModelToEntity(
            OrderModel.fromJson(json),
          ),
        )
            .toList();

        return Right(orders);
      }

      return Left(
        ServerFailure(
          response.data['message']['message'] ?? 'فشل جلب الطلبات',
        ),
      );
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // =============================
  // GET ORDER BY ID
  // =============================
  @override
  Future<Either<Failure, Order>> getOrderById(String orderId) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.getOrderDetail,
        data: {'order_id': orderId},
      );

      if (response.data['message']['success'] == true) {
        final model =
        OrderModel.fromJson(response.data['message']['order']);
        return Right(_mapOrderModelToEntity(model));
      }

      return Left(
        ServerFailure(
          response.data['message']['message'] ?? 'فشل جلب الطلب',
        ),
      );
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // =============================
  // CANCEL ORDER
  // =============================
  @override
  Future<Either<Failure, void>> cancelOrder(String orderId) async {
    try {
      await apiClient.post(
        ApiEndpoints.cancelOrder,
        data: {'order_id': orderId},
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // =============================
  // RATE ORDER
  // =============================
  @override
  Future<Either<Failure, void>> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  }) async {
    try {
      await apiClient.post(
        ApiEndpoints.rateOrder,
        data: {
          'order_id': orderId,
          'rating': rating,
          if (feedback != null) 'feedback': feedback,
        },
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // =============================
  // HELPERS
  // =============================

  Order _mapOrderModelToEntity(OrderModel model) {
    return Order(
      id: orderId,
      patientId: model.patientId,
      items: model.items,
      deliveryAddress: model.deliveryAddress,
      deliveryCity: model.deliveryCity,
      deliveryPhone: model.deliveryPhone,
      paymentMethod: model.paymentMethod,
      status: model.status,
      createdAt: model.createdAt, patientName: '', totalAmount: null,
    );
  }

  Failure _mapDioFailure(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('انتهى وقت الاتصال');

      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 401) {
          return const AuthenticationFailure('انتهت الجلسة');
        }
        if (e.response?.statusCode == 404) {
          return const ServerFailure('العنصر غير موجود', 404);
        }
        return const ServerFailure('خطأ من الخادم');

      case DioExceptionType.connectionError:
        return const NetworkFailure('تحقق من اتصال الإنترنت');

      default:
        return const UnknownFailure('خطأ غير متوقع');
    }
  }
}

 */

/*
/// Order Repository Implementation
///
/// مسؤول عن جلب وإرسال بيانات الطلبات من/إلى Backend
class OrderRepositoryImpl implements OrderRepository {
  final ApiClient _apiClient;

  OrderRepositoryImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  /// إنشاء طلب جديد
  ///
  /// Backend API: my_medicinal.api.create_order
  @override
  Future<OrderModel> createOrder({
    required String patientId,
    required List<CartItemModel> items,
    required String deliveryAddress,
    required String deliveryCity,
    required String deliveryPhone,
    required String paymentMethod,
    String? prescriptionId,
    String? deliveryNotes,
  }) async {
    try {
      // تحويل Cart Items إلى Format المناسب للـ Backend
      final itemsData = items.map((item) => {
        'item_code': item.itemCode,
        'item_name': item.itemName,
        'quantity': item.quantity,
        'rate': item.price,
      }).toList();

      // إرسال الطلب للـ Backend
      final response = await _apiClient.post(
        ApiEndpoints.createOrder,
        data: {
          'patient_id': patientId,
          'items': itemsData,
          'delivery_address': deliveryAddress,
          'delivery_city': deliveryCity,
          'delivery_phone': deliveryPhone,
          'payment_method': paymentMethod,
          if (prescriptionId != null) 'prescription_id': prescriptionId,
          if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
        },
      );

      // التحقق من النجاح
      if (response.data['message']['success'] == true) {
        final orderData = response.data['message']['order'];
        return OrderModel.fromJson(orderData);
      } else {
        throw ServerException(
          message: response.data['message']['message'] ?? 'فشل إنشاء الطلب',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }

  /// الحصول على قائمة طلبات المريض
  @override
  Future<List<OrderModel>> getOrders({
    required String patientId,
    String? status,
    int? limit,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.getOrders,
        data: {
          'patient_id': patientId,
          if (status != null) 'status': status,
          if (limit != null) 'limit': limit,
        },
      );

      if (response.data['message']['success'] == true) {
        final ordersData = response.data['message']['orders'] as List;
        return ordersData
            .map((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          message: response.data['message']['message'] ?? 'فشل جلب الطلبات',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }

  /// الحصول على تفاصيل طلب محدد

  @override
  Future<Either<Failure, Order>> getOrderDetail({required String orderId}) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.getOrderDetail,
        data: {'order_id': orderId},
      );
      return Right(OrderModel.fromJson(response.data['message']['order']) as Order);
    } catch (e) {
      return Left(ServerFailure());
    }
  }



  @override
  Future<OrderModel> getOrderDetail({
    required String orderId,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.getOrderDetail,
        data: {'order_id': orderId},
      );

      if (response.data['message']['success'] == true) {
        final orderData = response.data['message']['order'];
        return OrderModel.fromJson(orderData);
      } else {
        throw ServerException(
          message: response.data['message']['message'] ?? 'فشل جلب تفاصيل الطلب',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }



  /// إلغاء طلب

  @override
  Future<bool> cancelOrder({
    required String orderId,
    String? reason,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.cancelOrder,
        data: {
          'order_id': orderId,
          if (reason != null) 'reason': reason,
        },
      );

      return response.data['message']['success'] == true;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }

  /// تقييم طلب
  @override
  Future<bool> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.rateOrder,
        data: {
          'order_id': orderId,
          'rating': rating,
          if (feedback != null) 'feedback': feedback,
        },
      );

      return response.data['message']['success'] == true;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }

  /// تأكيد استلام الطلب
  @override
  Future<bool> confirmDelivery({
    required String orderId,
  }) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.confirmDelivery,
        data: {'order_id': orderId},
      );

      return response.data['message']['success'] == true;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ غير متوقع: $e');
    }
  }

  /// إعادة طلب (Re-order)
  @override
  Future<OrderModel> reorder({
    required String orderId,
  }) async {
    try {
      // 1. جلب تفاصيل الطلب القديم
      final oldOrder = await getOrderDetail(orderId: orderId);

      // 2. إنشاء طلب جديد بنفس العناصر
      return await createOrder(
        patientId: oldOrder.patientId,
        items: oldOrder.items,
        deliveryAddress: oldOrder.deliveryAddress,
        deliveryCity: oldOrder.deliveryCity,
        deliveryPhone: oldOrder.deliveryPhone,
        paymentMethod: oldOrder.paymentMethod,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'خطأ في إعادة الطلب: $e');
    }
  }

  /// معالجة أخطاء Dio
  ServerException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException(
          message: 'انتهى وقت الاتصال. تحقق من اتصال الإنترنت.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return UnauthorizedException(
            message: 'انتهت صلاحية الجلسة. الرجاء تسجيل الدخول مرة أخرى.',
          );
        } else if (statusCode == 404) {
          return NotFoundException(message: 'الطلب غير موجود');
        } else if (statusCode == 500) {
          return ServerException(message: 'خطأ في الخادم. حاول لاحقاً.');
        }
        return ServerException(
          message: error.response?.data?['message'] ?? 'خطأ في الخادم',
        );

      case DioExceptionType.cancel:
        return ServerException(message: 'تم إلغاء الطلب');

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'خطأ في الاتصال. تحقق من الإنترنت.',
        );

      default:
        return ServerException(
          message: 'خطأ غير متوقع: ${error.message}',
        );
    }
  }
}

 */


