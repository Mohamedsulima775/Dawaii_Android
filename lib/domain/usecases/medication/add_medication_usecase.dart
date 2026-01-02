
// lib/features/medication/domain/usecases/add_medication_usecase.dart

import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../data/models/medication_model.dart';
import '../../../data/repositories/medication_repository_impl.dart';
import '../../entities/medication.dart' hide MedicationTime;


/*
/// Use Case لإضافة دواء جديد للمريض
class AddMedicationUseCase {
  final MedicationRepository repository;

  AddMedicationUseCase(this.repository);

  /// تنفيذ Use Case
  Future<Either<Failure, Medication>> call(AddMedicationParams params) async {
    final validation = _validateParams(params);
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    return await repository.addMedication(params);
  }

  /// التحقق من صحة البيانات المدخلة
  String? _validateParams(AddMedicationParams params) {
    if (params.name.trim().isEmpty) {
      return 'يرجى إدخال اسم الدواء';
    }

    if (params.dosage.trim().isEmpty) {
      return 'يرجى إدخال الجرعة';
    }

    if (params.frequency.trim().isEmpty) {
      return 'يرجى اختيار عدد مرات التناول';
    }

    if (params.times.isEmpty) {
      return 'يرجى إضافة مواعيد التناول';
    }

    if (params.currentStock <= 0) {
      return 'يرجى إدخال كمية صحيحة';
    }

    return null;
  }
}

/// معلومات الدواء المطلوب إضافته
class AddMedicationParams {
  final String name;
  final String scientificName;
  final String dosage;
  final String frequency;
  final List<MedicationTime> times;
  final String? instructions;
  final int currentStock;
  final bool isActive;
  final String? notes;

  AddMedicationParams({
    required this.name,
    this.scientificName = '',
    required this.dosage,
    required this.frequency,
    required this.times,
    this.instructions,
    required this.currentStock,
    this.isActive = true,
    this.notes,
  });

  /// تحويل إلى JSON للإرسال للـ API
  Map<String, dynamic> toJson() {
    return {
      'medication_name': name,
      'scientific_name': scientificName,
      'dosage': dosage,
      'frequency': frequency,
      'times': times.map((t) => {'hour': t.hour, 'minute': t.minute}).toList(),
      'instructions': instructions ?? '',
      'current_stock': currentStock,
      'is_active': isActive ? 1 : 0,
      'notes': notes ?? '',
    };
  }

  /// نسخ مع تعديل
  AddMedicationParams copyWith({
    String? name,
    String? scientificName,
    String? dosage,
    String? frequency,
    List<MedicationTime>? times,
    String? instructions,
    int? currentStock,
    bool? isActive,
    String? notes,
  }) {
    return AddMedicationParams(
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      instructions: instructions ?? this.instructions,
      currentStock: currentStock ?? this.currentStock,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
    );
  }
}

/// Failure للـ Validation
class ValidationFailure extends Failure {
  final String message;

  ValidationFailure(this.message);

  @override
  List<Object?> get props => [message];
}


 */


/// Use Case لإضافة دواء جديد
class AddMedicationUseCase {
  final MedicationRepository repository;

  AddMedicationUseCase(this.repository);

  /// تنفيذ العملية لإضافة دواء
  Future<Either<Failure, MedicationSchedule>> call(
      AddMedicationParams params) async {
    // التحقق من صحة البيانات
    final validationError = _validate(params);
    if (validationError != null) {
      return Left(ValidationFailure(validationError));
    }

    try {
      final result = await repository.addMedication(
        patientId: params.patientId,
        medicationName: params.medicationName,
        scientificName: params.scientificName,
        dosage: params.dosage,
        frequency: params.frequency,
        times: params.times.map((t) => MedicationTime(time: t)).toList(),
        currentStock: params.currentStock,
        stockUnit: params.stockUnit,
        colorCode: params.colorCode,
        image: params.image,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// التحقق من صحة البيانات المدخلة
  String? _validate(AddMedicationParams params) {
    if (params.medicationName.trim().isEmpty) {
      return 'يرجى إدخال اسم الدواء';
    }
    if (params.dosage.trim().isEmpty) {
      return 'يرجى إدخال الجرعة';
    }
    if (params.frequency.trim().isEmpty) {
      return 'يرجى اختيار عدد مرات التناول';
    }
    if (params.times.isEmpty) {
      return 'يرجى إضافة مواعيد التناول';
    }
    if (params.currentStock <= 0) {
      return 'يرجى إدخال كمية صحيحة';
    }
    if (params.stockUnit.trim().isEmpty) {
      return 'يرجى إدخال وحدة التخزين';
    }
    return null;
  }
}

/// Parameters لإضافة دواء
class AddMedicationParams {
  final String patientId;
  final String medicationName;
  final String? scientificName;
  final String dosage;
  final String frequency;
  final List<String> times;
  final int currentStock;
  final String stockUnit;
  final bool isActive;
  final String? notes;
  final String? colorCode;
  final String? image;

  const AddMedicationParams({
    required this.patientId,
    required this.medicationName,
    this.scientificName,
    required this.dosage,
    required this.frequency,
    required this.times,
    required this.currentStock,
    required this.stockUnit,
    this.isActive = true,
    this.notes,
    this.colorCode,
    this.image,
  });

  /// تحويل البيانات إلى JSON (للاستخدام مع API إذا لزم)
  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'medication_name': medicationName,
      'scientific_name': scientificName ?? '',
      'dosage': dosage,
      'frequency': frequency,
      'times': times.map((t) => {'time': t}).toList(),
      'current_stock': currentStock,
      'stock_unit': stockUnit,
      'is_active': isActive ? 1 : 0,
      'notes': notes ?? '',
      'color_code': colorCode ?? '',
      'image': image ?? '',
    };
  }
}





