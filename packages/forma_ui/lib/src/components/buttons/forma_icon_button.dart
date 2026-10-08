import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A simple icon button with proper touch target sizing.
///
/// Uses [FormaThemeExtension.textMuted] as the default icon color.
class FormaIconButton extends StatelessWidget {
  /// Creates a [FormaIconButton].
  const FormaIconButton({
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 24,
    super.key,
  });

  /// The icon widget to display.
  final Widget icon;

  /// Tap callback.
  final VoidCallback? onPressed;

  /// Override color for the icon. Defaults to [FormaThemeExtension.textMuted].
  final Color? color;

  /// Icon size in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final effectiveColor = color ?? ext.textMuted;
    // Hit-target size follows the theme's density: 48px on mobile (unchanged),
    // tighter on compact/desktop themes via FormaShapeExtension.minTouchTarget.
    final minTouchTarget = context.formaShape.minTouchTarget;

    return Semantics(
      button: true,
      child: IconButton(
        onPressed: onPressed,
        icon: IconTheme(
          data: IconThemeData(color: effectiveColor, size: size),
          child: icon,
        ),
        constraints: BoxConstraints(
          minWidth: minTouchTarget,
          minHeight: minTouchTarget,
        ),
        padding: EdgeInsets.zero,
        splashRadius: minTouchTarget / 2,
      ),
    );
  }
}
