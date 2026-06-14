import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Alert severity variant for [FormaAlertBanner].
enum FormaAlertVariant {
  /// Positive confirmation — green tones.
  success,

  /// Non-blocking caution — yellow tones.
  warning,

  /// Destructive / error state — red tones.
  error,

  /// Neutral informational — indigo tones.
  info,

  /// High-priority urgency — warm tones.
  urgency,
}

/// An alert banner following Forma Design System specs.
///
/// Displays a tinted message strip with an optional leading [icon].
class FormaAlertBanner extends StatelessWidget {
  /// Creates a [FormaAlertBanner].
  const FormaAlertBanner({
    super.key,
    required this.message,
    required this.variant,
    this.icon,
  });

  /// The alert message text.
  final String message;

  /// The severity variant controlling colors.
  final FormaAlertVariant variant;

  /// Optional leading icon widget.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final colors = _resolveColors(ext);

    return Semantics(
      label: message,
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(color: colors.border, width: 1),
          borderRadius: BorderRadius.circular(FormaRadius.small),
        ),
        child: Row(
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 12)],
            Expanded(
              child: Text(
                message,
                style: typo.body14.copyWith(color: colors.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _AlertColors _resolveColors(FormaThemeExtension ext) {
    return switch (variant) {
      FormaAlertVariant.success => _AlertColors(
        background: ext.successSurface,
        border: ext.successColor.withValues(alpha: 0.5),
        text: ext.successText,
      ),
      FormaAlertVariant.warning => _AlertColors(
        background: ext.warningSurface,
        border: ext.warningColor.withValues(alpha: 0.5),
        text: ext.warningText,
      ),
      FormaAlertVariant.error => _AlertColors(
        background: ext.errorSurface,
        border: ext.errorColor.withValues(alpha: 0.5),
        text: ext.errorText,
      ),
      FormaAlertVariant.info => _AlertColors(
        background: ext.infoSurface,
        border: ext.infoText.withValues(alpha: 0.3),
        text: ext.infoText,
      ),
      FormaAlertVariant.urgency => _AlertColors(
        background: ext.urgencySurface,
        border: ext.warningColor.withValues(alpha: 0.5),
        text: ext.warningText,
      ),
    };
  }
}

class _AlertColors {
  const _AlertColors({
    required this.background,
    required this.border,
    required this.text,
  });

  final Color background;
  final Color border;
  final Color text;
}
