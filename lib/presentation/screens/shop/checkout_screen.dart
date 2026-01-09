// التفعديل النهائي للربط
// lib/presentation/screens/cart/checkout_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/cart_item_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/auth_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  // الحقول النصية للتحكم في الإدخال
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _paymentMethod = 'cash_on_delivery';
  final Color primaryColor = const Color(0xFF2D6A4F);

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  // دالة معالجة الطلب (Logic)
  Future<void> _processOrder() async {
    final cartState = ref.read(cartProvider);
    final authState = ref.read(authProvider);

    // 1. التحقق من الحقول المطلوبة
    if (_addressController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      _showSnackBar('الرجاء تعبئة جميع الحقول المطلوبة', isError: true);
      return;
    }

    try {
      // 2. إرسال الطلب عبر الـ OrderProvider
      await ref.read(orderProvider.notifier).createOrder(
        patientId: authState.patientId ?? "GUEST_USER",
        items: cartState.items,
        deliveryAddress: _addressController.text.trim(),
        deliveryCity: _cityController.text.trim(),
        deliveryPhone: _phoneController.text.trim(),
        deliveryNotes: _notesController.text.trim(),
      );

      // 3. مسح السلة بعد نجاح العملية
      ref.read(cartProvider.notifier).clearCart();

      // 4. التغذية الراجعة والتوجيه
      if (mounted) {
        _showSnackBar('تم إنشاء الطلب بنجاح', isError: false);
        // التوجه للرئيسية أو صفحة نجاح الطلب
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('حدث خطأ أثناء إتمام الطلب: $e', isError: true);
      }
    }
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('إتمام الطلب', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: cartState.isEmpty
          ? const _EmptyCheckout()
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionTitle(title: 'عنوان التوصيل'),
            const SizedBox(height: 12),
            _InputField(
              controller: _addressController,
              label: 'العنوان بالتفصيل',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _InputField(
                    controller: _cityController,
                    label: 'المدينة',
                    icon: Icons.location_city_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InputField(
                    controller: _phoneController,
                    label: 'رقم الهاتف',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'طريقة الدفع'),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: RadioListTile<String>(
                value: 'cash_on_delivery',
                activeColor: primaryColor,
                groupValue: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
                title: const Text('الدفع عند الاستلام'),
                secondary: const Icon(Icons.payments_outlined),
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle(title: 'ملخص الطلب'),
            const SizedBox(height: 8),
            ...cartState.items.map((item) => _OrderItemTile(item: item)),
            const Divider(height: 32),
            _PriceRow(title: 'الإجمالي', value: '${cartState.subtotal.toStringAsFixed(2)} ريال'),
            const SizedBox(height: 8),
            _PriceRow(title: 'رسوم التوصيل', value: '${cartState.deliveryFee.toStringAsFixed(2)} ريال'),
            const Divider(height: 24),
            _PriceRow(
              title: 'المجموع الكلي',
              value: '${cartState.total.toStringAsFixed(2)} ريال',
              isTotal: true,
            ),
            const SizedBox(height: 24),
            _InputField(
              controller: _notesController,
              label: 'ملاحظات إضافية (اختياري)',
              icon: Icons.note_outlined,
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: orderState.isLoading ? null : _processOrder,
                child: orderState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('تأكيد الطلب وشراء', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ============================================
// Widgets المساعدة (Private Widgets)
// ============================================

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    );
  }
}

class _OrderItemTile extends StatelessWidget {
  final CartItemModel item;
  const _OrderItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${item.itemName} (x${item.quantity})', style: const TextStyle(color: Colors.black87)),
          Text('${item.total.toStringAsFixed(2)} ريال', style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF2D6A4F)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _PriceRow({required this.title, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: isTotal ? 18 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: isTotal ? 18 : 15, fontWeight: FontWeight.bold, color: isTotal ? const Color(0xFF2D6A4F) : Colors.black)),
      ],
    );
  }
}

class _EmptyCheckout extends StatelessWidget {
  const _EmptyCheckout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_shopping_cart_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('لا توجد منتجات لإتمام الطلب', style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('العودة للتسوق'),
          )
        ],
      ),
    );
  }
}

/*

 //  الاول


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/cart_item_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';


import 'package:dawaii/presentation/providers/cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _paymentMethod = 'cash_on_delivery';

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    final orderState = ref.watch(orderProvider);
    final orderNotifier = ref.read(orderProvider.notifier);

    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الطلب'),
        centerTitle: true,
      ),
      body: cartState.items.isEmpty
          ? _EmptyCheckout()
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // عنوان التوصيل
            // =========================
            const Text(
              'عنوان التوصيل',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _InputField(
              controller: _addressController,
              label: 'العنوان',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _InputField(
                    controller: _cityController,
                    label: 'المدينة',
                    icon: Icons.location_city_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InputField(
                    controller: _phoneController,
                    label: 'رقم الهاتف',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================
            // طريقة الدفع
            // =========================
            const Text(
              'طريقة الدفع',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            RadioListTile<String>(
              value: 'cash_on_delivery',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() => _paymentMethod = value!);
              },
              title: const Text('الدفع عند الاستلام'),
            ),

            const SizedBox(height: 24),

            // =========================
            // ملخص الطلب
            // =========================
            const Text(
              'ملخص الطلب',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ...cartState.items.map((CartItemModel item) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(item.itemName),
                subtitle: Text('الكمية: ${item.quantity}'),
                trailing: Text(
                  '${item.total.toStringAsFixed(2)} ريال',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }),

            const Divider(height: 32),

            _PriceRow(
              title: 'الإجمالي',
              value:
              '${cartState.subtotal.toStringAsFixed(2)} ريال',
            ),
            const SizedBox(height: 6),
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

            const SizedBox(height: 24),

            // =========================
            // ملاحظات
            // =========================
            _InputField(
              controller: _notesController,
              label: 'ملاحظات (اختياري)',
              icon: Icons.note_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // =========================
            // زر تأكيد الطلب
            // =========================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: orderState.isLoading
                    ? null
                    : () async {
                  if (_addressController.text.isEmpty ||
                      _cityController.text.isEmpty ||
                      _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text('الرجاء تعبئة جميع الحقول المطلوبة'),
                      ),
                    );
                    return;
                  }

                  try {
                    await orderNotifier.createOrder(
                      patientId: authState.patientId!,
                      items: cartState.items,
                      deliveryAddress:
                      _addressController.text,
                      deliveryCity: _cityController.text,
                      deliveryPhone: _phoneController.text,
                      deliveryNotes: _notesController.text,
                    );

                    cartNotifier.clearCart();

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text('تم إنشاء الطلب بنجاح'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('خطأ: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: orderState.isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : const Text('تأكيد الطلب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// Widgets مساعدة
// ============================================

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int maxLines;
  final TextInputType keyboardType;

  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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

class _EmptyCheckout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'لا يوجد عناصر لإتمام الطلب',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}

 */

