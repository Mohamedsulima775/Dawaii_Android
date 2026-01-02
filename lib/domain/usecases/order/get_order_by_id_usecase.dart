// domain/usecases/order/get_order_by_id_usecase.dart

import 'package:dartz/dartz.dart' hide  Order;
import 'package:equatable/equatable.dart';
import '../../entities/order.dart';
import 'package:dawaii/core/errors/failures.dart';
import 'package:dawaii/data/repositories/order_repository.dart';
import '../usecase.dart';

/// UseCase للحصول على تفاصيل طلب معين
class GetOrderByIdUseCase implements UseCase<Order, GetOrderByIdParams> {
  final OrderRepository repository;

  GetOrderByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Order>> call(GetOrderByIdParams params) async {
    // Validate input
    final validation = params.validate();
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    // Call repository
    return await repository.getOrderById(params.orderId);
  }
}

/// Parameters للحصول على طلب معين
class GetOrderByIdParams extends Equatable {
  final String orderId;

  const GetOrderByIdParams({required this.orderId});

  /// Validate inputs
  String? validate() {
    if (orderId.isEmpty) {
      return 'معرف الطلب مطلوب';
    }

    return null; // Valid
  }

  @override
  List<Object?> get props => [orderId];
}