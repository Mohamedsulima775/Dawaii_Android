// التعديل للربط

// lib/data/models/order_model.dart

import 'cart_item_model.dart';

class OrderModel {
  final String orderId;
  final String patientId;
  final String patientName;
  final List<CartItemModel> items;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String deliveryCity;
  final String deliveryPhone;
  final String paymentMethod;
  final String? trackingNumber;
  final String? courierName;
  final String? courierPhone;
  final int? rating;
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.patientId,
    required this.patientName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryPhone,
    required this.paymentMethod,
    this.trackingNumber,
    this.courierName,
    this.courierPhone,
    this.rating,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] ?? json['name'] ?? '',
      patientId: json['patient_id'] ?? '',
      patientName: json['patient_name'] ?? '',
      items: (json['items'] as List? ?? [])
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      deliveryCity: json['delivery_city'] ?? '',
      deliveryPhone: json['delivery_phone'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      trackingNumber: json['tracking_number'],
      courierName: json['courier_name'],
      courierPhone: json['courier_phone'],
      rating: json['order_rating'],
      createdAt:
      DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  OrderModel copyWith({
    String? status,
    int? rating,
    String? trackingNumber,
  }) {
    return OrderModel(
      orderId: orderId,
      patientId: patientId,
      patientName: patientName,
      items: items,
      totalAmount: totalAmount,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
      paymentMethod: paymentMethod,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      courierName: courierName,
      courierPhone: courierPhone,
      rating: rating ?? this.rating,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'patient_id': patientId,
    'items': items.map((e) => e.toJson()).toList(),
    'delivery_address': deliveryAddress,
    'delivery_city': deliveryCity,
    'delivery_phone': deliveryPhone,
    'payment_method': paymentMethod,
    'total_amount': totalAmount,
    // لا نرسل order_id أو status عادةً لأن السيرفر هو من يحددهما عند الإنشاء
  };
}



/*
import 'order_item_model.dart';

class OrderModel {
  final String orderId;
  final String patientId;
  final String patientName;
  final List<OrderItem> items;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String deliveryCity;
  final String deliveryPhone;
  final String paymentMethod;
  final String? trackingNumber;
  final String? courierName;
  final String? courierPhone;
  final int? rating;
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.patientId,
    required this.patientName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryPhone,
    required this.paymentMethod,
    this.trackingNumber,
    this.courierName,
    this.courierPhone,
    this.rating,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] ?? json['name'] ?? '',
      patientId: json['patient_id'] ?? '',
      patientName: json['patient_name'] ?? '',
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      deliveryCity: json['delivery_city'] ?? '',
      deliveryPhone: json['delivery_phone'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      trackingNumber: json['tracking_number'],
      courierName: json['courier_name'],
      courierPhone: json['courier_phone'],
      rating: json['order_rating'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  OrderModel copyWith({
    String? status,
    int? rating,
    String? trackingNumber,
  }) {
    return OrderModel(
      orderId: orderId,
      patientId: patientId,
      patientName: patientName,
      items: items,
      totalAmount: totalAmount,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
      paymentMethod: paymentMethod,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      courierName: courierName,
      courierPhone: courierPhone,
      rating: rating ?? this.rating,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'patient_id': patientId,
    'items': items.map((e) => e.toJson()).toList(),
    'delivery_address': deliveryAddress,
    'delivery_city': deliveryCity,
    'delivery_phone': deliveryPhone,
    'payment_method': paymentMethod,
    'total_amount': totalAmount,
    // لا نرسل order_id أو status عادةً لأن السيرفر هو من يحددهما عند الإنشاء
  };
}

 */



/*
// الاول
import 'cart_item_model.dart';
class OrderModel {
  final String orderId;
  final String patientId;
  final String patientName;
  final List<CartItemModel> items;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final String deliveryCity;
  final String deliveryPhone;
  final String paymentMethod;
  final String? trackingNumber;
  final String? courierName;
  final String? courierPhone;
  final int? rating;
  final DateTime createdAt;

  OrderModel({
    required this.orderId,
    required this.patientId,
    required this.patientName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.deliveryPhone,
    required this.paymentMethod,
    this.trackingNumber,
    this.courierName,
    this.courierPhone,
    this.rating,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] ?? json['name'] ?? '',
      patientId: json['patient_id'] ?? '',
      patientName: json['patient_name'] ?? '',
      items: (json['items'] as List?)
          ?.map((item) => CartItemModel.fromJson(item))
          .toList() ??
          [],
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      deliveryAddress: json['delivery_address'] ?? '',
      deliveryCity: json['delivery_city'] ?? '',
      deliveryPhone: json['delivery_phone'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      trackingNumber: json['tracking_number'],
      courierName: json['courier_name'],
      courierPhone: json['courier_phone'],
      rating: json['order_rating'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  OrderModel copyWith({
    String? status,
    int? rating,
    String? trackingNumber,
  }) {
    return OrderModel(
      orderId: orderId,
      patientId: patientId,
      patientName: patientName,
      items: items,
      totalAmount: totalAmount,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
      paymentMethod: paymentMethod,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      courierName: courierName,
      courierPhone: courierPhone,
      rating: rating ?? this.rating,
      createdAt: createdAt,
    );
  }

}


class OrderItem {
  final String itemName;
  final String? description;
  final int quantity;
  final double unitPrice;
  final double amount;

  OrderItem({
    required this.itemName,
    this.description,
    required this.quantity,
    required this.unitPrice,
    required this.amount,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemName: json['item_name'],
      description: json['description'],
      quantity: json['quantity'] ?? 1,
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': itemName,
      'description': description,
      'quantity': quantity,
      'unit_price': unitPrice,
      'amount': amount,
    };
  }
}

 */





