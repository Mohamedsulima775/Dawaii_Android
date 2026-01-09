// التعديل للربط

// lib/presentation/screens/cart/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/providers/cart_provider.dart';
import 'cart_item_card.dart';
import '../../../data/models/cart_item_model.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        centerTitle: true,
      ),
      body: cartState.items.isEmpty
          ? const _EmptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartState.items.length,
              itemBuilder: (context, index) {
                final CartItemModel item = cartState.items[index];

                return CartItemCard(
                  productName: item.itemName,
                  imageUrl: item.imageUrl,
                  price: item.price,
                  quantity: item.quantity,
                  onIncrease: () =>
                      cartNotifier.increaseQuantity(item.itemCode),
                  onDecrease: () =>
                      cartNotifier.decreaseQuantity(item.itemCode),
                  onRemove: () => cartNotifier.removeItem(item.itemCode),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                _PriceRow(
                  title: 'الإجمالي',
                  value:
                  '${cartState.subtotal.toStringAsFixed(2)} ريال',
                ),
                const SizedBox(height: 8),
                _PriceRow(
                  title: 'رسوم التوصيل',
                  value:
                  '${cartState.deliveryFee.toStringAsFixed(2)} ريال',
                ),
                const Divider(height: 24),
                _PriceRow(
                  title: 'المجموع الكلي',
                  value: '${cartState.total.toStringAsFixed(2)} ريال',
                  isTotal: true,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/shop/checkout');
                    },
                    child: const Text('إتمام الشراء'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF2D6A4F) : null,
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'السلة فارغة',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}



/*
// الاول
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:dawaii/presentation/providers/cart_provider.dart';

import '../../../data/models/cart_item_model.dart';
import 'checkout_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة المشتريات'),
        centerTitle: true,
      ),
      body: cartState.items.isEmpty
          ? _EmptyCart()
          : Column(
        children: [
          // =========================
          // قائمة المنتجات
          // =========================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cartState.items.length,
              itemBuilder: (context, index) {
                final CartItemModel item = cartState.items[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // صورة / أيقونة
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.medication,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // الاسم والسعر
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.price.toStringAsFixed(2)} ريال',
                                style: const TextStyle(
                                  color: Color(0xFF2D6A4F),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // التحكم بالكمية
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                cartNotifier.decreaseQuantity(
                                  item.itemCode,
                                );
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                              ),
                            ),
                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartNotifier.increaseQuantity(
                                  item.itemCode,
                                );
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // =========================
          // ملخص السعر
          // =========================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                _PriceRow(
                  title: 'الإجمالي',
                  value:
                  '${cartState.subtotal.toStringAsFixed(2)} ريال',
                ),
                const SizedBox(height: 8),
                _PriceRow(
                  title: 'رسوم التوصيل',
                  value:
                  '${cartState.deliveryFee.toStringAsFixed(2)} ريال',
                ),
                const Divider(height: 24),
                _PriceRow(
                  title: 'المجموع الكلي',
                  value:
                  '${cartState.total.toStringAsFixed(2)} ريال',
                  isTotal: true,
                ),
                const SizedBox(height: 16),

                // زر المتابعة
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/shop/checkout');
                    },
                    child: const Text('إتمام الشراء'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================
// عناصر مساعدة
// ============================================

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF2D6A4F) : null,
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'السلة فارغة',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

 */


