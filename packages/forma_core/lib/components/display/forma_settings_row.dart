import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A tappable settings list row: leading icon, title, optional subtitle,
/// and a trailing widget (a chevron by default).
///
/// Colors are drawn from [FormaThemeExtension].
class FormaSettingsRow extends StatelessWidget {
  /// Creates a [FormaSettingsRow].
  const FormaSettingsRow({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    super.key,
  });

  /// Leading icon.
  final IconData icon;

  /// Primary label.
  final String title;

  /// Optional secondary label beneath the title.
  final String? subtitle;

  /// Trailing widget. Defaults to a chevron when null.
  final Widget? trailing;

  /// Tap callback for the whole row.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: FormaSpacing.xs,
            vertical: FormaSpacing.md,
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: ext.textMuted),
              const SizedBox(width: FormaSpacing.base),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: FormaTypography.title15.copyWith(
                        color: ext.textPrimary,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: FormaTypography.caption12.copyWith(
                          color: ext.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: FormaSpacing.sm),
              trailing ??
                  Icon(Icons.chevron_right, size: 20, color: ext.textHint),
            ],
          ),
        ),
      ),
    );
  }
}
