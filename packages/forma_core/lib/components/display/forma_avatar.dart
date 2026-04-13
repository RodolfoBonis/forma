import 'package:flutter/material.dart';

/// Size presets for [FormaAvatar].
enum FormaAvatarSize {
  /// 36px diameter, borderRadius 10.8, fontSize 15.
  small(36, 10.8, 15),

  /// 44px diameter, borderRadius 13.2, fontSize 18.
  medium(44, 13.2, 18),

  /// 56px diameter, borderRadius 16.8, fontSize 23.
  large(56, 16.8, 23);

  const FormaAvatarSize(this.diameter, this.borderRadius, this.fontSize);

  /// Avatar diameter in logical pixels.
  final double diameter;

  /// Corner radius in logical pixels.
  final double borderRadius;

  /// Text size in logical pixels.
  final double fontSize;
}

/// A colored circle with a single-character initial.
///
/// Used for user / team avatars throughout the Forma Design System.
class FormaAvatar extends StatelessWidget {
  /// Creates a [FormaAvatar].
  const FormaAvatar({
    required this.initial,
    required this.color,
    this.size = FormaAvatarSize.medium,
    super.key,
  });

  /// A single character displayed in the center.
  final String initial;

  /// Background color of the avatar.
  final Color color;

  /// Size preset controlling diameter, radius, and font size.
  final FormaAvatarSize size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: initial,
      child: Container(
        width: size.diameter,
        height: size.diameter,
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              BorderRadius.all(Radius.circular(size.borderRadius)),
        ),
        alignment: Alignment.center,
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: size.fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
