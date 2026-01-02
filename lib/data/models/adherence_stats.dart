class AdherenceStats {
  final double adherencePercentage;
  final int totalDoses;
  final int takenDoses;
  final int skippedDoses;
  final int missedDoses;
  final Map<String, double>? weeklyAdherence;
  final Map<String, double>? medicationAdherence;
  final int? currentStreak;
  final int? longestStreak;

  AdherenceStats({
    required this.adherencePercentage,
    required this.totalDoses,
    required this.takenDoses,
    required this.skippedDoses,
    required this.missedDoses,
    this.weeklyAdherence,
    this.medicationAdherence,
    this.currentStreak,
    this.longestStreak,
  });

  factory AdherenceStats.fromJson(Map<String, dynamic> json) {
    return AdherenceStats(
      adherencePercentage: (json['adherence_percentage'] ?? 0).toDouble(),
      totalDoses: json['total_doses'] ?? 0,
      takenDoses: json['taken_doses'] ?? 0,
      skippedDoses: json['skipped_doses'] ?? 0,
      missedDoses: json['missed_doses'] ?? 0,
      weeklyAdherence: json['weekly_adherence'] != null
          ? Map<String, double>.from(json['weekly_adherence'])
          : null,
      medicationAdherence: json['medication_adherence'] != null
          ? Map<String, double>.from(json['medication_adherence'])
          : null,
      currentStreak: json['current_streak'],
      longestStreak: json['longest_streak'],
    );
  }
}