import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A small pill with a colored leading dot and a label, tinted by [color].
///
/// Used for role / category markers (e.g. Dom / Sub). The background is a
/// low-opacity wash of [color] and the border/text use [color] directly.
class FormaRoleBadge extends StatelessWidget {
  /// Creates a [FormaRoleBadge] with an explicit [color].
  const FormaRoleBadge({required this.label, required this.color, super.key});

  /// Text shown in the badge.
  final String label;

  /// Tint applied to the dot, border, and text.
  final Color color;

  static const double _height = 28;
  static const double _dotSize = 7;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: const BorderRadius.all(Radius.circular(_height / 2)),
          border: Border.all(color: color.withValues(alpha: 0.6)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: FormaSpacing.sm),
            Text(
              label,
              style: FormaTypography.caption12Med.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
