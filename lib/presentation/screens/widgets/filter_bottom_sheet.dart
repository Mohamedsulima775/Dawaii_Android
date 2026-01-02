
import 'package:flutter/material.dart';
// استيراد الـ Chip الذي صممته أنت سابقاً
import '../medications/widgets/filter_status_chip.dart';
import 'package:dawaii/presentation/screens/medications/widgets/filter_status_chip.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // متغيرات مؤقتة لحفظ حالة الاختيار (سيتم ربطها بـ Riverpod لاحقاً)
  String selectedCategory = 'الكل';
  bool onlyInStock = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مقبض السحب العلوي
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'تصفية المنتجات',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // قسم حالة التوفر باستخدام الـ Chip الخاص بك
          const Text('حالة المخزون', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              FilterStatusChip(
                label: 'متوفر فقط',
                selected: onlyInStock,
                onTap: () => setState(() => onlyInStock = !onlyInStock),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // قسم التصنيفات (القادمة من ERPNext لاحقاً)
          const Text('التصنيفات', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ['الكل', 'أدوية', 'مكملات', 'أجهزة'].map((cat) {
              return FilterStatusChip(
                label: cat,
                selected: selectedCategory == cat,
                onTap: () => setState(() => selectedCategory = cat),
              );
            }).toList(),
          ),
          const SizedBox(height: 35),

          // أزرار التحكم
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء'),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // هنا سنضع منطق تطبيق الفلتر لاحقاً
                    Navigator.pop(context);
                  },
                  child: const Text('تطبيق'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
