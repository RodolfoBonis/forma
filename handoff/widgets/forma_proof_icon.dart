import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// The kind of proof a [FormaProofIcon] represents.
enum FormaProofType {
  /// Photo evidence.
  foto(Icons.photo_camera_outlined),

  /// Text evidence.
  texto(Icons.notes),

  /// Simple completion check.
  check(Icons.check);

  const FormaProofType(this.icon);

  /// Icon shown for this proof type.
  final IconData icon;
}

/// A small square icon badge indicating a proof / evidence type.
///
/// Surface and outline colors come from [FormaThemeExtension]; [color]
/// optionally tints the icon.
class FormaProofIcon extends StatelessWidget {
  /// Creates a [FormaProofIcon] for the given [type].
  const FormaProofIcon({
    required this.type,
    this.color,
    this.size = 32,
    super.key,
  });

  /// The proof type, controlling which icon is shown.
  final FormaProofType type;

  /// Optional icon tint. Defaults to [FormaThemeExtension.textMuted].
  final Color? color;

  /// Side length of the square badge.
  final double size;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final iconColor = color ?? ext.textMuted;

    return Semantics(
      label: type.name,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: ext.resolvedSurfaceElevated,
          borderRadius: const BorderRadius.all(
            Radius.circular(FormaRadius.input),
          ),
          border: Border.all(color: ext.border, width: 0.5),
        ),
        alignment: Alignment.center,
        child: Icon(type.icon, size: size * 0.5, color: iconColor),
      ),
    );
  }
}
