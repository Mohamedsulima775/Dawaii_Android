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





/*
class Order {
  final String? name;
  final String patient;
  final String? patientName;
  final String orderDate;
  final String orderStatus; // Pending, Confirmed, Processing, Shipped, Delivered, Cancelled
  final List<OrderItem> items;
  final double totalAmount;
  final double discountAmount;
  final double taxAmount;
  final double grandTotal;
  final String? deliveryAddress;
  final String? deliveryCity;
  final String? deliveryDate;
  final String? deliveryStatus;
  final String? paymentMethod;
  final String? paymentStatus;

  Order({
    this.name,
    required this.patient,
    this.patientName,
    required this.orderDate,
    required this.orderStatus,
    required this.items,
    required this.totalAmount,
    this.discountAmount = 0,
    this.taxAmount = 0,
    required this.grandTotal,
    this.deliveryAddress,
    this.deliveryCity,
    this.deliveryDate,
    this.deliveryStatus,
    this.paymentMethod,
    this.paymentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json['name'],
      patient: json['patient'],
      patientName: json['patient_name'],
      orderDate: json['order_date'],
      orderStatus: json['order_status'] ?? 'Pending',
      items: (json['items'] as List?)
          ?.map((i) => OrderItem.fromJson(i))
          .toList() ??
          [],
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      grandTotal: (json['grand_total'] ?? 0).toDouble(),
      deliveryAddress: json['delivery_address'],
      deliveryCity: json['delivery_city'],
      deliveryDate: json['delivery_date'],
      deliveryStatus: json['delivery_status'],
      paymentMethod: json['payment_method'],
      paymentStatus: json['payment_status'],
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



