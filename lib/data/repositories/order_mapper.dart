import '../../domain/entities/order.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

/// =======================
/// Order ↔ OrderModel
/// =======================

extension OrderModelMapper on OrderModel {
  Order toEntity() {
    return Order(
      id: orderId,
      patientId: patientId,
      patientName: patientName,
      items: items.map((e) => e.toEntity()).toList(),
      totalAmount: totalAmount,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
      paymentMethod: paymentMethod,
      status: OrderStatus.values.byName(status),
      courierName: courierName,
      courierPhone: courierPhone,
      trackingNumber: trackingNumber,
      rating: rating,
      createdAt: createdAt,
    );
  }
}

extension OrderEntityMapper on Order {
  OrderModel toModel() {
    return OrderModel(
      orderId: id,
      patientId: patientId,
      patientName: patientName,
      items: items.map((e) => e.toModel()).toList(),
      totalAmount: totalAmount,
      status: status.name,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity ?? '',
      deliveryPhone: deliveryPhone ?? '',
      paymentMethod: paymentMethod,
      trackingNumber: trackingNumber,
      courierName: courierName,
      courierPhone: courierPhone,
      rating: rating,
      createdAt: createdAt,
    );
  }
}

/// =======================
/// OrderItem ↔ CartItemModel
/// =======================

extension CartItemModelMapper on CartItemModel {
  OrderItem toEntity() {
    return OrderItem(
      itemCode: itemCode,
      itemName: itemName,
      quantity: quantity,
      price: price,
      image: imageUrl,
    );
  }
}

extension OrderItemMapper on OrderItem {
  CartItemModel toModel() {
    return CartItemModel(
      itemCode: itemCode,
      itemName: itemName,
      quantity: quantity,
      price: price,
      imageUrl: image,
    );
  }
}