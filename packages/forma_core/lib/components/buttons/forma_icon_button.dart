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

  static const double _minTouchTarget = 48;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final effectiveColor = color ?? ext.textMuted;

    return Semantics(
      button: true,
      child: IconButton(
        onPressed: onPressed,
        icon: IconTheme(
          data: IconThemeData(color: effectiveColor, size: size),
          child: icon,
        ),
        constraints: const BoxConstraints(
          minWidth: _minTouchTarget,
          minHeight: _minTouchTarget,
        ),
        padding: EdgeInsets.zero,
        splashRadius: _minTouchTarget / 2,
      ),
    );
  }
}
