
// order_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/order_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/order_repositoryImpl.dart';
import '../../core/network/api_client.dart';
import 'package:dawaii/data/repositories/order_mapper.dart';
import '../../domain/entities/order.dart';
// ============================================
// State: يعتمد الآن كلياً على الـ Models
// ============================================

class OrderState {
  final List<OrderModel> orders;
  final OrderModel? currentOrder;
  final bool isLoading;
  final String? error;

  const OrderState({
    this.orders = const [],
    this.currentOrder,
    this.isLoading = false,
    this.error,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    OrderModel? currentOrder,
    bool? isLoading,
    String? error,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      currentOrder: currentOrder ?? this.currentOrder,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ============================================
// Providers
// ============================================

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OrderRepositoryImpl(apiClient: apiClient);
});

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(ref.read(orderRepositoryProvider));
});

// ============================================
// Notifier: يتعامل مع الـ Models مباشرة دون Mapper
// ============================================

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository _repository;

  OrderNotifier(this._repository) : super(const OrderState());

  // جلب الطلبات مباشرة كموديلات
  Future<void> loadOrders({required String patientId, String? status}) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getOrders(patientId: patientId, status: status);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (orders) => state = state.copyWith(isLoading: false, orders: orders), // الارتباط المباشر هنا
    );
  }

  // جلب تفاصيل الطلب مباشرة كموديل
  Future<void> loadOrderDetail(String orderId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getOrderById(orderId);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (order) => state = state.copyWith(isLoading: false, currentOrder: order),
    );
  }

  // إنشاء الطلب باستخدام بيانات السلة مباشرة
  Future<void> createOrder({
    required String patientId,
    required List<CartItemModel> items, // استخدام الموديل القادم من السلة مباشرة
    required String deliveryAddress,
    String? deliveryCity,
    String? deliveryPhone,
    String? deliveryNotes,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    // تحويل عناصر السلة إلى عناصر طلب بشكل مباشر وسريع
    final orderItems = items.map((e) => OrderItem(
      itemCode: e.itemCode,
      itemName: e.itemName,
      quantity: e.quantity,
      price: e.price,
    )).toList();

    final result = await _repository.createOrder(
      patientId: patientId,
      items: orderItems,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryPhone: deliveryPhone,
      deliveryNotes: deliveryNotes,
      paymentMethod: 'cash_on_delivery',
    );

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (order) {
        state = state.copyWith(
          isLoading: false,
          currentOrder: order,
          orders: [order, ...state.orders],
        );
      },
    );
  }
}




