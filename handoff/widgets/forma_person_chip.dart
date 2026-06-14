import 'package:flutter/material.dart';

import 'package:forma_ui/forma_ui.dart';

/// A person chip showing an avatar initial and name,
/// following Forma Design System specs.
///
/// Uses [FormaAvatar] internally for the leading circle.
class FormaPersonChip extends StatelessWidget {
  /// Creates a [FormaPersonChip].
  const FormaPersonChip({
    super.key,
    required this.initial,
    required this.name,
    required this.color,
    required this.surfaceColor,
    this.isActive = false,
  });

  /// Single character displayed in the avatar.
  final String initial;

  /// The person's name displayed next to the avatar.
  final String name;

  /// The person's assigned color.
  final Color color;

  /// The person's surface/background color.
  final Color surfaceColor;

  /// Whether this chip is in the active/selected state.
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    final chipColor = isActive ? color : ext.textMuted;
    final bgColor = isActive ? surfaceColor : ext.cardBackground;
    final borderColor = isActive ? color : ext.border;
    final borderWidth = isActive ? 2.0 : 1.0;

    return Semantics(
      label: name,
      selected: isActive,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: FormaSpacing.base,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(FormaRadius.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormaAvatar(
              initial: initial,
              color: isActive ? color : ext.borderStrong,
              size: FormaAvatarSize.small,
            ),
            const SizedBox(width: FormaSpacing.sm),
            Text(
              name,
              style: FormaTypography.body14.copyWith(
                color: chipColor,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
