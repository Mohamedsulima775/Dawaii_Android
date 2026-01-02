
// lib/screens/medications_screen.dart

/*
import 'package:dawaii/presentation/screens/medications/widgets/log_medication_dialog.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/medication.dart';
import '../../../services/medication_service.dart';
import '../home/widgets/medication_card.dart';
//import '../models/medication_model.dart';
//import '../services/medication_service.dart';
//import '../widgets/log_medication_dialog.dart';
//import 'package:dawaii/presentation/screens/medications/add_medication_screen.dart';
import 'add_medications_screen.dart';
import 'medication_detail_screen.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen>
    with SingleTickerProviderStateMixin {
  final _medicationService = MedicationService();

  List<Medication> _allMedications = [];
  List<Medication> _dueMedications = [];
  List<Medication> _lowStockMedications = [];

  bool _isLoading = true;
  String? _error;

  late TabController _tabController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() => _currentTab = _tabController.index);
    });
    _loadMedications();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadMedications() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final results = await Future.wait([
        _medicationService.getMedications(),
        _medicationService.getMedicationsDue(),
        _medicationService.getLowStockMedications(),
      ]);

      setState(() {
        _allMedications = results[0] as List<Medication>;
        _dueMedications = results[1] as List<Medication>;
        _lowStockMedications = results[2] as List<Medication>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _navigateToAddMedication() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMedicationScreen(),
      ),
    );

    if (result == true) {
      _loadMedications();
    }
  }

  void _navigateToMedicationDetail(Medication medication) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MedicationDetailScreen(
          medication: _medication,
        ),
      ),
    );

    if (result == true) {
      _loadMedications();
    }
  }

  void _showLogDialog(Medication medication) {
    showLogMedicationDialog(
      context: context,
      medication: medication,
      onSuccess: _loadMedications,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أدويتي'),
        elevation: 0,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('الكل'),
                  if (_allMedications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    _buildBadge(_allMedications.length),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('المستحقة'),
                  if (_dueMedications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    _buildBadge(_dueMedications.length, Colors.orange),
                  ],
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('المنخفضة'),
                  if (_lowStockMedications.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    _buildBadge(_lowStockMedications.length, Colors.red),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorState()
          : TabBarView(
        controller: _tabController,
        children: [
          _buildMedicationsList(_allMedications, showAll: true),
          _buildMedicationsList(_dueMedications, isDue: true),
          _buildMedicationsList(_lowStockMedications, isLowStock: true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddMedication,
        icon: const Icon(Icons.add),
        label: const Text('إضافة دواء'),
      ),
    );
  }

  Widget _buildBadge(int count, [Color? color]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: (color ?? Colors.blue).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.blue,
        ),
      ),
    );
  }

  Widget _buildMedicationsList(
      List<Medication> medications, {
        bool showAll = false,
        bool isDue = false,
        bool isLowStock = false,
      }) {
    if (medications.isEmpty) {
      return _buildEmptyState(
        isDue: isDue,
        isLowStock: isLowStock,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMedications,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];
          return MedicationCard(
            medication: medication,
            onTap: () => _navigateToMedicationDetail(medication),
            onLogTaken: medication.isActive && isDue
                ? () => _showLogDialog(medication)
                : null,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState({bool isDue = false, bool isLowStock = false}) {
    String title;
    String message;
    IconData icon;

    if (isDue) {
      title = 'رائع! 🎉';
      message = 'لا توجد أدوية مستحقة الآن';
      icon = Icons.check_circle_outline;
    } else if (isLowStock) {
      title = 'ممتاز! ✨';
      message = 'جميع الأدوية متوفرة بكميات كافية';
      icon = Icons.inventory_2_outlined;
    } else {
      title = 'لا توجد أدوية';
      message = 'ابدأ بإضافة أدويتك الآن';
      icon = Icons.medication_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            if (!isDue && !isLowStock) ...[
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _navigateToAddMedication,
                icon: const Icon(Icons.add),
                label: const Text('إضافة دواء'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.shade300,
            ),
            const SizedBox(height: 24),
            const Text(
              'حدث خطأ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'خطأ غير معروف',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _loadMedications,
              icon: const Icon(Icons.refresh),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}

 */



// الاول
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dawaii/presentation/screens/home/widgets/medication_card.dart';
import '../medications/widgets/filter_status_chip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// استيراد الـ Provider والـ Widgets
import '../../providers/medication_provider.dart';


class MedicationsListScreen extends ConsumerStatefulWidget {
  const MedicationsListScreen({super.key});

  @override
  ConsumerState<MedicationsListScreen> createState() => _MedicationsListScreenState();
}

class _MedicationsListScreenState extends ConsumerState<MedicationsListScreen> {
  String _searchQuery = '';
  String _filterStatus = 'All';

  @override
  Widget build(BuildContext context) {
    // هنا نمرر patientId (يمكنك استبداله بالـ ID الحقيقي للمستخدم لاحقاً)
    final medicationState = ref.watch(medicationProvider('user_123'));
    //final medicationState = ref.watch(medicationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أدويتي'),
        actions: [
          IconButton(
            onPressed: () => context.push('/medications/adherence'),
            icon: const Icon(Icons.bar_chart),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. شريط البحث
          _buildSearchBar(),

          // 2. الفلاتر
          _buildFilterChips(),

          const SizedBox(height: 16),

          // 3. عرض البيانات بناءً على حالة الـ Provider
          Expanded(
            child: _buildContent(medicationState),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/medications/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(MedicationState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text('خطأ: ${state.error}'));
    }

    // تطبيق منطق البحث والفلترة على القائمة القادمة من الـ Provider
    final filteredList = state.medications.where((med) {
      final matchesSearch = med.medicationName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _filterStatus == 'All' ||
          (_filterStatus == 'Low Stock' && med.currentStock <= 5); // مثال للفلترة
      return matchesSearch && matchesFilter;
    }).toList();

    if (filteredList.isEmpty) {
      return const Center(child: Text('لم يتم العثور على أدوية'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return MedicationCard(
          medication: filteredList[index],
          onTap: () => context.push('/medications/detail/${filteredList[index].scheduleId}'),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'ابحث عن دواء...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Active', 'Low Stock'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: filters.map((filter) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterStatusChip(
            label: filter,
            selected: _filterStatus == filter,
            onTap: () => setState(() => _filterStatus = filter),
          ),
        )).toList(),
      ),
    );
  }
}


