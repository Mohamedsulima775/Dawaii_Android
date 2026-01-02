
/*

// الاوا


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:dawaii/services/settings_service.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicalNotesController = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodGroup;
  DateTime? _selectedDateOfBirth;
  bool _isLoading = false;
  bool _isSaving = false;

  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _allergiesController.dispose();
    _medicalNotesController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final patientId = prefs.getString('patient_id');

      if (patientId != null) {
        final profile = await SettingsService().getProfile(patientId);

        setState(() {
          _nameController.text = profile['patient_name'] ?? '';
          _emailController.text = profile['email'] ?? '';
          _mobileController.text = profile['mobile'] ?? '';
          _selectedGender = profile['gender'];
          _selectedBloodGroup = profile['blood_group'];
          _allergiesController.text = profile['allergies'] ?? '';
          _medicalNotesController.text = profile['medical_notes'] ?? '';

          if (profile['date_of_birth'] != null) {
            _selectedDateOfBirth =
                DateTime.tryParse(profile['date_of_birth']);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تحميل البيانات: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final patientId = prefs.getString('patient_id');

      if (patientId == null) {
        throw Exception('Patient ID not found');
      }

      final profileData = {
        'patient_name': _nameController.text,
        'gender': _selectedGender,
        'blood_group': _selectedBloodGroup,
        'allergies': _allergiesController.text,
        'medical_notes': _medicalNotesController.text,
        if (_selectedDateOfBirth != null)
          'date_of_birth':
          DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!),
      };

      await SettingsService().updateProfile(patientId, profileData);

      // Update local storage
      await prefs.setString('patient_name', _nameController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ التعديلات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في حفظ البيانات: $e')),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _selectDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar'),
    );

    if (picked != null) {
      setState(() => _selectedDateOfBirth = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        centerTitle: true,
        actions: [
          if (_isSaving)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveProfile,
              tooltip: 'حفظ',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                      child: Text(
                        _nameController.text.isNotEmpty
                            ? _nameController.text[0]
                            : 'م',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // TODO: Implement image picker
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('قريباً: تغيير الصورة'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Personal Information
              _buildSectionTitle('المعلومات الشخصية'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم الكامل',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: false, // Email can't be changed
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'رقم الجوال',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                enabled: false, // Mobile can't be changed
              ),

              const SizedBox(height: 16),

              // Date of Birth
              InkWell(
                onTap: _selectDateOfBirth,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'تاريخ الميلاد',
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _selectedDateOfBirth != null
                        ? DateFormat('yyyy-MM-dd')
                        .format(_selectedDateOfBirth!)
                        : 'اختر تاريخ الميلاد',
                    style: TextStyle(
                      color: _selectedDateOfBirth != null
                          ? Colors.black87
                          : Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'الجنس',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                items: _genderOptions.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender == 'Male' ? 'ذكر' : 'أنثى'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedGender = value);
                },
              ),

              const SizedBox(height: 16),

              // Blood Group
              DropdownButtonFormField<String>(
                value: _selectedBloodGroup,
                decoration: const InputDecoration(
                  labelText: 'فصيلة الدم',
                  prefixIcon: Icon(Icons.bloodtype_outlined),
                  border: OutlineInputBorder(),
                ),
                items: _bloodGroupOptions.map((bloodGroup) {
                  return DropdownMenuItem(
                    value: bloodGroup,
                    child: Text(bloodGroup),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedBloodGroup = value);
                },
              ),

              const SizedBox(height: 32),

              // Medical Information
              _buildSectionTitle('المعلومات الطبية'),
              const SizedBox(height: 16),

              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'الحساسية',
                  prefixIcon: Icon(Icons.warning_amber_outlined),
                  border: OutlineInputBorder(),
                  hintText: 'مثال: حساسية البنسلين، الفول السوداني...',
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _medicalNotesController,
                decoration: const InputDecoration(
                  labelText: 'ملاحظات طبية',
                  prefixIcon: Icon(Icons.notes_outlined),
                  border: OutlineInputBorder(),
                  hintText: 'أي معلومات طبية إضافية...',
                ),
                maxLines: 4,
              ),

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isSaving ? null : _saveProfile,
                  icon: _isSaving
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.save),
                  label: const Text(
                    'حفظ التعديلات',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

 */

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../services/settings_service.dart';


