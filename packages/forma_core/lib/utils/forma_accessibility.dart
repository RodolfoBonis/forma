import 'package:flutter/widgets.dart';

/// Accessibility helpers for the Forma Design System.
///
/// Ensures interactive elements meet the minimum touch-target size
/// recommended by Material and WCAG guidelines (48 × 48 dp).
abstract class FormaAccessibility {
  /// Minimum touch target dimension (48px) per Material / WCAG guidelines.
  static const double minTouchTarget = 48;

  /// Wraps [child] in a [SizedBox] that enforces the minimum touch target.
  ///
  /// If the child is already at least 48×48, this is effectively a no-op
  /// in terms of layout constraints.
  static Widget ensureTouchTarget({required Widget child}) {
    return SizedBox(
      width: minTouchTarget,
      height: minTouchTarget,
      child: Center(child: child),
    );
  }
}