/*
// ============================================
// State Classes
// ============================================

/// حالة الطلبات
class OrderState {
  final List<OrderModel> orders;
  final OrderModel? currentOrder;
  final bool isLoading;
  final String? error;
  final bool isCreatingOrder;
  final bool isRefreshing;

  const OrderState({
    this.orders = const [],
    this.currentOrder,
    this.isLoading = false,
    this.error,
    this.isCreatingOrder = false,
    this.isRefreshing = false,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    OrderModel? currentOrder,
    bool? isLoading,
    String? error,
    bool? isCreatingOrder,
    bool? isRefreshing,
    bool clearError = false,
    bool clearCurrentOrder = false,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      currentOrder: clearCurrentOrder ? null : (currentOrder ?? this.currentOrder),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      isCreatingOrder: isCreatingOrder ?? this.isCreatingOrder,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

// ============================================
// Providers
// ============================================

/// Order Repository Provider
final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OrderRepositoryImpl(apiClient: apiClient);
});

/// Order Provider - State Notifier
final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderNotifier(repository: repository);
});

/// Provider للطلبات النشطة فقط
final activeOrdersProvider = Provider<List<OrderModel>>((ref) {
  final state = ref.watch(orderProvider);
  return state.orders.where((order) =>
  order.status != 'Completed' &&
      order.status != 'Cancelled'
  ).toList();
});

/// Provider لعدد الطلبات الجارية
final activeOrdersCountProvider = Provider<int>((ref) {
  final activeOrders = ref.watch(activeOrdersProvider);
  return activeOrders.length;
});

/// Provider لآخر طلب
final lastOrderProvider = Provider<OrderModel?>((ref) {
  final state = ref.watch(orderProvider);
  if (state.orders.isEmpty) return null;
  return state.orders.first;
});

// ============================================
// Order Notifier - State Management
// ============================================

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepositoryImpl _repository;

  OrderNotifier({
    required OrderRepositoryImpl repository,
  })  : _repository = repository,
        super(const OrderState());

  // ==========================================
  // Public Methods
  // ==========================================

  /// تحميل طلبات المريض
  Future<void> loadOrders({
    required String patientId,
    String? status,
    bool refresh = false,
  }) async {
    if (refresh) {
      state = state.copyWith(isRefreshing: true, clearError: true);
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    try {
      final orders = await _repository.getOrders(
        patientId: patientId,
        status: status,
      );

      state = state.copyWith(
        orders: orders,
        isLoading: false,
        isRefreshing: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        isRefreshing: false,
      );
      rethrow;
    }
  }

  /// تحميل تفاصيل طلب محدد
  Future<void> loadOrderDetail({
    required String orderId,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final order = await _repository.getOrderDetail(orderId: orderId);

      state = state.copyWith(
        currentOrder: order,
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      rethrow;
    }
  }

  /// إنشاء طلب جديد
  Future<OrderModel> createOrder({
    required String patientId,
    required List<CartItemModel> items,
    required String deliveryAddress,
    required String deliveryCity,
    required String deliveryPhone,
    required String paymentMethod,
    String? prescriptionId,
    String? deliveryNotes,
  }) async {
    state = state.copyWith(isCreatingOrder: true, clearError: true);

    try {
      final order = await _repository.createOrder(
        patientId: patientId,
        items: items,
        deliveryAddress: deliveryAddress,
        deliveryCity: deliveryCity,
        deliveryPhone: deliveryPhone,
        paymentMethod: paymentMethod,
        prescriptionId: prescriptionId,
        deliveryNotes: deliveryNotes,
      );

      // إضافة الطلب الجديد للقائمة
      final updatedOrders = [order, ...state.orders];

      state = state.copyWith(
        orders: updatedOrders,
        currentOrder: order,
        isCreatingOrder: false,
        clearError: true,
      );

      return order;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isCreatingOrder: false,
      );
      rethrow;
    }
  }

  /// إلغاء طلب
  Future<bool> cancelOrder({
    required String orderId,
    String? reason,
  }) async {
    try {
      final success = await _repository.cancelOrder(
        orderId: orderId,
        reason: reason,
      );

      if (success) {
        // تحديث حالة الطلب في القائمة
        final updatedOrders = state.orders.map((order) {
          if (order.orderId == orderId) {
            return order.copyWith(status: 'Cancelled');
          }
          return order;
        }).toList();

        // تحديث الطلب الحالي إذا كان نفسه
        OrderModel? updatedCurrentOrder = state.currentOrder;
        if (state.currentOrder?.orderId == orderId) {
          updatedCurrentOrder = state.currentOrder!.copyWith(status: 'Cancelled');
        }

        state = state.copyWith(
          orders: updatedOrders,
          currentOrder: updatedCurrentOrder,
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// تقييم طلب
  Future<bool> rateOrder({
    required String orderId,
    required int rating,
    String? feedback,
  }) async {
    try {
      final success = await _repository.rateOrder(
        orderId: orderId,
        rating: rating,
        feedback: feedback,
      );

      if (success) {
        // تحديث التقييم في القائمة
        final updatedOrders = state.orders.map((order) {
          if (order.orderId == orderId) {
            return order.copyWith(rating: rating);
          }
          return order;
        }).toList();

        state = state.copyWith(orders: updatedOrders);
      }

      return success;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// تأكيد استلام الطلب
  Future<bool> confirmDelivery({
    required String orderId,
  }) async {
    try {
      final success = await _repository.confirmDelivery(orderId: orderId);

      if (success) {
        // تحديث حالة الطلب
        final updatedOrders = state.orders.map((order) {
          if (order.orderId == orderId) {
            return order.copyWith(status: 'Completed');
          }
          return order;
        }).toList();

        state = state.copyWith(orders: updatedOrders);
      }

      return success;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  /// إعادة طلب
  Future<OrderModel> reorder({
    required String orderId,
  }) async {
    state = state.copyWith(isCreatingOrder: true, clearError: true);

    try {
      final newOrder = await _repository.reorder(orderId: orderId);

      // إضافة الطلب الجديد
      final updatedOrders = [newOrder, ...state.orders];

      state = state.copyWith(
        orders: updatedOrders,
        currentOrder: newOrder,
        isCreatingOrder: false,
        clearError: true,
      );

      return newOrder;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isCreatingOrder: false,
      );
      rethrow;
    }
  }

  /// مسح الخطأ
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// مسح الطلب الحالي
  void clearCurrentOrder() {
    state = state.copyWith(clearCurrentOrder: true);
  }

  /// إعادة تحميل الطلبات
  Future<void> refresh({required String patientId}) async {
    await loadOrders(patientId: patientId, refresh: true);
  }

  /// تصفية الطلبات حسب الحالة
  void filterByStatus(String? status) {
    // يمكن إضافة منطق التصفية هنا
    // أو استخدام Provider منفصل للتصفية
  }

  /// البحث في الطلبات
  List<OrderModel> searchOrders(String query) {
    if (query.isEmpty) return state.orders;

    final lowercaseQuery = query.toLowerCase();
    return state.orders.where((order) {
      return order.orderId.toLowerCase().contains(lowercaseQuery) ||
          order.items.any((item) =>
              item.itemName.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  /// حساب المجموع الكلي لجميع الطلبات
  double getTotalSpent() {
    return state.orders.fold(0.0, (sum, order) => sum + order.totalAmount);
  }

  /// الحصول على الطلبات حسب الحالة
  List<OrderModel> getOrdersByStatus(String status) {
    return state.orders.where((order) => order.status == status).toList();
  }
}

// ============================================
// Helper Providers
// ============================================

/// Provider للطلبات المكتملة
final completedOrdersProvider = Provider<List<OrderModel>>((ref) {
  final state = ref.watch(orderProvider);
  return state.orders.where((order) => order.status == 'Completed').toList();
});

/// Provider للطلبات الملغاة
final cancelledOrdersProvider = Provider<List<OrderModel>>((ref) {
  final state = ref.watch(orderProvider);
  return state.orders.where((order) => order.status == 'Cancelled').toList();
});

/// Provider لإجمالي المبلغ المدفوع
final totalSpentProvider = Provider<double>((ref) {
  final completedOrders = ref.watch(completedOrdersProvider);
  return completedOrders.fold(0.0, (sum, order) => sum + order.totalAmount);
});

/// Provider لحالة التحميل
final isOrderLoadingProvider = Provider<bool>((ref) {
  final state = ref.watch(orderProvider);
  return state.isLoading || state.isCreatingOrder;
});

/// Provider للأخطاء
final orderErrorProvider = Provider<String?>((ref) {
  final state = ref.watch(orderProvider);
  return state.error;
});

 */
