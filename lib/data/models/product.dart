class Product {
   final String? id;
  final String? name;
  final String itemName;
  final String? description;
  final double price;
   //final bool inStock;
  final int stock;
  final String? category;
  final String? image;
  final List<String>? images;
  final double? rating;
  final int? reviewsCount;

  Product({
    //this.id,
   required this.id,
    this.name,
    required this.itemName,
    this.description,
    required this.price,
    required this.stock,
    //required this.inStock,
    this.category,
    this.image,
    this.images,
    this.rating,
    this.reviewsCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      itemName: json['item_name'],
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      stock: json['stock'] ?? 0,
      category: json['category'],
      image: json['image'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      rating: json['rating']?.toDouble(),
      reviewsCount: json['reviews_count'], id: '',
    );
  }

  bool get inStock => stock > 0;
}