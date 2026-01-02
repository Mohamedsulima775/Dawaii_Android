/// يحتوي على بيانات السلة

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/cart_item_model.dart';


//import '../../data/models/cart_item_model.dart';
//import '../../data/models/order_model.dart';

//import '../../core/network/api_client.dart';
//import '../../data/repositories/order_repositoryImpl.dart';
//import '../../data/repositories/order_mapper.dart';
//import '../../data/repositories/order_repositoryImpl.dart';
//import '../../domain/entities/order.dart';
import 'auth_provider.dart';
import 'order_provider.dart';

// lib/presentation/providers/cart_provider.dart

//import 'package:flutter_riverpod/flutter_riverpod.dart';

//import '../../data/models/order_model.dart';
//import '../../data/repositories/order_repository.dart';
//import '../../core/network/api_client.dart';
//import 'package:dawaii/core/errors/exceptions.dart';

// ============================================
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
/*
/// ================================
/// State
/// ================================
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
    bool clearError = false,
  }) {
    return CartState(
      items: items ?? this.items,
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      error: clearError ? null : (error ?? this.error),
    );
  }

  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

  double get deliveryFee => 20.0; // ثابت، يمكن تعديله حسب مشروعك

  double get total => subtotal + deliveryFee;
}

/// ================================
/// Provider
/// ================================
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return CartNotifier(repository);
});

/// ================================
/// Notifier
/// ================================
class CartNotifier extends StateNotifier<CartState> {
  final OrderRepository _repository;

  CartNotifier(this._repository) : super(const CartState());

  /// إضافة عنصر للسلة
  void addItem(CartItemModel item) {
    final existingIndex =
    state.items.indexWhere((element) => element.itemCode == item.itemCode);

    if (existingIndex >= 0) {
      final updatedItems = [...state.items];
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] =
          CartItemModel(
            itemCode: existingItem.itemCode,
            itemName: existingItem.itemName,
            price: existingItem.price,
            quantity: existingItem.quantity + item.quantity,
            imageUrl: existingItem.imageUrl,
          );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(items: [...state.items, item]);
    }
  }

  /// إزالة عنصر من السلة
  void removeItem(String itemCode) {
    final updatedItems =
    state.items.where((item) => item.itemCode != itemCode).toList();
    state = state.copyWith(items: updatedItems);
  }

  /// تغيير كمية عنصر
  void updateQuantity(String itemCode, int quantity) {
    final updatedItems = state.items.map((item) {
      if (item.itemCode == itemCode) {
        return CartItemModel(
          itemCode: item.itemCode,
          itemName: item.itemName,
          price: item.price,
          quantity: quantity,
          imageUrl: item.imageUrl,
        );
      }
      return item;
    }).toList();

    state = state.copyWith(items: updatedItems);
  }

  /// إنشاء طلب جديد
  Future<OrderModel> createOrder({
    required String patientId,
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String paymentMethod = 'عند الاستلام',
    String? deliveryNotes,
  }) async {
    if (state.items.isEmpty) {
      throw Exception('السلة فارغة');
    }

    state = state.copyWith(isCreatingOrder: true, clearError: true);

    try {
      // تحويل CartItemModel إلى OrderItem المطلوب في الريبو
      final orderItems = state.items.map((item) {
        return OrderItem(
          itemCode: item.itemCode,
          itemName: item.itemName,
          quantity: item.quantity,
          price: item.price,
        );
      }).toList();

      final result = await _repository.createOrder(
        patientId: patientId,
        items: orderItems,
        deliveryAddress: deliveryAddress,
        deliveryCity: deliveryCity,
        deliveryPhone: deliveryPhone,
        paymentMethod: paymentMethod,
        deliveryNotes: deliveryNotes,
      );

      return result.fold(
            (failure) => throw Exception(failure.message),
            (order) => order.toModel(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isCreatingOrder: false);
    }
  }

  /// مسح السلة
  void clearCart() {
    state = state.copyWith(items: []);
  }
}
*/

