// التفعديل النهائي للربط

import 'package:flutter/material.dart';
import 'package:dawaii/data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    // تحديد الصورة (imageUrl أولًا ثم image ثم صورة افتراضية)
    final imagePath = product.imageUrl ?? product.image ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15)),
                child: imagePath.isNotEmpty
                    ? Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.medication, size: 50, color: Colors.grey),
                  ),
                )
                    : const Center(
                  child: Icon(Icons.medication, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج
                  Text(
                    product.itemName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // السعر
                  Text(
                    'SAR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  // حالة التوفر
                  Text(
                    product.isInStock ? 'متوفر' : 'غير متوفر',
                    style: TextStyle(
                        color: product.isInStock ? Colors.green : Colors.red,
                        fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  // زر الإضافة للسلة
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.isInStock ? onAddToCart : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('أضف'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
// الاول

import 'package:flutter/material.dart';
import 'package:dawaii/data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF2D6A4F);

    // تحديد الصورة (استخدام imageUrl أو image أو صورة افتراضية)
    final imagePath = product.imageUrl ?? product.image ?? '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: imagePath.isNotEmpty
                    ? Image.network(imagePath, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.medication))
                    : const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // استخدام itemName كما هو موجود في الموديل الخاص بك
                  Text(product.itemName, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${product.price} \$', style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  // عرض حالة التوفر بناءً على منطق الموديل الخاص بك
                  Text(product.inStock ? 'متوفر' : 'غير متوفر',
                      style: TextStyle(color: product.inStock ? Colors.green : Colors.red, fontSize: 12)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: product.inStock ? onAddToCart : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                      ),
                      child: const Text('أضف'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */
