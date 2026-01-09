/// يحتوي على بيانات السلة
// التعديل للربط

// lib/presentation/providers/cart_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product.dart';

// ============================================
// Cart State
// ============================================

class CartState {
  final List<CartItemModel> items;
  final String? error;

  const CartState({
    this.items = const [],
    this.error,
  });

  CartState copyWith({
    List<CartItemModel>? items,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      error: error,
    );
  }

  // =========================
  // Calculations
  // =========================

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.total);

  double get deliveryFee => items.isEmpty ? 0 : 20.0;

  double get total => subtotal + deliveryFee;

  bool get isEmpty => items.isEmpty;
}

// ============================================
// Provider
// ============================================

final cartProvider =
StateNotifierProvider<CartNotifier, CartState>(
      (ref) => CartNotifier(),
);

// ============================================
// Notifier
// ============================================

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  // =========================
  // Add from Product
  // =========================

  void addProduct(Product product) {
    final index = state.items.indexWhere(
          (e) => e.itemCode == product.id,
    );

    if (index >= 0) {
      increaseQuantity(product.id!);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CartItemModel(
            itemCode: product.id!,
            itemName: product.itemName,
            quantity: 1,
            price: product.price,
            imageUrl: product.imageUrl,
          ),
        ],
      );
    }
  }

  // =========================
  // Quantity Actions
  // =========================

  void increaseQuantity(String itemCode) {
    state = state.copyWith(
      items: state.items.map((item) {
        if (item.itemCode == itemCode) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList(),
    );
  }

  void decreaseQuantity(String itemCode) {
    state = state.copyWith(
      items: state.items
          .map((item) {
        if (item.itemCode == itemCode && item.quantity > 1) {
          return item.copyWith(quantity: item.quantity - 1);
        }
        return item;
      })
          .toList(),
    );
  }

  void removeItem(String itemCode) {
    state = state.copyWith(
      items: state.items.where((e) => e.itemCode != itemCode).toList(),
    );
  }

  void clearCart() {
    state = const CartState();
  }
}


/*

// الاول
// lib/presentation/providers/cart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/cart_item_model.dart';
import 'auth_provider.dart';
import 'order_provider.dart';

// ==========================================
// Cart State
// ============================================

class CartState {
  final List<CartItemModel> items;
  final bool isCreatingOrder;
  final String? error;

  const CartState({
    this.items = const [],
    this.isCreatingOrder = false,
    this.error,
  });

  CartState copyWith({
    List<CartItemModel>? items,
    bool? isCreatingOrder,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      error: error,
    );
  }

  // =========================
  // Calculations
  // =========================
  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.total);

  double get deliveryFee => items.isEmpty ? 0 : 20.0;

  double get total => subtotal + deliveryFee;

  bool get isEmpty => items.isEmpty;
}

// ============================================
// Cart Provider
// ============================================

final cartProvider =
StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref)..loadDummyItems(); // 👈 هنا
});

// ============================================
// Cart Notifier
// ============================================

class CartNotifier extends StateNotifier<CartState> {
  final Ref ref;

  CartNotifier(this.ref) : super(const CartState());

  // =========================
  // 🔹 Dummy Products (للتصميم)
  // =========================
  void loadDummyItems() {
    if (state.items.isNotEmpty) return;

    state = state.copyWith(
      items: [
        CartItemModel(
          itemCode: 'MED-001',
          itemName: 'باراسيتامول 500mg',
          quantity: 2,
          price: 15.0,
        ),
        CartItemModel(
          itemCode: 'MED-002',
          itemName: 'فيتامين C',
          quantity: 1,
          price: 25.0,
        ),
        CartItemModel(
          itemCode: 'MED-003',
          itemName: 'شراب كحة',
          quantity: 1,
          price: 30.0,
        ),
      ],
    );
  }

  // =========================
  // Cart Actions
  // =========================

  void addItem(CartItemModel item) {
    final index =
    state.items.indexWhere((e) => e.itemCode == item.itemCode);

    if (index >= 0) {
      final updatedItems = [...state.items];
      final existing = updatedItems[index];

      updatedItems[index] = CartItemModel(
        itemCode: existing.itemCode,
        itemName: existing.itemName,
        quantity: existing.quantity + 1,
        price: existing.price,
        imageUrl: existing.imageUrl,
      );

      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [...state.items, item]);
    }
  }

  void increaseQuantity(String itemCode) {
    final updatedItems = state.items.map((item) {
      if (item.itemCode == itemCode) {
        return CartItemModel(
          itemCode: item.itemCode,
          itemName: item.itemName,
          quantity: item.quantity + 1,
          price: item.price,
          imageUrl: item.imageUrl,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  void decreaseQuantity(String itemCode) {
    final updatedItems = state.items
        .map((item) {
      if (item.itemCode == itemCode && item.quantity > 1) {
        return CartItemModel(
          itemCode: item.itemCode,
          itemName: item.itemName,
          quantity: item.quantity - 1,
          price: item.price,
          imageUrl: item.imageUrl,
        );
      }
      return item;
    })
        .toList();

    state = state.copyWith(items: updatedItems);
  }

  void removeItem(String itemCode) {
    state = state.copyWith(
      items: state.items.where((e) => e.itemCode != itemCode).toList(),
    );
  }

  void clearCart() {
    state = state.copyWith(items: []);
  }

  // =========================
  // Create Order
  // =========================

  Future<void> checkout({
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
  }) async {
    if (state.isEmpty) {
      state = state.copyWith(error: 'السلة فارغة');
      return;
    }

    final authState = ref.read(authProvider);
    final orderNotifier = ref.read(orderProvider.notifier);

    state = state.copyWith(isCreatingOrder: true, error: null);

    await orderNotifier.createOrder(
      patientId: authState.patientId!,
      items: state.items,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
    );

    state = state.copyWith(isCreatingOrder: false);
    clearCart();
  }
}

 */

