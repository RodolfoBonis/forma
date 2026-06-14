import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Applies an animated shimmer / shine effect over its [child].
///
/// Used internally by [FormaSkeleton] shapes. Can also wrap arbitrary
/// widgets to give them a loading shimmer look.
class FormaShimmer extends StatefulWidget {
  /// Creates a [FormaShimmer].
  const FormaShimmer({super.key, required this.child});

  /// The widget to apply the shimmer effect on.
  final Widget child;

  @override
  State<FormaShimmer> createState() => _FormaShimmerState();
}

class _FormaShimmerState extends State<FormaShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final baseColor = ext.border;
    final highlightColor = ext.cardBackground;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            final value = _controller.value;
            final start = value - 0.3;
            final end = value + 0.3;

            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [start.clamp(0.0, 1.0), value, end.clamp(0.0, 1.0)],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
