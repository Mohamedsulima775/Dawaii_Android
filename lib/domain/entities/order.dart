

// domain/entities/order.dart

class Order {
  final String id;
  final String patientId;
  final String patientName;
  final List<OrderItem> items;
  final double totalAmount;
  final String deliveryAddress;
  final String? deliveryCity;
  final String? deliveryPhone;
  final String? deliveryNotes;
  final DateTime? deliveryDate;
  final String? deliveryTimeSlot;
  final String paymentMethod;
  final OrderStatus status;
  final String? courierName;
  final String? courierPhone;
  final String? trackingNumber;
  final int? rating;
  final String? feedback;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Order({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.items,
    required this.totalAmount,
    required this.deliveryAddress,
    this.deliveryCity,
    this.deliveryPhone,
    this.deliveryNotes,
    this.deliveryDate,
    this.deliveryTimeSlot,
    this.paymentMethod = 'cash_on_delivery',
    this.status = OrderStatus.pending,
    this.courierName,
    this.courierPhone,
    this.trackingNumber,
    this.rating,
    this.feedback,
    required this.createdAt,
    this.updatedAt,
  });

  // Create empty order
  factory Order.empty() {
    return Order(
      id: '',
      patientId: '',
      patientName: '',
      items: const [],
      totalAmount: 0,
      deliveryAddress: '',
      createdAt: DateTime.now(),
    );
  }

  // Copy with method
  Order copyWith({
    String? id,
    String? patientId,
    String? patientName,
    List<OrderItem>? items,
    double? totalAmount,
    String? deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
    DateTime? deliveryDate,
    String? deliveryTimeSlot,
    String? paymentMethod,
    OrderStatus? status,
    String? courierName,
    String? courierPhone,
    String? trackingNumber,
    int? rating,
    String? feedback,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryCity: deliveryCity ?? this.deliveryCity,
      deliveryPhone: deliveryPhone ?? this.deliveryPhone,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTimeSlot: deliveryTimeSlot ?? this.deliveryTimeSlot,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      courierName: courierName ?? this.courierName,
      courierPhone: courierPhone ?? this.courierPhone,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Get total items count
  int get itemsCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Check if order is pending
  bool get isPending => status == OrderStatus.pending;

  // Check if order is processing
  bool get isProcessing => status == OrderStatus.processing;

  // Check if order is shipped
  bool get isShipped => status == OrderStatus.shipped;

  // Check if order is delivered
  bool get isDelivered => status == OrderStatus.delivered;

  // Check if order is cancelled
  bool get isCancelled => status == OrderStatus.cancelled;

  // Check if order can be cancelled
  bool get canBeCancelled {
    return status == OrderStatus.pending || status == OrderStatus.processing;
  }

  // Check if order can be rated
  bool get canBeRated {
    return status == OrderStatus.delivered && rating == null;
  }

  // Get estimated delivery date
  DateTime? get estimatedDeliveryDate {
    if (deliveryDate != null) return deliveryDate;

    // Default: 2 days from order creation
    return createdAt.add(const Duration(days: 2));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Order(id: $id, status: $status, total: $totalAmount, items: ${items.length})';
  }
}

// Order item model
class OrderItem {
  final String itemCode;
  final String itemName;
  final int quantity;
  final double price;
  final String? image;
  final String? notes;

  const OrderItem({
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.price,
    this.image,
    this.notes,
  });

  // Get subtotal
  double get subtotal => quantity * price;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem && other.itemCode == itemCode;
  }

  @override
  int get hashCode => itemCode.hashCode;

  @override
  String toString() {
    return 'OrderItem(code: $itemCode, name: $itemName, qty: $quantity, price: $price)';
  }
}

// Order status enum
enum OrderStatus {
  pending,
  processing,
  readyForDelivery,
  shipped,
  delivered,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'قيد الانتظار';
      case OrderStatus.processing:
        return 'قيد التجهيز';
      case OrderStatus.readyForDelivery:
        return 'جاهز للتوصيل';
      case OrderStatus.shipped:
        return 'في الطريق';
      case OrderStatus.delivered:
        return 'تم التسليم';
      case OrderStatus.cancelled:
        return 'ملغي';
    }
  }

  String get emoji {
    switch (this) {
      case OrderStatus.pending:
        return '⏳';
      case OrderStatus.processing:
        return '📦';
      case OrderStatus.readyForDelivery:
        return '✅';
      case OrderStatus.shipped:
        return '🚚';
      case OrderStatus.delivered:
        return '🎉';
      case OrderStatus.cancelled:
        return '❌';
    }
  }
}
