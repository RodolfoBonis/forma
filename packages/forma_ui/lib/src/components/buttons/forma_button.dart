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
    this.small = false,
    super.key,
  });

  /// Primary action button.
  const FormaButton.primary({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.small = false,
    super.key,
  }) : variant = FormaButtonVariant.primary;

  /// Secondary action button.
  const FormaButton.secondary({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.small = false,
    super.key,
  }) : variant = FormaButtonVariant.secondary;

  /// Destructive action button.
  const FormaButton.danger({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.small = false,
    super.key,
  }) : variant = FormaButtonVariant.danger;

  /// Ghost / subtle action button.
  const FormaButton.ghost({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.small = false,
    super.key,
  }) : variant = FormaButtonVariant.ghost;

  /// Button text.
  final String label;

  /// Tap callback. Ignored when [isLoading] is true or [variant] is
  /// [FormaButtonVariant.disabled].
  final VoidCallback? onPressed;

  /// When true, shows a spinner and hides the label.
  final bool isLoading;

  /// Fixed width. When null the button stretches to fill available width
  /// if the theme's [FormaShapeExtension.expandButtons] is true, otherwise it
  /// sizes to its content.
  final double? width;

  /// Uses [FormaShapeExtension.buttonHeightSmall] instead of the regular
  /// height.
  final bool small;

  /// Optional leading icon displayed before the label.
  final Widget? icon;

  /// Visual style of the button.
  final FormaButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final height = small ? shape.buttonHeightSmall : shape.buttonHeight;
    final effectiveWidth =
        width ?? (shape.expandButtons ? double.infinity : null);
    final colors = _resolveColors(ext);
    final isDisabled = variant == FormaButtonVariant.disabled;
    final effectiveOnPressed = isDisabled || isLoading ? null : onPressed;

    final buttonStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(colors.background),
      foregroundColor: WidgetStatePropertyAll<Color>(colors.foreground),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return colors.foreground.withValues(alpha: 0.12);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return colors.foreground.withValues(alpha: 0.08);
        }
        return null;
      }),
      minimumSize: WidgetStatePropertyAll<Size>(
        Size(shape.minTouchTarget, height),
      ),
      fixedSize: effectiveWidth == null
          ? WidgetStatePropertyAll<Size>(Size.fromHeight(height))
          : WidgetStatePropertyAll<Size>(Size(effectiveWidth, height)),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(shape.buttonRadius)),
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
        : _buildLabel(colors.foreground, typo, compact: !shape.expandButtons);

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

  Widget _buildLabel(
    Color foreground,
    FormaTypographyExtension typo, {
    required bool compact,
  }) {
    final textStyle = (compact ? typo.body14Medium : typo.title15).copyWith(
      color: foreground,
    );

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
