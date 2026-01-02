

// lib/core/utils/date_utils.dart

import 'package:intl/intl.dart';

class DateTimeUtils {
  // Prevent instantiation
  DateTimeUtils._();

  // ==========================================
  // FORMATTERS
  // ==========================================

  /// Format date to 'yyyy-MM-dd'
  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Format time to 'HH:mm'
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Format date to Arabic display format 'dd/MM/yyyy'
  static String formatDateArabic(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format time to Arabic display format 'hh:mm a'
  static String formatTimeArabic(DateTime date) {
    return DateFormat('hh:mm a', 'ar').format(date);
  }

  /// Format date and time to 'dd/MM/yyyy hh:mm a'
  static String formatDateTimeArabic(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm a', 'ar').format(date);
  }

  /// Format relative time (e.g., "منذ 5 دقائق")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'منذ $weeks أسبوع';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months شهر';
    } else {
      final years = (difference.inDays / 365).floor();
      return 'منذ $years سنة';
    }
  }

  /// Format medication time display
  static String formatMedicationTime(String time) {
    // Convert 24h format to 12h Arabic
    try {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = parts[1];

      if (hour == 0) {
        return '12:$minute ص';
      } else if (hour < 12) {
        return '$hour:$minute ص';
      } else if (hour == 12) {
        return '12:$minute م';
      } else {
        return '${hour - 12}:$minute م';
      }
    } catch (e) {
      return time;
    }
  }

  // ==========================================
  // PARSERS
  // ==========================================

  /// Parse date string to DateTime
  static DateTime? parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;

    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  /// Parse time string to DateTime (today's date with given time)
  static DateTime? parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;

    try {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  // ==========================================
  // COMPARISONS
  // ==========================================

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 7));

    return date.isAfter(weekStart) && date.isBefore(weekEnd);
  }

  /// Check if date is this month
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  // ==========================================
  // CALCULATIONS
  // ==========================================

  /// Get age from date of birth
  static int getAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  /// Get days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  /// Get days until date
  static int daysUntil(DateTime date) {
    final now = DateTime.now();
    return daysBetween(now, date);
  }

  /// Get days since date
  static int daysSince(DateTime date) {
    final now = DateTime.now();
    return daysBetween(date, now);
  }

  // ==========================================
  // DATE GENERATORS
  // ==========================================

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of week
  static DateTime startOfWeek(DateTime date) {
    final weekDay = date.weekday;
    return startOfDay(date.subtract(Duration(days: weekDay - 1)));
  }

  /// Get end of week
  static DateTime endOfWeek(DateTime date) {
    final weekDay = date.weekday;
    return endOfDay(date.add(Duration(days: 7 - weekDay)));
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  // ==========================================
  // DISPLAY HELPERS
  // ==========================================

  /// Get day name in Arabic
  static String getDayNameArabic(DateTime date) {
    const days = [
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return days[date.weekday - 1];
  }

  /// Get month name in Arabic
  static String getMonthNameArabic(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[date.month - 1];
  }

  /// Get smart date display (Today, Yesterday, or date)
  static String getSmartDateDisplay(DateTime date) {
    if (isToday(date)) {
      return 'اليوم';
    } else if (isYesterday(date)) {
      return 'أمس';
    } else if (isTomorrow(date)) {
      return 'غداً';
    } else if (isThisWeek(date)) {
      return getDayNameArabic(date);
    } else {
      return formatDateArabic(date);
    }
  }

  /// Get time of day period (صباح، ظهر، مساء، ليل)
  static String getTimeOfDayPeriod(DateTime date) {
    final hour = date.hour;

    if (hour >= 5 && hour < 12) {
      return 'صباحاً';
    } else if (hour >= 12 && hour < 17) {
      return 'ظهراً';
    } else if (hour >= 17 && hour < 21) {
      return 'مساءً';
    } else {
      return 'ليلاً';
    }
  }

  // ==========================================
  // MEDICATION SPECIFIC
  // ==========================================

  /// Calculate next medication time
  static DateTime? getNextMedicationTime(
      List<String> reminderTimes,
      ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final timeStr in reminderTimes) {
      final parts = timeStr.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final medicationTime = DateTime(
        today.year,
        today.month,
        today.day,
        hour,
        minute,
      );

      if (medicationTime.isAfter(now)) {
        return medicationTime;
      }
    }

    // If no time today, return first time tomorrow
    if (reminderTimes.isNotEmpty) {
      final parts = reminderTimes.first.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final tomorrow = today.add(const Duration(days: 1));
      return DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        hour,
        minute,
      );
    }

    return null;
  }

  /// Check if medication is due now (within 30 minutes)
  static bool isMedicationDueNow(String medicationTime) {
    final time = parseTime(medicationTime);
    if (time == null) return false;

    final now = DateTime.now();
    final difference = time.difference(now).inMinutes.abs();

    return difference <= 30;
  }

  // ==========================================
  // VALIDATION
  // ==========================================

  /// Check if date is valid
  static bool isValidDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return false;
    return parseDate(dateStr) != null;
  }

  /// Check if time is valid (HH:mm format)
  static bool isValidTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return false;

    final regex = RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$');
    return regex.hasMatch(timeStr);
  }

  /// Check if age is valid (between min and max)
  static bool isValidAge(DateTime dateOfBirth, {int min = 0, int max = 150}) {
    final age = getAge(dateOfBirth);
    return age >= min && age <= max;
  }
}
