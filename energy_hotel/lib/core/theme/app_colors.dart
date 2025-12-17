import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF1A1A2E);
  static const Color primaryLight = Color(0xFF16213E);
  static const Color accent = Color(0xFF2563EB);
  static const Color accentLight = Color(0xFF60A5FA);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  static const Color divider = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFD1D5DB);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  static Color primaryWithOpacity(double opacity) {
    return Color.fromRGBO(
      (primary.r * 255.0).round(),
      (primary.g * 255.0).round(),
      (primary.b * 255.0).round(),
      opacity,
    );
  }

  static Color accentWithOpacity(double opacity) {
    return Color.fromRGBO(
      (accent.r * 255.0).round(),
      (accent.g * 255.0).round(),
      (accent.b * 255.0).round(),
      opacity,
    );
  }

  static Color textPrimaryWithOpacity(double opacity) {
    return Color.fromRGBO(
      (textPrimary.r * 255.0).round(),
      (textPrimary.g * 255.0).round(),
      (textPrimary.b * 255.0).round(),
      opacity,
    );
  }
}
