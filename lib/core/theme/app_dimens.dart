

import 'package:cave/core/utils/window_size.dart';

abstract final class AppDimens {
  // Espacements — valeurs en pixels logiques (dp)
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 12;
  static const double spaceLg = 16;
  static const double spaceXl = 24;
  static const double space2xl = 32;
  static const double space3xl = 40;
  static const double space4xl = 48;

  // Rayons des bordures
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusPill = 999;

  // Composants interactifs
  static const double minTapTarget = 48;
  static const double buttonHeight = 48;
  static const double inputHeight = 56;

  // Icônes
  static const double iconSm = 18;
  static const double iconMd = 24;
  static const double iconLg = 32;

  // Mise en page
  static const double contentMaxWidth = 1200;
  static const double dialogMaxWidth = 560;
  static const double formContentMaxWidth = 560;
  static const double sectionSpacing = 24;
  static const double cardPadding = 16;
  static const double pageBottomPadding = 96; // Espace réservé au FAB.

  // Marges horizontales selon la taille de l'écran
  static double horizontalPadding(WindowSize size) => switch (size) {
    WindowSize.compact => 16,
    WindowSize.medium => 24,
    WindowSize.expanded => 32,
  };

  // Espacement entre les éléments selon la taille de l'écran
  static double itemSpacing(WindowSize size) => switch (size) {
    WindowSize.compact => 12,
    WindowSize.medium => 16,
    WindowSize.expanded => 24,
  };

  static double itemSpacer(WindowSize size) => switch (size) {
    WindowSize.compact => 4,
    WindowSize.medium => 8,
    WindowSize.expanded => 12,
  };
}
