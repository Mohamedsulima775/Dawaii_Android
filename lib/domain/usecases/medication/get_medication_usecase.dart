/*
// lib/features/medication/domain/usecases/get_medications_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../data/models/medication_model.dart';
import '../../../data/repositories/medication_repository_impl.dart';
import '../../entities/medication.dart';



/// Use Case للحصول على قائمة أدوية المريض
class GetMedicationsUseCase {
  final MedicationRepository repository;

  GetMedicationsUseCase(this.repository);

  /// تنفيذ Use Case
  ///
  /// Parameters:
  /// - [params]: معايير البحث والفلترة (اختياري)
  ///
  /// Returns:
  /// - [Right(List<Medication>)]: في حالة النجاح
  /// - [Left(Failure)]: في حالة الفشل
  Future<Either<Failure,List<MedicationSchedule>>> call(
      GetMedicationsParams params,
      ) async {
    return await repository.getMedications(params);
  }
}

/// معايير البحث والفلترة للأدوية
class GetMedicationsParams {
  /// عرض الأدوية النشطة فقط
  final bool? activeOnly;

  /// البحث بالاسم
  final String? searchQuery;

  /// فرز حسب
  final MedicationSortBy? sortBy;

  /// ترتيب تصاعدي أو تنازلي
  final bool ascending;

  /// الحد الأقصى لعدد النتائج
  final int? limit;

  GetMedicationsParams({
    this.activeOnly,
    this.searchQuery,
    this.sortBy,
    this.ascending = true,
    this.limit,
  });

  /// المعايير الافتراضية (جميع الأدوية النشطة)
  factory GetMedicationsParams.activeOnly() {
    return GetMedicationsParams(
      activeOnly: true,
      sortBy: MedicationSortBy.name,
      ascending: true,
    );
  }

  /// جميع الأدوية
  factory GetMedicationsParams.all() {
    return GetMedicationsParams(
      activeOnly: null,
      sortBy: MedicationSortBy.createdAt,
      ascending: false,
    );
  }

  /// الأدوية منخفضة المخزون
  factory GetMedicationsParams.lowStock() {
    return GetMedicationsParams(
      activeOnly: true,
      sortBy: MedicationSortBy.stock,
      ascending: true,
    );
  }

  /// تحويل إلى Query Parameters
  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};

    if (activeOnly != null) {
      params['is_active'] = activeOnly! ? 1 : 0;
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      params['search'] = searchQuery;
    }

    if (sortBy != null) {
      params['order_by'] = sortBy!.field;
      params['order'] = ascending ? 'asc' : 'desc';
    }

    if (limit != null) {
      params['limit'] = limit;
    }

    return params;
  }

  /// نسخ مع تعديل
  GetMedicationsParams copyWith({
    bool? activeOnly,
    String? searchQuery,
    MedicationSortBy? sortBy,
    bool? ascending,
    int? limit,
  }) {
    return GetMedicationsParams(
      activeOnly: activeOnly ?? this.activeOnly,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      limit: limit ?? this.limit,
    );
  }
}

/// خيارات الفرز
enum MedicationSortBy {
  name('medication_name'),
  createdAt('created_at'),
  stock('current_stock'),
  nextDose('next_dose_time');

  final String field;
  const MedicationSortBy(this.field);
}

/// Extension لتسهيل الاستخدام
extension MedicationListExtension on List<Medication> {
  /// فلترة الأدوية النشطة فقط
  List<Medication> get activeOnly {
    return where((med) => med.isActive).toList();
  }

  /// فلترة الأدوية منخفضة المخزون
  List<Medication> get lowStock {
    return where((med) => med.daysUntilDepletion <= 5).toList();
  }

  /// فلترة الأدوية المستحقة اليوم
  List<Medication> get dueToday {
    final now = DateTime.now();
    return where((med) {
      return med.times.any((time) {
        final timeParts = time.split(':');
        final hour = int.parse(timeParts[0]);
        final minute = int.parse(timeParts[1]);
        final scheduleTime = DateTime(
          now.year,
          now.month,
          now.day,
          hour,
          minute,
        );
        return scheduleTime.isAfter(now) &&
            scheduleTime.isBefore(now.add(const Duration(hours: 1)));
      });
    }).toList();
  }

  /// ترتيب حسب الاسم
  List<Medication> sortByName({bool ascending = true}) {
    final sorted = List<Medication>.from(this);
    sorted.sort((a, b) {
      final comparison = a.medicationName.compareTo(b.medicationName);
      return ascending ? comparison : -comparison;
    });
    return sorted;
  }

  /// ترتيب حسب المخزون
  List<Medication> sortByStock({bool ascending = true}) {
    final sorted = List<Medication>.from(this);
    sorted.sort((a, b) {
      final comparison = a.currentStock.compareTo(b.currentStock);
      return ascending ? comparison : -comparison;
    });
    return sorted;
  }
}

 */

