import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Semantic visual variant for [FormaBadge].
///
/// Variants map to [FormaThemeExtension] semantic color pairs so a badge
/// follows the active theme. Apps map their domain statuses (e.g. "confirmada",
/// "ao vivo") onto these generic variants.
enum FormaBadgeVariant {
  /// Green — success / confirmed status.
  success,

  /// Yellow — warning / pending status.
  warning,

  /// Red — error / cancelled status.
  error,

  /// Blue — informational / institutional status.
  info,

  /// Gray — neutral / inactive status.
  neutral,

  /// Brand — active / highlighted status.
  primary,
}

/// A small status pill showing a colored label.
///
/// Each [FormaBadgeVariant] maps to a distinct background/text color pair
/// drawn from [FormaThemeExtension] semantic colors.
class FormaBadge extends StatelessWidget {
  /// Creates a [FormaBadge].
  const FormaBadge({required this.label, required this.variant, super.key});

  /// Text displayed inside the badge.
  final String label;

  /// Visual style controlling background and text color.
  final FormaBadgeVariant variant;

  static const double _height = 26;
  static const double _horizontalPadding = 10;
  static const double _borderRadius = 13;
  static const double _fontSize = 11;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final colors = _resolveColors(ext);

    return Semantics(
      label: label,
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.all(Radius.circular(_borderRadius)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: colors.foreground,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _BadgeColors _resolveColors(FormaThemeExtension ext) {
    return switch (variant) {
      FormaBadgeVariant.success => _BadgeColors(
        background: ext.successSurface,
        foreground: ext.successText,
      ),
      FormaBadgeVariant.warning => _BadgeColors(
        background: ext.warningSurface,
        foreground: ext.warningText,
      ),
      FormaBadgeVariant.error => _BadgeColors(
        background: ext.errorSurface,
        foreground: ext.errorText,
      ),
      FormaBadgeVariant.info => _BadgeColors(
        background: ext.infoSurface,
        foreground: ext.infoText,
      ),
      FormaBadgeVariant.neutral => _BadgeColors(
        background: ext.cardBackground,
        foreground: ext.textMuted,
      ),
      FormaBadgeVariant.primary => _BadgeColors(
        background: ext.primarySurface,
        foreground: ext.primaryColor,
      ),
    };
  }
}

class _BadgeColors {
  const _BadgeColors({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}
