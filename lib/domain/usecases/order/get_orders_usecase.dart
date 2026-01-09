// domain/usecases/order/get_orders_usecase.dart

import 'package:dartz/dartz.dart' hide Order;
import 'package:equatable/equatable.dart';
import '../../../data/repositories/order_mapper.dart';
import '../../entities/order.dart';
import 'package:dawaii/core/errors/failures.dart';
import 'package:dawaii/data/repositories/order_repository.dart';
import '../usecase.dart';

/// UseCase للحصول على طلبات المريض
class GetOrdersUseCase implements UseCase<List<Order>, GetOrdersParams> {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Order>>> call(GetOrdersParams params) async {
    // Validate input
    final validation = params.validate();
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    // Call repository
    final result = await repository.getOrders(
      patientId: params.patientId,
      status: params.status?.name,
    );

    // تحويل List<OrderModel> → List<Order> (entities)
    return result.map(
          (orderModels) => orderModels.map((e) => e.toEntity()).toList(),
    );
  }
}

/// Parameters للحصول على كل الطلبات

/// Parameters للحصول على الطلبات
class GetOrdersParams extends Equatable {
  final String patientId;
  final OrderStatus? status;// حسب API، يمكن أن يكون OrderStatus.name أو String

  const GetOrdersParams({required this.patientId, this.status,});

  /// Validate inputs
  String? validate() {
    if (patientId.isEmpty) {
      return 'معرف المريض مطلوب';
    }

    return null; // Valid
  }

  /// Get all orders (no filter)
  factory GetOrdersParams.all(String patientId) {
    return GetOrdersParams(patientId: patientId);
  }

  /// Get only pending orders
  factory GetOrdersParams.pending(String patientId) {
    return GetOrdersParams(
      patientId: patientId,
      status: OrderStatus.pending,
    );
  }

  /// Get only processing orders
  factory GetOrdersParams.processing(String patientId) {
    return GetOrdersParams(
      patientId: patientId,
      status: OrderStatus.processing,
    );
  }

  /// Get only shipped orders
  factory GetOrdersParams.shipped(String patientId) {
    return GetOrdersParams(
      patientId: patientId,
      status: OrderStatus.shipped,
    );
  }

  /// Get only delivered orders
  factory GetOrdersParams.delivered(String patientId) {
    return GetOrdersParams(
      patientId: patientId,
      status: OrderStatus.delivered,
    );
  }

  @override
  List<Object?> get props => [patientId, status];
}