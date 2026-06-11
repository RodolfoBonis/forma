import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_radius.dart';
import '../../tokens/forma_spacing.dart';
import '../../tokens/forma_typography.dart';

/// A small read-only tag chip with an optional leading icon.
///
/// Neutral by default (muted text, subtle border). Pass [color] to tint the
/// icon, label, and border for emphasis (e.g. a high-priority tag).
///
/// For a selectable / toggleable chip, use `FormaSelectChip` instead.
class FormaChip extends StatelessWidget {
  /// Creates a [FormaChip].
  const FormaChip({required this.label, this.icon, this.color, super.key});

  /// Text shown in the chip.
  final String label;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional tint for the icon, label, and border. When null, the chip
  /// uses neutral muted colors.
  final Color? color;

  static const double _height = 30;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final foreground = color ?? ext.textMuted;
    final borderColor = color ?? ext.border;

    return Semantics(
      label: label,
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
        decoration: BoxDecoration(
          color: ext.cardBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(FormaRadius.chip),
          ),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: FormaSpacing.xs),
            ],
            Text(
              label,
              style: FormaTypography.caption12Med.copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
