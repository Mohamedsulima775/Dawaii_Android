//lib/core/theme/app_colors.dart

/*
//الاول
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryLight = Color(0xFF40916C);
  static const Color primaryDark = Color(0xFF1B4332);

  // Secondary Colors
  static const Color secondary = Color(0xFFE85D75);
  static const Color secondaryLight = Color(0xFFFF6B88);

  // Status Colors
  static const Color success = Color(0xFF52B788);
  static const Color warning = Color(0xFFF4A261);
  static const Color danger = Color(0xFFE76F51);
  static const Color info = Color(0xFF4ECDC4);

  // Background Colors
  static const Color bgMain = Color(0xFFF8F9F7);
  static const Color bgCard = Color(0xFFFFFFFF);
  static const Color bgSoft = Color(0xFFEEF4F0);

  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);
}

 */

// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // ==========================================
  // PRIMARY COLORS
  // ==========================================

  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);

  // ==========================================
  // SECONDARY COLORS
  // ==========================================

  static const Color secondary = Color(0xFF4CAF50); // Green
  static const Color secondaryDark = Color(0xFF388E3C);
  static const Color secondaryLight = Color(0xFF81C784);

  // ==========================================
  // SEMANTIC COLORS
  // ==========================================

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // ==========================================
  // BACKGROUND COLORS
  // ==========================================

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
 // static const Color bgSoft = Color(0xFFEEF4F0);
  // ==========================================
  // TEXT COLORS
  // ==========================================

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ==========================================
  // BORDER & DIVIDER
  // ==========================================

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // ==========================================
  // MEDICATION STATUS COLORS
  // ==========================================

  static const Color medicationActive = Color(0xFF4CAF50);
  static const Color medicationInactive = Color(0xFF9E9E9E);
  static const Color medicationLowStock = Color(0xFFFF9800);
  static const Color medicationOutOfStock = Color(0xFFF44336);

  // ==========================================
  // ORDER STATUS COLORS
  // ==========================================

  static const Color orderPending = Color(0xFFFF9800);
  static const Color orderConfirmed = Color(0xFF2196F3);
  static const Color orderProcessing = Color(0xFF9C27B0);
  static const Color orderDelivering = Color(0xFF00BCD4);
  static const Color orderDelivered = Color(0xFF4CAF50);
  static const Color orderCancelled = Color(0xFFF44336);

  // ==========================================
  // DARK MODE COLORS
  // ==========================================

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);


}




