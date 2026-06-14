import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Visual variant for [FormaButton].
enum FormaButtonVariant {
  /// Primary action — filled with brand color.
  primary,

  /// Secondary action — outlined / neutral.
  secondary,

  /// Destructive action — filled with error color.
  danger,

  /// Ghost / subtle action — tinted primary surface.
  ghost,

  /// Visually and functionally disabled.
  disabled,
}

/// A themed action button for the Forma Design System.
///
/// Provides named constructors for each [FormaButtonVariant] and supports
/// an optional leading [icon] and [isLoading] state.
class FormaButton extends StatelessWidget {
  /// Creates a [FormaButton] with the given [variant].
  const FormaButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.variant = FormaButtonVariant.primary,
    super.key,
  });

  /// Primary action button.
  const FormaButton.primary({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    super.key,
  }) : variant = FormaButtonVariant.primary;

  /// Secondary action button.
  const FormaButton.secondary({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    super.key,
  }) : variant = FormaButtonVariant.secondary;

  /// Destructive action button.
  const FormaButton.danger({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    super.key,
  }) : variant = FormaButtonVariant.danger;

  /// Ghost / subtle action button.
  const FormaButton.ghost({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    super.key,
  }) : variant = FormaButtonVariant.ghost;

  /// Button text.
  final String label;

  /// Tap callback. Ignored when [isLoading] is true or [variant] is
  /// [FormaButtonVariant.disabled].
  final VoidCallback? onPressed;

  /// When true, shows a spinner and hides the label.
  final bool isLoading;

  /// Fixed width. When null the button stretches to fill available width.
  final double? width;

  /// Optional leading icon displayed before the label.
  final Widget? icon;

  /// Visual style of the button.
  final FormaButtonVariant variant;

  static const double _height = 56;
  static const double _minTouchTarget = 48;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final colors = _resolveColors(ext);
    final isDisabled = variant == FormaButtonVariant.disabled;
    final effectiveOnPressed = isDisabled || isLoading ? null : onPressed;

    final buttonStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(colors.background),
      foregroundColor: WidgetStatePropertyAll<Color>(colors.foreground),
      minimumSize: const WidgetStatePropertyAll<Size>(
        Size(_minTouchTarget, _height),
      ),
      fixedSize: WidgetStatePropertyAll<Size>(
        Size(width ?? double.infinity, _height),
      ),
      shape: const WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(FormaRadius.button)),
        ),
      ),
      side: colors.borderColor != null
          ? WidgetStatePropertyAll<BorderSide>(
              BorderSide(color: colors.borderColor!),
            )
          : null,
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: FormaSpacing.base),
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
    );

    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(colors.foreground),
            ),
          )
        : _buildLabel(colors.foreground, typo);

    return Semantics(
      button: true,
      enabled: !isDisabled && !isLoading,
      label: label,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: buttonStyle,
        child: child,
      ),
    );
  }

  Widget _buildLabel(Color foreground, FormaTypographyExtension typo) {
    final textStyle = typo.title15.copyWith(color: foreground);

    if (icon == null) {
      return Text(label, style: textStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!,
        const SizedBox(width: FormaSpacing.sm),
        Text(label, style: textStyle),
      ],
    );
  }

  _ButtonColors _resolveColors(FormaThemeExtension ext) {
    return switch (variant) {
      FormaButtonVariant.primary => _ButtonColors(
        background: ext.primaryColor,
        foreground: Colors.white,
      ),
      FormaButtonVariant.secondary => _ButtonColors(
        background: ext.cardBackground,
        foreground: ext.textMuted,
        borderColor: ext.border,
      ),
      FormaButtonVariant.danger => _ButtonColors(
        background: ext.errorColor,
        foreground: Colors.white,
      ),
      FormaButtonVariant.ghost => _ButtonColors(
        background: ext.primarySurface,
        foreground: ext.primaryColor,
        borderColor: ext.primaryBorder,
      ),
      FormaButtonVariant.disabled => _ButtonColors(
        background: ext.border,
        foreground: ext.textHint,
      ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    this.borderColor,
  });

  final Color background;
  final Color foreground;
  final Color? borderColor;
}
