
import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  // Brand
  // Vert profond : identité principale de l'ERP.
  static const Color primary = Color(0xFF064E3B);

  // Vert émeraude : couleur secondaire.
  static const Color secondary = Color(0xFF059669);

  // Vert accent : indicateurs et détails visuels.
  static const Color accent = Color(0xFF10B981);

  // Light theme
  static const Color lightBackground = Color(0xFFF3F4F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFD1FAE5);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightOutline = Color(0xFF9CA3AF);

  // Dark theme
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkSurfaceVariant = Color(0xFF374151);

  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFFD1D5DB);

  static const Color darkOutline = Color(0xFF6B7280);

  // Semantic status colors
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);

  // Borders and separators
  static const Color lightDivider = Color(0xFFE5E7EB);
  static const Color darkDivider = Color(0xFF374151);
}
