import 'package:cave/core/theme/app_text_styles.dart';
import 'package:cave/core/utils/window_size.dart';
import 'package:material_ui/material_ui.dart';

abstract final class AppTextTheme {
  static TextTheme of(WindowSize size) => switch (size) {
    WindowSize.compact => _compact,
    WindowSize.medium => _medium,
    WindowSize.expanded => _expanded,
  };

  static const TextTheme _compact = TextTheme(
    headlineLarge: AppTextStyleCompact.headlineLarge,
    headlineMedium: AppTextStyleCompact.headlineMedium,
    headlineSmall: AppTextStyleCompact.headlineSmall,
    titleLarge: AppTextStyleCompact.titleLarge,
    titleMedium: AppTextStyleCompact.titleMedium,
    titleSmall: AppTextStyleCompact.titleSmall,
    bodyLarge: AppTextStyleCompact.bodyLarge,
    bodyMedium: AppTextStyleCompact.bodyMedium,
    bodySmall: AppTextStyleCompact.bodySmall,
    labelLarge: AppTextStyleCompact.labelLarge,
    labelMedium: AppTextStyleCompact.labelMedium,
    labelSmall: AppTextStyleCompact.labelSmall,
  );

  static const TextTheme _medium = TextTheme(
    headlineLarge: AppTextStyleMedium.headlineLarge,
    headlineMedium: AppTextStyleMedium.headlineMedium,
    headlineSmall: AppTextStyleMedium.headlineSmall,
    titleLarge: AppTextStyleMedium.titleLarge,
    titleMedium: AppTextStyleMedium.titleMedium,
    titleSmall: AppTextStyleMedium.titleSmall,
    bodyLarge: AppTextStyleMedium.bodyLarge,
    bodyMedium: AppTextStyleMedium.bodyMedium,
    bodySmall: AppTextStyleMedium.bodySmall,
    labelLarge: AppTextStyleMedium.labelLarge,
    labelMedium: AppTextStyleMedium.labelMedium,
    labelSmall: AppTextStyleMedium.labelSmall,
  );

  static const TextTheme _expanded = TextTheme(
    headlineLarge: AppTextStyleExpanded.headlineLarge,
    headlineMedium: AppTextStyleExpanded.headlineMedium,
    headlineSmall: AppTextStyleExpanded.headlineSmall,
    titleLarge: AppTextStyleExpanded.titleLarge,
    titleMedium: AppTextStyleExpanded.titleMedium,
    titleSmall: AppTextStyleExpanded.titleSmall,
    bodyLarge: AppTextStyleExpanded.bodyLarge,
    bodyMedium: AppTextStyleExpanded.bodyMedium,
    bodySmall: AppTextStyleExpanded.bodySmall,
    labelLarge: AppTextStyleExpanded.labelLarge,
    labelMedium: AppTextStyleExpanded.labelMedium,
    labelSmall: AppTextStyleExpanded.labelSmall,
  );
}
