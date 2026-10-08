import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../tokens/forma_radius.dart';

/// Per-theme shape & density contract exposed as a [ThemeExtension].
///
/// [FormaRadius] and the component heights are tuned for touch-first mobile
/// apps. Desktop (pointer-first) apps need tighter radii and shorter controls.
/// Components read this extension through [BuildContextFormaShape.formaShape],
/// which falls back to [FormaShapeExtension.mobile] when a theme does not
/// register one — so existing themes keep their exact current look.
@immutable
class FormaShapeExtension extends ThemeExtension<FormaShapeExtension> {
  /// Creates a [FormaShapeExtension] with every shape/density slot.
  const FormaShapeExtension({
    required this.buttonRadius,
    required this.inputRadius,
    required this.cardRadius,
    required this.chipRadius,
    required this.dialogRadius,
    required this.buttonHeight,
    required this.buttonHeightSmall,
    required this.inputHeight,
    required this.minTouchTarget,
    required this.expandButtons,
    required this.visualDensity,
  });

  /// Touch-first defaults — identical to the values Forma shipped before this
  /// extension existed.
  static const FormaShapeExtension mobile = FormaShapeExtension(
    buttonRadius: FormaRadius.button,
    inputRadius: FormaRadius.input,
    cardRadius: FormaRadius.card,
    chipRadius: FormaRadius.chip,
    dialogRadius: FormaRadius.cardLg,
    buttonHeight: 56,
    buttonHeightSmall: 44,
    inputHeight: 56,
    minTouchTarget: 48,
    expandButtons: true,
    visualDensity: VisualDensity.standard,
  );

  /// Pointer-first, compact defaults for desktop and dense web apps.
  static const FormaShapeExtension desktop = FormaShapeExtension(
    buttonRadius: 8,
    inputRadius: 8,
    cardRadius: 12,
    chipRadius: 999,
    dialogRadius: 14,
    buttonHeight: 38,
    buttonHeightSmall: 32,
    inputHeight: 38,
    minTouchTarget: 32,
    expandButtons: false,
    visualDensity: VisualDensity.compact,
  );

  /// Corner radius for buttons.
  final double buttonRadius;

  /// Corner radius for text inputs, selects and pickers.
  final double inputRadius;

  /// Corner radius for cards and panels.
  final double cardRadius;

  /// Corner radius for chips and pills.
  final double chipRadius;

  /// Corner radius for dialogs, popovers and sheets.
  final double dialogRadius;

  /// Height of a regular button.
  final double buttonHeight;

  /// Height of a small button.
  final double buttonHeightSmall;

  /// Minimum height of single-line inputs.
  final double inputHeight;

  /// Minimum hit-target size for icon buttons.
  final double minTouchTarget;

  /// Whether buttons stretch to the available width when no width is given.
  final bool expandButtons;

  /// Material density applied to the [ThemeData].
  final VisualDensity visualDensity;

  @override
  FormaShapeExtension copyWith({
    double? buttonRadius,
    double? inputRadius,
    double? cardRadius,
    double? chipRadius,
    double? dialogRadius,
    double? buttonHeight,
    double? buttonHeightSmall,
    double? inputHeight,
    double? minTouchTarget,
    bool? expandButtons,
    VisualDensity? visualDensity,
  }) {
    return FormaShapeExtension(
      buttonRadius: buttonRadius ?? this.buttonRadius,
      inputRadius: inputRadius ?? this.inputRadius,
      cardRadius: cardRadius ?? this.cardRadius,
      chipRadius: chipRadius ?? this.chipRadius,
      dialogRadius: dialogRadius ?? this.dialogRadius,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonHeightSmall: buttonHeightSmall ?? this.buttonHeightSmall,
      inputHeight: inputHeight ?? this.inputHeight,
      minTouchTarget: minTouchTarget ?? this.minTouchTarget,
      expandButtons: expandButtons ?? this.expandButtons,
      visualDensity: visualDensity ?? this.visualDensity,
    );
  }

  @override
  FormaShapeExtension lerp(FormaShapeExtension? other, double t) {
    if (other == null) return this;
    double l(double a, double b) => lerpDouble(a, b, t)!;
    return FormaShapeExtension(
      buttonRadius: l(buttonRadius, other.buttonRadius),
      inputRadius: l(inputRadius, other.inputRadius),
      cardRadius: l(cardRadius, other.cardRadius),
      chipRadius: l(chipRadius, other.chipRadius),
      dialogRadius: l(dialogRadius, other.dialogRadius),
      buttonHeight: l(buttonHeight, other.buttonHeight),
      buttonHeightSmall: l(buttonHeightSmall, other.buttonHeightSmall),
      inputHeight: l(inputHeight, other.inputHeight),
      minTouchTarget: l(minTouchTarget, other.minTouchTarget),
      expandButtons: t < 0.5 ? expandButtons : other.expandButtons,
      visualDensity: VisualDensity.lerp(visualDensity, other.visualDensity, t),
    );
  }
}

/// Shortcut to read the active [FormaShapeExtension].
extension BuildContextFormaShape on BuildContext {
  /// The theme's shape contract, or [FormaShapeExtension.mobile] when the
  /// theme does not register one.
  FormaShapeExtension get formaShape =>
      Theme.of(this).extension<FormaShapeExtension>() ??
      FormaShapeExtension.mobile;
}