class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicalNotesController = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodGroup;
  DateTime? _selectedDateOfBirth;
  bool _isLoading = false;
  bool _isSaving = false;

  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _bloodGroupOptions = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _allergiesController.dispose();
    _medicalNotesController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    setState(() => _isLoading = true);
    try {
      final profile = await SettingsService().getProfile('patient_id');
      setState(() {
        _nameController.text = profile['patient_name'] ?? '';
        _emailController.text = profile['email'] ?? '';
        _mobileController.text = profile['mobile'] ?? '';
        _selectedGender = profile['gender'];
        _selectedBloodGroup = profile['blood_group'];
        _allergiesController.text = profile['allergies'] ?? '';
        _medicalNotesController.text = profile['medical_notes'] ?? '';
        if (profile['date_of_birth'] != null) {
          _selectedDateOfBirth = DateTime.tryParse(profile['date_of_birth']);
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في تحميل البيانات: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final profileData = {
        'patient_name': _nameController.text,
        'gender': _selectedGender,
        'blood_group': _selectedBloodGroup,
        'allergies': _allergiesController.text,
        'medical_notes': _medicalNotesController.text,
        if (_selectedDateOfBirth != null)
          'date_of_birth': DateFormat('yyyy-MM-dd').format(
              _selectedDateOfBirth!),
      };

      await SettingsService().updateProfile('patient_id', profileData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ التعديلات بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في حفظ البيانات: $e')),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _selectDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateOfBirth ?? DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar'),
    );

    if (picked != null) setState(() => _selectedDateOfBirth = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        centerTitle: true,
        actions: [
          _isSaving
              ? const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          )
              : IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
            tooltip: 'حفظ',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        child: Text(
                          _nameController.text.isNotEmpty
                              ? _nameController.text[0]
                              : 'م',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
                                size: 18, color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('قريباً: تغيير الصورة'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Personal Info Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('المعلومات الشخصية'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _nameController,
                          label: 'الاسم الكامل',
                          icon: Icons.person_outline,
                          validator: (v) =>
                          v!.isEmpty ? 'الرجاء إدخال الاسم' : null),
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _emailController,
                          label: 'البريد الإلكتروني',
                          icon: Icons.email_outlined,
                          enabled: false),
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _mobileController,
                          label: 'رقم الجوال',
                          icon: Icons.phone_outlined,
                          enabled: false,
                          keyboard: TextInputType.phone),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: _selectDateOfBirth,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'تاريخ الميلاد',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _selectedDateOfBirth != null
                                ? DateFormat('yyyy-MM-dd')
                                .format(_selectedDateOfBirth!)
                                : 'اختر تاريخ الميلاد',
                            style: TextStyle(
                              color: _selectedDateOfBirth != null
                                  ? Colors.black87
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                              value: _selectedGender,
                              label: 'الجنس',
                              icon: Icons.person_outline,
                              items: _genderOptions,
                              onChanged: (v) =>
                                  setState(() => _selectedGender = v),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdown(
                              value: _selectedBloodGroup,
                              label: 'فصيلة الدم',
                              icon: Icons.bloodtype_outlined,
                              items: _bloodGroupOptions,
                              onChanged: (v) =>
                                  setState(() => _selectedBloodGroup = v),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Medical Info Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('المعلومات الطبية'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _allergiesController,
                          label: 'الحساسية',
                          icon: Icons.warning_amber_outlined,
                          maxLines: 3,
                          hint: 'مثال: حساسية البنسلين...'),
                      const SizedBox(height: 16),
                      _buildTextField(
                          controller: _medicalNotesController,
                          label: 'ملاحظات طبية',
                          icon: Icons.notes_outlined,
                          maxLines: 4,
                          hint: 'أي معلومات طبية إضافية...'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isSaving ? null : _saveProfile,
                    icon: _isSaving
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : const Icon(Icons.save),
                    label: const Text('حفظ التعديلات'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
          ],
        ),
        child: child,
      );

  Widget _buildSectionTitle(String title) =>
      Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboard = TextInputType.text,
    bool enabled = true,
    int maxLines = 1,
    String? hint,
  }) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme
                .of(context)
                .primaryColor),
          ),
        ),
        validator: validator,
        keyboardType: keyboard,
        enabled: enabled,
        maxLines: maxLines,
      );

  Widget _buildDropdown({
    required String? value,
    required String label,
    required IconData icon,
    required List<String> items,
    required void Function(String?) onChanged,
  }) =>
      DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Theme
                .of(context)
                .primaryColor),
          ),
        ),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      );
}