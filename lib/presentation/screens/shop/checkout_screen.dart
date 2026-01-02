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

/*
class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('إتمام الطلب')),
      body: cartState.items.isEmpty
          ? const Center(child: Text('السلة فارغة'))
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartState.items.length,
                itemBuilder: (context, index) {
                  final item = cartState.items[index];
                  return ListTile(
                    leading: item.imageUrl != null
                        ? Image.network(item.imageUrl!, width: 50, height: 50)
                        : const Icon(Icons.medication, size: 50),
                    title: Text(item.itemName),
                    subtitle:
                    Text('الكمية: ${item.quantity} × SAR ${item.price.toStringAsFixed(2)}'),
                    trailing: Text(
                        'SAR ${(item.quantity * item.price).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('المجموع الفرعي'),
              trailing: Text('SAR ${cartState.subtotal.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: const Text('رسوم التوصيل'),
              trailing: Text('SAR ${cartState.deliveryFee.toStringAsFixed(2)}'),
            ),
            ListTile(
              title: const Text('المجموع الكلي', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text('SAR ${cartState.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF2D6A4F))),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cartState.isCreatingOrder
                    ? null
                    : () async {
                  try {
                    final order = await cartNotifier.createOrder(
                      patientId: '123', // استبدل بالـ patientId الحقيقي
                      deliveryAddress: 'شارع الملك فهد، الرياض',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('تم إنشاء الطلب بنجاح')),
                    );

                    // مسح السلة بعد الطلب
                    cartNotifier.clearCart();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('خطأ: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: cartState.isCreatingOrder
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('تأكيد الطلب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */

/*
class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: const Center(child: Text('Checkout Flow Here')),
    );
  }
}

 */

 