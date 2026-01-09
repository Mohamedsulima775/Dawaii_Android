class CartItemModel {
  final String itemCode;
  final String itemName;
  final int quantity;
  final double price;
  final String? imageUrl;

  CartItemModel({
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['rate'] ?? 0).toDouble(),
      imageUrl: json['image_url'],
    );
  }

  double get total => quantity * price;

  Map<String, dynamic> toJson() => {
    'item_code': itemCode,
    'item_name': itemName,
    'quantity': quantity,
    'rate': price,
    'image_url': imageUrl,
  };

  CartItemModel copyWith({
    int? quantity,
  }) {
    return CartItemModel(
      itemCode: itemCode,
      itemName: itemName,
      quantity: quantity ?? this.quantity,
      price: price,
      imageUrl: imageUrl,
    );
  }

}
