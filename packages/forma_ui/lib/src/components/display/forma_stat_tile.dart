import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact metric tile: a colored icon, a large value, and a label.
///
/// Used for dashboard stats (streaks, completed counts, pending items).
/// The surface and text colors come from [FormaThemeExtension]; [color]
/// tints the icon and defaults to the primary brand color.
class FormaStatTile extends StatelessWidget {
  /// Creates a [FormaStatTile].
  const FormaStatTile({
    required this.value,
    required this.label,
    required this.icon,
    this.color,
    this.width,
    super.key,
  });

  /// The prominent metric value (e.g. "12").
  final String value;

  /// Caption shown beneath the value.
  final String label;

  /// Leading icon.
  final IconData icon;

  /// Icon tint. Defaults to [FormaThemeExtension.primaryColor].
  final Color? color;

  /// Fixed width. When null, the tile sizes to its parent.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final iconColor = color ?? ext.primaryColor;

    return Container(
      width: width,
      padding: const EdgeInsets.all(FormaSpacing.base),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: const BorderRadius.all(Radius.circular(FormaRadius.card)),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: FormaSpacing.sm),
              Text(value, style: typo.title18.copyWith(color: ext.textPrimary)),
            ],
          ),
          const SizedBox(height: FormaSpacing.xs),
          Text(label, style: typo.caption12.copyWith(color: ext.textMuted)),
        ],
      ),
    );
  }
}
