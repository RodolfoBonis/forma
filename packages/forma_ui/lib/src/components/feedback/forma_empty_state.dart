import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A centered empty / zero-data placeholder.
///
/// Renders an [icon] inside a soft [FormaThemeExtension.primarySurface] circle,
/// a [title], an optional muted [message] and an optional [action] (typically a
/// `FormaButton`). Constrained to a comfortable reading width and centered in
/// its parent. Use [compact] for dense contexts (smaller circle and gaps).
class FormaEmptyState extends StatelessWidget {
  /// Creates a [FormaEmptyState].
  const FormaEmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.compact = false,
    super.key,
  });

  /// Leading glyph shown inside the primary-tinted circle.
  final IconData icon;

  /// Short headline describing the empty state.
  final String title;

  /// Optional supporting sentence shown below the [title].
  final String? message;

  /// Optional call-to-action widget (e.g. a `FormaButton`).
  final Widget? action;

  /// Uses tighter sizing and spacing for dense layouts.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final circleSize = compact ? 56.0 : 72.0;
    final iconSize = compact ? 26.0 : 32.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(FormaSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  color: ext.primarySurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: iconSize, color: ext.primaryColor),
              ),
              SizedBox(height: compact ? FormaSpacing.md : FormaSpacing.base),
              Text(
                title,
                textAlign: TextAlign.center,
                style: typo.title16.copyWith(color: ext.textPrimary),
              ),
              if (message != null) ...[
                const SizedBox(height: FormaSpacing.sm),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: typo.body14.copyWith(color: ext.textMuted),
                ),
              ],
              if (action != null) ...[
                SizedBox(height: compact ? FormaSpacing.base : FormaSpacing.lg),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
