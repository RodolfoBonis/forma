import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';

/// Visual variant for [FormaBadge].
enum FormaBadgeVariant {
  /// Green — confirmed / success status.
  confirmada,

  /// Yellow — pending / awaiting status.
  pendente,

  /// Red — cancelled / error status.
  cancelada,

  /// Purple — official / institutional status.
  oficial,

  /// Dark — live / broadcasting status.
  aoVivo,

  /// Yellow — awaiting action.
  aguardando,

  /// Blue / primary — active status.
  ativo,
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
      FormaBadgeVariant.confirmada => _BadgeColors(
        background: ext.successSurface,
        foreground: ext.successText,
      ),
      FormaBadgeVariant.pendente ||
      FormaBadgeVariant.aguardando => _BadgeColors(
        background: ext.warningSurface,
        foreground: ext.warningText,
      ),
      FormaBadgeVariant.cancelada => _BadgeColors(
        background: ext.errorSurface,
        foreground: ext.errorText,
      ),
      FormaBadgeVariant.oficial => _BadgeColors(
        background: ext.secondarySurface,
        foreground: ext.secondaryColor,
      ),
      FormaBadgeVariant.aoVivo => const _BadgeColors(
        background: Color(0xFF1A1840),
        foreground: Color(0xFFB5ABFF),
      ),
      FormaBadgeVariant.ativo => _BadgeColors(
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
