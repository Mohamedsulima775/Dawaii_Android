
// domain/usecases/order/create_order_usecase.dart

import 'package:dartz/dartz.dart' hide Order;
import 'package:equatable/equatable.dart';
import '../../../data/repositories/order_mapper.dart';
import '../../entities/order.dart';
import 'package:dawaii/core/errors/failures.dart';
import 'package:dawaii/data/repositories/order_repository.dart';
import '../usecase.dart';

/// UseCase لإنشاء طلب جديد
class CreateOrderUseCase implements UseCase<Order, CreateOrderParams> {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  @override
  Future<Either<Failure, Order>> call(CreateOrderParams params) async {
    // Validate input
    final validation = params.validate();
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    // تحويل الـ domain OrderItem إلى data model OrderItem
    final modelItems = params.items.map((e) => e.toModel()).toList();

    // Call repository
    final result = await repository.createOrder(
      patientId: params.patientId,
      //items: params.items.map((e) => e.toEntity()).toList(), // ✅ الآن النوع صحيح
      deliveryAddress: params.deliveryAddress,
      deliveryCity: params.deliveryCity,
      deliveryPhone: params.deliveryPhone,
      deliveryNotes: params.deliveryNotes,
      paymentMethod: params.paymentMethod, items: [],
    );

    // تحويل الناتج من OrderModel → Order (entity)
    return result.map((orderModel) => orderModel.toEntity());
  }
}


/// Parameters لإنشاء طلب
class CreateOrderParams extends Equatable {
  final String patientId;
  final List<OrderItem> items;
  final String deliveryAddress;
  final String? deliveryCity;
  final String? deliveryPhone;
  final String? deliveryNotes;
  final String paymentMethod;

  const CreateOrderParams({
    required this.patientId,
    required this.items,
    required this.deliveryAddress,
    this.deliveryCity,
    this.deliveryPhone,
    this.deliveryNotes,
    this.paymentMethod = 'cash_on_delivery',
  });

  /// Validate inputs
  String? validate() {
    // Patient ID validation
    if (patientId.isEmpty) {
      return 'معرف المريض مطلوب';
    }

    // Items validation
    if (items.isEmpty) {
      return 'يجب إضافة منتج واحد على الأقل';
    }

    // Check each item
    for (final item in items) {
      if (item.quantity <= 0) {
        return 'الكمية يجب أن تكون أكبر من صفر';
      }

      if (item.price < 0) {
        return 'السعر غير صحيح';
      }
    }

    // Delivery address validation
    if (deliveryAddress.isEmpty) {
      return 'عنوان التوصيل مطلوب';
    }

    if (deliveryAddress.length < 10) {
      return 'عنوان التوصيل غير واضح';
    }

    // Delivery phone validation (optional)
    if (deliveryPhone != null && deliveryPhone!.isNotEmpty) {
      if (deliveryPhone!.length != 10) {
        return 'رقم الجوال يجب أن يكون 10 أرقام';
      }

      if (!deliveryPhone!.startsWith('05')) {
        return 'رقم الجوال يجب أن يبدأ بـ 05';
      }
    }

    // Payment method validation
    final validPaymentMethods = [
      'cash_on_delivery',
      'credit_card',
      'mada',
      'apple_pay',
    ];

    if (!validPaymentMethods.contains(paymentMethod)) {
      return 'طريقة الدفع غير صحيحة';
    }

    return null; // Valid
  }

  /// Calculate total amount
  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  /// Get total items count
  int get itemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  @override
  List<Object?> get props => [
    patientId,
    items,
    deliveryAddress,
    deliveryCity,
    deliveryPhone,
    deliveryNotes,
    paymentMethod,
  ];
}