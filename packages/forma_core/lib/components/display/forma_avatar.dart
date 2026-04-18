import 'package:flutter/material.dart';

/// Size presets for [FormaAvatar].
enum FormaAvatarSize {
  /// 24px diameter, borderRadius 7.2, fontSize 10.
  xsmall(24, 7.2, 10),

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

/// A colored circle with a single-character initial or a network image.
///
/// Used for user / team avatars throughout the Forma Design System.
class FormaAvatar extends StatelessWidget {
  /// Creates a [FormaAvatar].
  const FormaAvatar({
    required this.initial,
    required this.color,
    this.imageUrl,
    this.size = FormaAvatarSize.medium,
    this.borderColor,
    this.borderWidth = 0,
    super.key,
  });

  /// A single character displayed in the center (fallback when no image).
  final String initial;

  /// Background color of the avatar (used behind the initial).
  final Color color;

  /// Optional network image URL. When provided, the image is displayed
  /// instead of the initial. Falls back to the initial on load error.
  final String? imageUrl;

  /// Size preset controlling diameter, radius, and font size.
  final FormaAvatarSize size;

  /// Optional border color drawn around the avatar.
  final Color? borderColor;

  /// Border width in logical pixels. Only visible when [borderColor] is set.
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final innerSize = size.diameter - (borderWidth * 2);

    return Semantics(
      label: initial,
      child: Container(
        width: size.diameter,
        height: size.diameter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size.borderRadius)),
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(size.borderRadius - borderWidth),
          ),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: innerSize,
                  height: innerSize,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _InitialFallback(
                    initial: initial,
                    color: color,
                    size: innerSize,
                    fontSize: size.fontSize,
                  ),
                )
              : _InitialFallback(
                  initial: initial,
                  color: color,
                  size: innerSize,
                  fontSize: size.fontSize,
                ),
        ),
      ),
    );
  }
}

class _InitialFallback extends StatelessWidget {
  const _InitialFallback({
    required this.initial,
    required this.color,
    required this.size,
    required this.fontSize,
  });

  final String initial;
  final Color color;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
