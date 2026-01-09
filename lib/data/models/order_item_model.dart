
/*
class OrderItem {
  final String itemCode;
  final String itemName;
  final String? description;
  final int quantity;
  final double price;

  OrderItem({
    required this.itemCode,
    required this.itemName,
    this.description,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      description: json['description'],
      quantity: json['quantity'] ?? 1,
      price: (json['rate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'item_code': itemCode,
    'item_name': itemName,
    'description': description,
    'quantity': quantity,
    'rate': price,
  };
}

 */
