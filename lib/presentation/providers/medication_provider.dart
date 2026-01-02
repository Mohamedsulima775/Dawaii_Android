


// الاول

import 'package:dawaii/presentation/providers/usecase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/failures.dart';
//import '../../data/models/medication_model.dart';
import '../../data/models/medication_model.dart';
import '../../domain/entities/medication.dart' hide MedicationTime;
import '../../domain/usecases/medication/add_medication_usecase.dart';


@immutable
class MedicationState {
  final bool isLoading;
  final List<MedicationSchedule> medications;
  final String? error;

  const MedicationState({
    this.isLoading = false,
    this.medications = const [],
    this.error,
  });

  MedicationState copyWith({
    bool? isLoading,
    List<MedicationSchedule>? medications,
    String? error,
  }) {
    return MedicationState(
      isLoading: isLoading ?? this.isLoading,
      medications: medications ?? this.medications,
      error: error,
    );
  }
}

// ===============================
// Fake Repository متوافق مع Model الحقيقية
// ===============================
class FakeMedicationRepository {
  Future<List<MedicationSchedule>> getMedications(String patientId) async {
    return [
      MedicationSchedule(
        scheduleId: '1',
        patientId: patientId,
        medicationName: 'دواء تجريبي 1',
        scientificName: null,
        dosage: '1 حبة',
        frequency: 'مرة يومياً',
        times: [
          MedicationTime(time: "08:00"),
          MedicationTime(time: "20:00"),
        ],
        currentStock: 10,
        stockUnit: 'حبوب',
        dailyConsumption: 1.0,
        daysUntilDepletion: 5,
        colorCode: '#FF0000',
        image: null,
        isActive: true,
      ),
      MedicationSchedule(
        scheduleId: '2',
        patientId: patientId,
        medicationName: 'دواء تجريبي 2',
        scientificName: null,
        dosage: '2 حبة',
        frequency: 'مرتين يومياً',
        times: [
          MedicationTime(time: "09:30"),
          MedicationTime(time: "21:30"),
        ],
        currentStock: 3,
        stockUnit: 'حبوب',
        dailyConsumption: 2.0,
        daysUntilDepletion: 2,
        colorCode: '#00FF00',
        image: null,
        isActive: true,
      ),
    ];
  }

  Future<MedicationSchedule> addMedication({
    required String patientId,
    required String medicationName,
    String? scientificName,
    required String dosage,
    required String frequency,
    required List<MedicationTime> times,
    required int currentStock,
    required String stockUnit,
    String? colorCode,
    String? image,
  }) async {
    return MedicationSchedule(
      scheduleId: DateTime.now().millisecondsSinceEpoch.toString(),
      patientId: patientId,
      medicationName: medicationName,
      scientificName: scientificName,
      dosage: dosage,
      frequency: frequency,
      times: times,
      currentStock: currentStock,
      stockUnit: stockUnit,
      dailyConsumption: 1.0,
      daysUntilDepletion: 10,
      colorCode: colorCode,
      image: image,
      isActive: true,
    );
  }

  Future<void> logTaken({
    required String medicationScheduleId,
    required DateTime takenAt,
  }) async {}
}

// ===============================
// Notifier
// ===============================
class MedicationNotifier extends StateNotifier<MedicationState> {
  final FakeMedicationRepository _repository;
  final String _patientId;

  MedicationNotifier(this._repository, this._patientId)
      : super(const MedicationState()) {
    loadMedications();
  }

  Future<void> loadMedications() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final medications = await _repository.getMedications(_patientId);
      state = state.copyWith(isLoading: false, medications: medications);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addMedication({
    required String medicationName,
    String? scientificName,
    required String dosage,
    required String frequency,
    required List<MedicationTime> times,
    required int currentStock,
    required String stockUnit,
    String? colorCode,
    String? image,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final newMedication = await _repository.addMedication(
        patientId: _patientId,
        medicationName: medicationName,
        scientificName: scientificName,
        dosage: dosage,
        frequency: frequency,
        times: times,
        currentStock: currentStock,
        stockUnit: stockUnit,
        colorCode: colorCode,
        image: image,
      );
      state = state.copyWith(
        isLoading: false,
        medications: [...state.medications, newMedication],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logTaken(String medicationScheduleId) async {
    try {
      await _repository.logTaken(
        medicationScheduleId: medicationScheduleId,
        takenAt: DateTime.now(),
      );
      await loadMedications();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// ===============================
// Provider جاهز للاستخدام
// ===============================
final medicationProvider = StateNotifierProvider.family<
    MedicationNotifier,
    MedicationState,
    String>((ref, patientId) {
  return MedicationNotifier(FakeMedicationRepository(), patientId);
});



/*
// ===============================
// State
// ===============================
@immutable
class MedicationState {
  final bool isLoading;
  final List<Medication> medications;
  final String? error;

  const MedicationState({
    this.isLoading = false,
    this.medications = const [],
    this.error,
  });

  MedicationState copyWith({
    bool? isLoading,
    List<Medication>? medications,
    String? error,
  }) {
    return MedicationState(
      isLoading: isLoading ?? this.isLoading,
      medications: medications ?? this.medications,
      error: error,
    );
  }
}

// ===============================
// Notifier
// ===============================
class MedicationNotifier extends StateNotifier<MedicationState> {
  final AddMedicationUseCase _addMedicationUseCase;

  MedicationNotifier(this._addMedicationUseCase)
      : super(const MedicationState());

  Future<void> addMedication(AddMedicationParams params) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _addMedicationUseCase(params);

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
          (medication) {
        state = state.copyWith(
          isLoading: false,
          medications: [...state.medications, medication],
        );
      },
    );
  }
}

  /*String _mapFailureToMessage(Failure failure) {

    if (failure is ValidationFailure) {
      return failure.message;
    }
    return 'حدث خطأ غير متوقع';
  }

   */





// ===============================
// Provider
// ===============================
final medicationProvider =
StateNotifierProvider<MedicationNotifier, MedicationState>((ref) {
  return MedicationNotifier(
    ref.read(addMedicationUseCaseProvider),
  );
});

 */





