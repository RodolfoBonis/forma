import 'package:flutter/widgets.dart';

/// Responsive breakpoints and screen-size helpers for the Forma Design System.
///
/// Follows the Material 3 window-size classes:
/// - **compact** — phones (width < 600)
/// - **medium** — foldables / small tablets (600 ≤ width ≤ 840)
/// - **expanded** — tablets / desktop (width > 840)
abstract class FormaScreen {
  /// Maximum width for the compact breakpoint.
  static const double compactMax = 600;

  /// Maximum width for the medium breakpoint.
  static const double mediumMax = 840;

  /// Returns `true` when the screen is in the compact range (< 600px).
  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compactMax;

  /// Returns `true` when the screen is in the medium range (600–840px).
  static bool isMedium(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= compactMax && width <= mediumMax;
  }

  /// Returns `true` when the screen is in the expanded range (> 840px).
  static bool isExpanded(BuildContext context) =>
      MediaQuery.sizeOf(context).width > mediumMax;
}
