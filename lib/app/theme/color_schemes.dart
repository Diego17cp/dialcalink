import 'package:flutter/material.dart';
import 'colors.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Brand
  primary: AppColors.brandBlue,
  onPrimary: Colors.white,

  secondary: AppColors.brandMustard,
  onSecondary: Colors.white,

  tertiary: Color(0xFF3B82F6),
  onTertiary: Colors.white,

  // Background

  // Surfaces
  surface: AppColors.lightSurface,
  onSurface: AppColors.textPrimaryLight,

  error: AppColors.error,
  onError: Colors.white,

  // Containers
  primaryContainer: Color(0xFFD8EAF8),
  onPrimaryContainer: Color(0xFF052C4A),

  secondaryContainer: Color(0xFFF6E7D4),
  onSecondaryContainer: Color(0xFF6A4A28),

  tertiaryContainer: Color(0xFFDCEBFF),
  onTertiaryContainer: Color(0xFF103A66),

  errorContainer: Color(0xFFFEE2E2),
  onErrorContainer: Color(0xFF7F1D1D),

  // Misc
  outline: AppColors.lightBorder,
  outlineVariant: Color(0xFFEAEFF5),

  shadow: Color(0x1A000000),
  scrim: Color(0x66000000),

  inverseSurface: Color(0xFF111827),
  onInverseSurface: Colors.white,

  inversePrimary: Color(0xFF3A8FD1),

  surfaceTint: AppColors.brandBlue,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Brand
  primary: Color(0xFF3A8FD1),
  onPrimary: Colors.white,

  secondary: AppColors.brandMustard,
  onSecondary: Colors.black,

  tertiary: Color(0xFF60A5FA),
  onTertiary: Colors.black,

  // Surfaces
  surface: AppColors.darkSurface,
  onSurface: AppColors.textPrimaryDark,

  error: AppColors.error,
  onError: Colors.white,

  // Containers
  primaryContainer: Color(0xFF0D3355),
  onPrimaryContainer: Color(0xFFD8EAF8),

  secondaryContainer: Color(0xFF5E4427),
  onSecondaryContainer: Color(0xFFF6E7D4),

  tertiaryContainer: Color(0xFF1E3A5F),
  onTertiaryContainer: Color(0xFFDCEBFF),

  errorContainer: Color(0xFF7F1D1D),
  onErrorContainer: Color(0xFFFEE2E2),

  // Misc
  outline: AppColors.darkBorder,
  outlineVariant: Color(0xFF475569),

  shadow: Colors.black,
  scrim: Colors.black,

  inverseSurface: Color(0xFFF8FAFC),
  onInverseSurface: Color(0xFF111827),

  inversePrimary: AppColors.brandBlue,

  surfaceTint: Color(0xFF3A8FD1),
);