// lib/features/medication/domain/usecases/get_medications_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../data/repositories/medication_repository.dart';
import '../../entities/medication.dart';



/// Use Case للحصول على قائمة أدوية المريض
class GetMedicationsUseCase {
  final MedicationRepository repository;

  GetMedicationsUseCase(this.repository);

  /// تنفيذ Use Case
  Future<Either<Failure, List<Medication>>> call(
      GetMedicationsParams params,
      ) async {
    return await repository.getMedications(params);
  }
}

/// معايير البحث والفلترة للأدوية
class GetMedicationsParams {
  final bool? activeOnly;
  final String? searchQuery;
  final MedicationSortBy? sortBy;
  final bool ascending;
  final int? limit;

  GetMedicationsParams({
    this.activeOnly,
    this.searchQuery,
    this.sortBy,
    this.ascending = true,
    this.limit,
  });

  factory GetMedicationsParams.activeOnly() => GetMedicationsParams(
    activeOnly: true,
    sortBy: MedicationSortBy.name,
    ascending: true,
  );

  factory GetMedicationsParams.all() => GetMedicationsParams(
    activeOnly: null,
    sortBy: MedicationSortBy.createdAt,
    ascending: false,
  );

  factory GetMedicationsParams.lowStock() => GetMedicationsParams(
    activeOnly: true,
    sortBy: MedicationSortBy.stock,
    ascending: true,
  );

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (activeOnly != null) params['is_active'] = activeOnly! ? 1 : 0;
    if (searchQuery != null && searchQuery!.isNotEmpty) params['search'] = searchQuery;
    if (sortBy != null) {
      params['order_by'] = sortBy!.field;
      params['order'] = ascending ? 'asc' : 'desc';
    }
    if (limit != null) params['limit'] = limit;
    return params;
  }

  GetMedicationsParams copyWith({
    bool? activeOnly,
    String? searchQuery,
    MedicationSortBy? sortBy,
    bool? ascending,
    int? limit,
  }) {
    return GetMedicationsParams(
      activeOnly: activeOnly ?? this.activeOnly,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      limit: limit ?? this.limit,
    );
  }
}

/// خيارات الفرز
enum MedicationSortBy {
  name('name'),
  createdAt('createdAt'),
  stock('currentStock'),
  nextDose('nextDoseTime');

  final String field;
  const MedicationSortBy(this.field);
}

/// Extension لتسهيل التعامل مع قائمة الأدوية
extension MedicationListExtension on List<Medication> {
  /// فلترة الأدوية النشطة فقط
  List<Medication> get activeOnly => where((med) => med.isActive).toList();

  /// فلترة الأدوية منخفضة المخزون
  List<Medication> get lowStock => where((med) => med.daysUntilDepletion <= 5).toList();

  /// فلترة الأدوية المستحقة اليوم (الساعة القادمة)
  List<Medication> get dueToday {
    final now = DateTime.now();
    return where((med) {
      return med.times.any((time) {
        final hour = time.hour;
        final minute = time.minute;
        final scheduleTime = DateTime(now.year, now.month, now.day, hour, minute);
        return scheduleTime.isAfter(now) &&
            scheduleTime.isBefore(now.add(const Duration(hours: 1)));
      });
    }).toList();
  }

  /// ترتيب حسب الاسم
  List<Medication> sortByName({bool ascending = true}) {
    final sorted = List<Medication>.from(this);
    sorted.sort((a, b) {
      final comparison = a.medicationName.compareTo(b.medicationName);
      return ascending ? comparison : -comparison;
    });
    return sorted;
  }

  /// ترتيب حسب المخزون
  List<Medication> sortByStock({bool ascending = true}) {
    final sorted = List<Medication>.from(this);
    sorted.sort((a, b) {
      final comparison = a.currentStock.compareTo(b.currentStock);
      return ascending ? comparison : -comparison;
    });
    return sorted;
  }
}