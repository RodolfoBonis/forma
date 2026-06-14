import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A toggleable filter chip with an optional leading icon.
///
/// When [selected], the chip uses a subtle primary-tinted surface with a
/// primary border; otherwise it is outlined and muted. Colors come from
/// [FormaThemeExtension].
class FormaSelectChip extends StatelessWidget {
  /// Creates a [FormaSelectChip].
  const FormaSelectChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    super.key,
  });

  /// Text shown in the chip.
  final String label;

  /// Whether the chip is currently selected.
  final bool selected;

  /// Called with the new selection state when tapped.
  final ValueChanged<bool> onSelected;

  /// Optional leading icon.
  final IconData? icon;

  static const double _height = 36;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    final background = selected
        ? ext.resolvedPrimarySubtle
        : Colors.transparent;
    final borderColor = selected ? ext.primaryColor : ext.border;
    final foreground = selected ? ext.textPrimary : ext.textMuted;
    final iconColor = selected ? ext.primaryColor : ext.textMuted;

    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(FormaRadius.chip),
          ),
          onTap: () => onSelected(!selected),
          child: Container(
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
            decoration: BoxDecoration(
              color: background,
              borderRadius: const BorderRadius.all(
                Radius.circular(FormaRadius.chip),
              ),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: iconColor),
                  const SizedBox(width: FormaSpacing.xs),
                ],
                Text(
                  label,
                  style: FormaTypography.body14Medium.copyWith(
                    color: foreground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
