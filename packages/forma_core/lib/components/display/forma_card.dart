import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_radius.dart';
import '../../tokens/forma_spacing.dart';

/// Visual variant for [FormaCard].
enum FormaCardVariant {
  /// Standard card with border and rounded corners.
  basic,

  /// Dark hero card for prominent sections.
  heroDark,

  /// Card with a colored left accent border (e.g. schedule items).
  swap,

  /// Selectable card that highlights its border when [selected].
  shift,
}

/// A themed card container for the Forma Design System.
///
/// Supports four [FormaCardVariant]s with optional accent color
/// and selection state.
class FormaCard extends StatelessWidget {
  /// Creates a [FormaCard].
  const FormaCard({
    required this.child,
    this.variant = FormaCardVariant.basic,
    this.accentColor,
    this.selected = false,
    this.selectedColor,
    this.backgroundColor,
    this.padding,
    this.width,
    this.height,
    super.key,
  });

  /// Content rendered inside the card.
  final Widget child;

  /// Visual style of the card.
  final FormaCardVariant variant;

  /// Left accent color used by the [FormaCardVariant.swap] variant.
  final Color? accentColor;

  /// Whether the card is selected (only affects [FormaCardVariant.shift]).
  final bool selected;

  /// Border color when [selected] is true (only affects
  /// [FormaCardVariant.shift]).
  final Color? selectedColor;

  /// Custom background color. When null, uses variant-specific defaults.
  final Color? backgroundColor;

  /// Custom padding. When null, uses variant-specific defaults.
  final EdgeInsetsGeometry? padding;

  /// Fixed width for the card. When null, the card sizes to its parent.
  final double? width;

  /// Fixed height for the card. When null, the card sizes to its content.
  final double? height;

  static const Color _heroDarkBg = Color(0xFF0F0F0F);
  static const double _swapAccentWidth = 5;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return switch (variant) {
      FormaCardVariant.basic => _buildBasic(ext),
      FormaCardVariant.heroDark => _buildHeroDark(),
      FormaCardVariant.swap => _buildSwap(ext),
      FormaCardVariant.shift => _buildShift(ext),
    };
  }

  Widget _buildBasic(FormaThemeExtension ext) {
    return Container(
      width: width,
      height: height,
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: FormaSpacing.base,
            vertical: FormaSpacing.lg,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ext.cardBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.cardLg),
        ),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: child,
    );
  }

  Widget _buildHeroDark() {
    return Container(
      width: width,
      height: height,
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: FormaSpacing.base,
            vertical: FormaSpacing.lg,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? _heroDarkBg,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.cardLg),
        ),
      ),
      child: child,
    );
  }

  Widget _buildSwap(FormaThemeExtension ext) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? ext.cardBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.button),
        ),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: _swapAccentWidth, color: accentColor),
            Expanded(
              child: Padding(
                padding:
                    padding ??
                    const EdgeInsets.symmetric(
                      horizontal: FormaSpacing.base,
                      vertical: FormaSpacing.lg,
                    ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShift(FormaThemeExtension ext) {
    final borderColor = selected
        ? (selectedColor ?? ext.primaryColor)
        : ext.border;
    final borderWidth = selected ? 2.0 : 0.5;

    return Container(
      width: width,
      height: height,
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: FormaSpacing.base,
            vertical: FormaSpacing.lg,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ext.cardBackground,
        borderRadius: const BorderRadius.all(Radius.circular(FormaRadius.card)),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: child,
    );
  }
}
