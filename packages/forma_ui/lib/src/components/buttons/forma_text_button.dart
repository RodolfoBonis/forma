import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Visual variant for [FormaTextButton].
enum FormaTextButtonVariant {
  /// Primary action — brand-colored label.
  primary,

  /// Destructive action — error-colored label.
  danger,

  /// Low-emphasis action — muted label.
  neutral,
}

/// A flat, text-only button for the Forma Design System.
///
/// Unlike [FormaButton] (a filled, fixed-height action), this renders just a
/// colored label with no fill or border — for low-emphasis or secondary
/// actions, e.g. a "sign in" link beneath a primary call-to-action. It keeps a
/// 48px minimum touch target and stretches to fill its width by default; pass
/// [width] to constrain it.
class FormaTextButton extends StatelessWidget {
  /// Creates a [FormaTextButton] with the given [variant].
  const FormaTextButton({
    required this.label,
    this.onPressed,
    this.width,
    this.variant = FormaTextButtonVariant.primary,
    super.key,
  });

  /// Primary (brand-colored) text button.
  const FormaTextButton.primary({
    required this.label,
    this.onPressed,
    this.width,
    super.key,
  }) : variant = FormaTextButtonVariant.primary;

  /// Destructive (error-colored) text button.
  const FormaTextButton.danger({
    required this.label,
    this.onPressed,
    this.width,
    super.key,
  }) : variant = FormaTextButtonVariant.danger;

  /// Low-emphasis (muted) text button.
  const FormaTextButton.neutral({
    required this.label,
    this.onPressed,
    this.width,
    super.key,
  }) : variant = FormaTextButtonVariant.neutral;

  /// Button text.
  final String label;

  /// Tap callback. When null the button is disabled.
  final VoidCallback? onPressed;

  /// Fixed width. When null the button stretches to fill available width.
  final double? width;

  /// Visual style of the button.
  final FormaTextButtonVariant variant;

  static const double _minHeight = 48;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final isDisabled = onPressed == null;
    final color = isDisabled ? ext.textHint : _resolveColor(ext);

    return Semantics(
      button: true,
      enabled: !isDisabled,
      label: label,
      child: SizedBox(
        width: width ?? double.infinity,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: color,
            minimumSize: const Size(0, _minHeight),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(FormaRadius.small),
              ),
            ),
          ),
          child: Text(label, style: typo.title15.copyWith(color: color)),
        ),
      ),
    );
  }

  Color _resolveColor(FormaThemeExtension ext) => switch (variant) {
    FormaTextButtonVariant.primary => ext.primaryColor,
    FormaTextButtonVariant.danger => ext.errorColor,
    FormaTextButtonVariant.neutral => ext.textMuted,
  };
}
