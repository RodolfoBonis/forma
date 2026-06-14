import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A centered adaptive loading indicator following Forma Design System specs.
///
/// Uses [CircularProgressIndicator.adaptive] with the theme's primary color.
class FormaLoading extends StatelessWidget {
  /// Creates a [FormaLoading].
  const FormaLoading({
    super.key,
    this.size = 24,
    this.strokeWidth = 2.5,
    this.color,
  });

  /// The diameter of the loading indicator.
  final double size;

  /// The stroke width of the circular indicator.
  final double strokeWidth;

  /// Optional color override. Falls back to the theme's primary color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final indicatorColor = color ?? ext.primaryColor;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        ),
      ),
    );
  }
}
