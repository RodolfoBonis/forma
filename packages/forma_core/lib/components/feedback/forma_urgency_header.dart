import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_spacing.dart';
import '../../tokens/forma_typography.dart';

/// An urgency header banner following Forma Design System specs.
///
/// Displays a prominent banner with a [title] and optional [subtitle]
/// on an urgency-colored background to draw immediate attention.
class FormaUrgencyHeader extends StatelessWidget {
  /// Creates a [FormaUrgencyHeader].
  const FormaUrgencyHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  /// The main urgency message.
  final String title;

  /// Optional secondary message with additional context.
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: FormaSpacing.base,
        vertical: FormaSpacing.md,
      ),
      decoration: BoxDecoration(
        color: ext.urgencySurface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: FormaTypography.title16.copyWith(
              color: ext.textPrimary,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: FormaSpacing.xs),
            Text(
              subtitle!,
              style: FormaTypography.body14.copyWith(
                color: ext.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
