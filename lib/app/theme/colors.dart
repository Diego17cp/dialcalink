import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  static const Color brandBlue = Color(0xFF085691);
  static const Color brandMustard = Color(0xFFD79B5F);

  // ========== Light Theme Colors ==========

  static const Color lightBackground = Color(0xFFF8FAFC);

  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightSurfaceVariant = Color(0xFFF1F5F9);

  static const Color lightBorder = Color(0xFFE2E8F0);

  // ========== Dark Theme Colors ==========

  static const Color darkBackground = Color(0xFF071520);

  static const Color darkSurface = Color(0xFF0F172A);

  static const Color darkSurfaceVariant = Color(0xFF1E293B);

  static const Color darkBorder = Color(0xFF334155);

  // ========= Text Light ==========
  static const Color textPrimaryLight = Color(0xFF111827);

  static const Color textSecondaryLight = Color(0xFF6B7280);

  static const Color textTertiaryLight = Color(0xFF94A3B8);

  static const Color textInverseLight = Color(0xFFFFFFFF);

  // ========= Text Dark ==========
  static const Color textPrimaryDark = Color(0xFFF8FAFC);

  static const Color textSecondaryDark = Color(0xFFCBD5E1);

  static const Color textTertiaryDark = Color(0xFF94A3B8);

  static const Color textInverseDark = Color(0xFF111827);

  // ======== Status ==========
  static const Color success = Color(0xFF22C55E);

  static const Color warning = Color(0xFFF59E0B);

  static const Color error = Color(0xFFEF4444);

  static const Color info = Color(0xFF3B82F6);

  // ======== Connection State ==========
  static const Color connected = success;

  static const Color connecting = warning;

  static const Color disconnected = error;

  static const Color syncing = info;

  // ======== Role Colors ==========
  static const Color clientRole = brandBlue;

  static const Color gatewayRole = brandMustard;
}