// التعديل للربط

// lib/data/repositories/order_repository.dart

import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';


abstract class OrderRepository {
  /// إنشاء طلب جديد
  Future<Either<Failure, OrderModel>> createOrder({
    required String patientId,
    required List<OrderItem> items,
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
    required String paymentMethod,
  });

  /// جلب جميع طلبات المريض
  Future<Either<Failure, List<OrderModel>>> getOrders({
    required String patientId,
    String? status,
  });

  /// جلب طلب واحد
  Future<Either<Failure, OrderModel>> getOrderById(String orderId);

  /// إلغاء طلب
  Future<Either<Failure, void>> cancelOrder(String orderId);

  /// تقييم طلب
  Future<Either<Failure, void>> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  });
}



/*
// الاول

// domain/repositories/order_repository.dart

import 'package:dartz/dartz.dart' hide Order;
import 'package:dawaii/domain/entities/order.dart';
import 'package:dawaii/core/errors/failures.dart';

import '../models/cart_item_model.dart';
import '../models/order_model.dart';


abstract class OrderRepository {
  /// إنشاء طلب جديد
  Future<Either<Failure, Order>> createOrder({
    required String patientId,
    required List<OrderItem> items,
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
    String paymentMethod,
  });

  /// الحصول على طلبات المريض
  Future<Either<Failure, List<Order>>> getOrders({
    required String patientId,
    OrderStatus? status,
  });

  /// الحصول على تفاصيل طلب معين
  Future<Either<Failure, Order>> getOrderById(String orderId);

  /// إلغاء طلب
  Future<Either<Failure, void>> cancelOrder(String orderId);

  /// تقييم طلب
  Future<Either<Failure, void>> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  });
}

 */



