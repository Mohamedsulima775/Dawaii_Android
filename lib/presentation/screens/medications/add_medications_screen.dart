
// lib/screens/add_medication_screen.dart
/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/medication_service.dart';


class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medicationService = MedicationService();

  // Controllers
  final _medicationNameController = TextEditingController();
  final _scientificNameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _initialStockController = TextEditingController();

  // Selected values
  String _selectedFrequency = 'Daily';
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;
  List<TimeOfDay> _reminderTimes = [];

  bool _isLoading = false;

  final List<String> _frequencies = [
    'Daily',
    'Twice Daily',
    'Three Times Daily',
    'Weekly',
    'As Needed',
  ];

  final Map<String, String> _frequencyArabic = {
    'Daily': 'يومي',
    'Twice Daily': 'مرتين يومياً',
    'Three Times Daily': '3 مرات يومياً',
    'Weekly': 'أسبوعي',
    'As Needed': 'عند الحاجة',
  };

  @override
  void dispose() {
    _medicationNameController.dispose();
    _scientificNameController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    _initialStockController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() => _startDate = date);
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate.add(const Duration(days: 30)),
      firstDate: _startDate,
      lastDate: _startDate.add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() => _endDate = date);
    }
  }

  Future<void> _addReminderTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => _reminderTimes.add(time));
    }
  }

  void _removeReminderTime(int index) {
    setState(() => _reminderTimes.removeAt(index));
  }

  Future<void> _saveMedication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _medicationService.addMedication(
        medicationName: _medicationNameController.text,
        dosage: _dosageController.text,
        frequency: _selectedFrequency,
        startDate: _startDate,
        initialStock: int.parse(_initialStockController.text),
        scientificName: _scientificNameController.text.isEmpty
            ? null
            : _scientificNameController.text,
        instructions: _instructionsController.text.isEmpty
            ? null
            : _instructionsController.text,
        endDate: _endDate,
        reminderTimes: _reminderTimes.isEmpty
            ? null
            : _reminderTimes
            .map((t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}')
            .toList(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إضافة الدواء بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة دواء جديد'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Medication name
            _buildTextField(
              controller: _medicationNameController,
              label: 'اسم الدواء *',
              hint: 'مثال: باراسيتامول',
              icon: Icons.medication,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال اسم الدواء';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Scientific name
            _buildTextField(
              controller: _scientificNameController,
              label: 'الاسم العلمي',
              hint: 'مثال: Paracetamol',
              icon: Icons.science,
            ),

            const SizedBox(height: 16),

            // Dosage
            _buildTextField(
              controller: _dosageController,
              label: 'الجرعة *',
              hint: 'مثال: 500mg',
              icon: Icons.local_pharmacy,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال الجرعة';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Frequency
            DropdownButtonFormField<String>(
              value: _selectedFrequency,
              decoration: InputDecoration(
                labelText: 'التكرار *',
                prefixIcon: const Icon(Icons.access_time),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: _frequencies.map((freq) {
                return DropdownMenuItem(
                  value: freq,
                  child: Text(_frequencyArabic[freq] ?? freq),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedFrequency = value!);
              },
            ),

            const SizedBox(height: 16),

            // Initial stock
            _buildTextField(
              controller: _initialStockController,
              label: 'الكمية الأولية *',
              hint: 'عدد الحبات',
              icon: Icons.inventory_2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال الكمية';
                }
                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                  return 'الرجاء إدخال رقم صحيح';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Start date
            _buildDateField(
              label: 'تاريخ البدء',
              date: _startDate,
              onTap: _selectStartDate,
            ),

            const SizedBox(height: 16),

            // End date
            _buildDateField(
              label: 'تاريخ الانتهاء (اختياري)',
              date: _endDate,
              onTap: _selectEndDate,
              canClear: true,
              onClear: () => setState(() => _endDate = null),
            ),

            const SizedBox(height: 16),

            // Instructions
            _buildTextField(
              controller: _instructionsController,
              label: 'التعليمات',
              hint: 'مثال: قبل الأكل بنصف ساعة',
              icon: Icons.info_outline,
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            // Reminder times section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.alarm, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'أوقات التذكير',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _addReminderTime,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('إضافة'),
                        ),
                      ],
                    ),
                    if (_reminderTimes.isEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'لم يتم إضافة أوقات تذكير',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _reminderTimes.asMap().entries.map((entry) {
                          return Chip(
                            label: Text(
                              entry.value.format(context),
                              style: const TextStyle(fontSize: 14),
                            ),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () => _removeReminderTime(entry.key),
                            backgroundColor: Colors.blue.shade50,
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Save button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveMedication,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text(
                  'حفظ الدواء',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    IconData? icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    bool canClear = false,
    VoidCallback? onClear,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today),
          suffixIcon: canClear && date != null
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20),
            onPressed: onClear,
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          date != null
              ? '${date.day}/${date.month}/${date.year}'
              : 'اختر تاريخ',
          style: TextStyle(
            color: date != null ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
*/



//الاول

/*
//الاول
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _stockController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedFrequency;
  String? _selectedMealTime;
  List<TimeOfDay> _selectedTimes = [];
  bool _isLoading = false;

  final List<String> _frequencies = [
    'Once Daily',
    'Twice Daily',
    'Three Times Daily',
    'Four Times Daily',
    'As Needed',
  ];

  final List<String> _mealTimes = [
    'Before Meal',
    'After Meal',
    'Anytime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medication'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medication Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name *',
                  hintText: 'e.g., Glucophage',
                  prefixIcon: Icon(Icons.medication),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Dosage
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage *',
                  hintText: 'e.g., 500mg',
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Frequency
              DropdownButtonFormField<String>(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency *',
                  prefixIcon: Icon(Icons.schedule),
                ),
                items: _frequencies.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrequency = value;
                    _selectedTimes = []; // Reset times
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select frequency';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Times
              if (_selectedFrequency != null &&
                  _selectedFrequency != 'As Needed')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Times *',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              setState(() {
                                _selectedTimes.add(time);
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Time'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_selectedTimes.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Center(
                          child: Text(
                            'No times added yet',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _selectedTimes
                            .asMap()
                            .entries
                            .map((entry) => Chip(
                          label: Text(entry.value.format(context)),
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() {
                              _selectedTimes.removeAt(entry.key);
                            });
                          },
                        ))
                            .toList(),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),

              // Meal Time
              DropdownButtonFormField<String>(
                value: _selectedMealTime,
                decoration: const InputDecoration(
                  labelText: 'Meal Time',
                  prefixIcon: Icon(Icons.restaurant),
                ),
                items: _mealTimes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMealTime = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Duration
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration',
                  hintText: 'e.g., 3 months, Continuous',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),

              const SizedBox(height: 16),

              // Stock
              TextFormField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Stock *',
                  hintText: 'Number of pills',
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Notes
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Any special instructions...',
                  prefixIcon: Icon(Icons.note),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveMedication,
                  child: _isLoading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text('Save Medication'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMedication() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedFrequency != 'As Needed' && _selectedTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one time')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Call medication service
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Medication added successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _stockController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

 */



import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _stockController = TextEditingController();
  final _durationController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedFrequency;
  String? _selectedMealTime;
  List<TimeOfDay> _selectedTimes = [];
  DateTime? _startDate;

  bool _isLoading = false;

  final List<String> _frequencies = [
    'Once Daily',
    'Twice Daily',
    'Three Times Daily',
    'Four Times Daily',
    'As Needed',
  ];

  final List<String> _mealTimes = [
    'Before Meal',
    'After Meal',
    'Anytime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Add Treatment'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // ================= Medication Info =================
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Medication Information',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Medication Name *',
                          prefixIcon: Icon(Icons.medication),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _dosageController,
                        decoration: const InputDecoration(
                          labelText: 'Dosage *',
                          hintText: 'e.g. 500 mg',
                          prefixIcon: Icon(Icons.science),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= Treatment Plan =================
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Treatment Plan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: _selectedFrequency,
                        decoration: const InputDecoration(
                          labelText: 'Frequency *',
                          prefixIcon: Icon(Icons.schedule),
                          border: OutlineInputBorder(),
                        ),
                        items: _frequencies
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            _selectedFrequency = v;
                            _selectedTimes.clear();
                          });
                        },
                        validator: (v) => v == null ? 'Required' : null,
                      ),

                      if (_selectedFrequency != null &&
                          _selectedFrequency != 'As Needed') ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Add Time'),
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() => _selectedTimes.add(time));
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        _selectedTimes.isEmpty
                            ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Text(
                            'No times added',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                            : Wrap(
                          spacing: 8,
                          children: _selectedTimes
                              .map(
                                (t) => Chip(
                              label: Text(t.format(context)),
                              backgroundColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.12),
                              deleteIcon: const Icon(Icons.close),
                              onDeleted: () {
                                setState(() => _selectedTimes.remove(t));
                              },
                            ),
                          )
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= Meal & Duration =================
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Instructions',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        value: _selectedMealTime,
                        decoration: const InputDecoration(
                          labelText: 'Meal Time',
                          prefixIcon: Icon(Icons.restaurant),
                          border: OutlineInputBorder(),
                        ),
                        items: _mealTimes
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedMealTime = v),
                      ),

                      const SizedBox(height: 12),

                      InkWell(
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                            DateTime.now().add(const Duration(days: 365 * 5)),
                          );
                          if (date != null) {
                            setState(() => _startDate = date);
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _startDate == null
                                ? 'Select start date'
                                : '${_startDate!.year}-${_startDate!.month}-${_startDate!.day}',
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _durationController,
                        decoration: const InputDecoration(
                          labelText: 'Duration',
                          hintText: 'e.g. 7 days / 1 month',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= Stock & Notes =================
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Additional Details',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _stockController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Stock *',
                          prefixIcon: Icon(Icons.inventory),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        v == null || int.tryParse(v) == null
                            ? 'Invalid number'
                            : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Notes',
                          prefixIcon: Icon(Icons.note),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ================= Save Button =================
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: _isLoading ? null : _saveMedication,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Save Treatment',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMedication() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedFrequency != 'As Needed' && _selectedTimes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one time')),
      );
      return;
    }

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Treatment saved successfully')),
      );
      context.pop();
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _stockController.dispose();
    _durationController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}

