

// lib/features/medication/domain/usecases/log_taken_usecase.dart

import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../data/repositories/medication_repository.dart';
import '../../entities/medication_log.dart';



/// Use Case لتسجيل تناول دواء
class LogMedicationTakenUseCase {
  final MedicationRepository repository;

  LogMedicationTakenUseCase(this.repository);

  /// تنفيذ Use Case
  Future<Either<Failure, MedicationLog>> call(
      LogMedicationTakenParams params,
      ) async {
    final validation = _validateParams(params);
    if (validation != null) {
      return Left(ValidationFailure(validation));
    }

    return await repository.logMedicationTaken(params);
  }

  String? _validateParams(LogMedicationTakenParams params) {
    if (params.medicationScheduleId.trim().isEmpty) {
      return 'معرف الدواء غير صحيح';
    }
    if (params.takenAt.isAfter(DateTime.now())) {
      return 'لا يمكن تسجيل تناول دواء في المستقبل';
    }
    return null;
  }
}

/// معلومات تناول الدواء
class LogMedicationTakenParams {
  final String medicationScheduleId;
  final DateTime takenAt;
  final bool taken;
  final String? notes;
  final int? quantity;

  LogMedicationTakenParams({
    required this.medicationScheduleId,
    required this.takenAt,
    this.taken = true,
    this.notes,
    this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'medication_schedule': medicationScheduleId,
    'taken_at': takenAt.toIso8601String(),
    'taken': taken ? 1 : 0,
    'notes': notes ?? '',
    'quantity_taken': quantity ?? 1,
  };

  factory LogMedicationTakenParams.fromJson(Map<String, dynamic> json) {
    return LogMedicationTakenParams(
      medicationScheduleId: json['medication_schedule'],
      takenAt: DateTime.parse(json['taken_at']),
      taken: json['taken'] == 1,
      notes: json['notes'],
      quantity: json['quantity_taken'],
    );
  }

  LogMedicationTakenParams copyWith({
    String? medicationScheduleId,
    DateTime? takenAt,
    bool? taken,
    String? notes,
    int? quantity,
  }) {
    return LogMedicationTakenParams(
      medicationScheduleId: medicationScheduleId ?? this.medicationScheduleId,
      takenAt: takenAt ?? this.takenAt,
      taken: taken ?? this.taken,
      notes: notes ?? this.notes,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// Use Case للحصول على سجل تناول الأدوية
class GetMedicationLogsUseCase {
  final MedicationRepository repository;

  GetMedicationLogsUseCase(this.repository);

  Future<Either<Failure, List<MedicationLog>>> call(
      GetMedicationLogsParams params,
      ) async {
    return await repository.getMedicationLogs(params);
  }
}

/// معايير البحث عن سجل التناول
class GetMedicationLogsParams {
  final String? medicationScheduleId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? limit;

  GetMedicationLogsParams({
    this.medicationScheduleId,
    this.fromDate,
    this.toDate,
    this.limit,
  });

  factory GetMedicationLogsParams.today() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return GetMedicationLogsParams(fromDate: startOfDay, toDate: endOfDay);
  }

  factory GetMedicationLogsParams.thisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfDay = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    return GetMedicationLogsParams(fromDate: startOfDay, toDate: now);
  }

  factory GetMedicationLogsParams.thisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    return GetMedicationLogsParams(fromDate: startOfMonth, toDate: now);
  }

  factory GetMedicationLogsParams.forMedication(String medicationScheduleId) {
    return GetMedicationLogsParams(medicationScheduleId: medicationScheduleId, limit: 50);
  }

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (medicationScheduleId != null) params['medication_schedule'] = medicationScheduleId;
    if (fromDate != null) params['from_date'] = fromDate!.toIso8601String().split('T')[0];
    if (toDate != null) params['to_date'] = toDate!.toIso8601String().split('T')[0];
    if (limit != null) params['limit'] = limit;
    return params;
  }
}

/// Validation Failure
class ValidationFailure extends Failure {
  final String message;
  ValidationFailure(this.message) : super('');

  @override
  List<Object?> get props => [message];
}

/// Extension لتحليل السجل
extension MedicationLogAnalysis on List<MedicationLog> {
  double get adherencePercentage {
    if (isEmpty) return 0.0;
    final takenCount = where((log) => log.taken).length;
    return (takenCount / length) * 100;
  }

  int get takenCount => where((log) => log.taken).length;
  int get missedCount => where((log) => !log.taken).length;

  MedicationLog? get lastTaken {
    final taken = where((log) => log.taken).toList();
    if (taken.isEmpty) return null;
    taken.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    return taken.first;
  }

  List<MedicationLog> get takenToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return where((log) {
      final logDate = DateTime(log.takenAt.year, log.takenAt.month, log.takenAt.day);
      return logDate == today && log.taken;
    }).toList();
  }

  List<MedicationLog> get missedToday {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return where((log) {
      final logDate = DateTime(log.takenAt.year, log.takenAt.month, log.takenAt.day);
      return logDate == today && !log.taken;
    }).toList();
  }

  Map<DateTime, List<MedicationLog>> groupByDate() {
    final grouped = <DateTime, List<MedicationLog>>{};
    for (final log in this) {
      final date = DateTime(log.takenAt.year, log.takenAt.month, log.takenAt.day);
      grouped.putIfAbsent(date, () => []).add(log);
    }
    return grouped;
  }

  Map<int, double> weeklyAdherence() {
    final weekly = <int, List<MedicationLog>>{};
    for (final log in this) {
      final weekNumber = _getWeekNumber(log.takenAt);
      weekly.putIfAbsent(weekNumber, () => []).add(log);
    }
    return weekly.map((week, logs) {
      final taken = logs.where((log) => log.taken).length;
      final total = logs.length;
      return MapEntry(week, (taken / total) * 100);
    });
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).ceil();
  }
}