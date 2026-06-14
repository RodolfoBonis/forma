import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';
import 'forma_shimmer.dart';

/// Pre-built skeleton placeholder shapes with shimmer animation.
///
/// Use the named constructors to create common shapes:
/// - [FormaSkeleton.circle] — avatar placeholder
/// - [FormaSkeleton.line] — text line placeholder
/// - [FormaSkeleton.box] — card / block placeholder
class FormaSkeleton extends StatelessWidget {
  const FormaSkeleton._({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  /// A circular skeleton, typically used as an avatar placeholder.
  const factory FormaSkeleton.circle({Key? key, double size}) = _CircleSkeleton;

  /// A rounded rectangle skeleton, typically used as a text line placeholder.
  const factory FormaSkeleton.line({Key? key, double? width, double height}) =
      _LineSkeleton;

  /// A rounded rectangle skeleton, typically used as a card placeholder.
  const factory FormaSkeleton.box({
    Key? key,
    double? width,
    double? height,
    double borderRadius,
  }) = _BoxSkeleton;

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return FormaShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ext.border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class _CircleSkeleton extends FormaSkeleton {
  const _CircleSkeleton({super.key, this.size = 40})
    : super._(width: size, height: size, borderRadius: size / 2);

  final double size;
}

class _LineSkeleton extends FormaSkeleton {
  const _LineSkeleton({
    super.key,
    super.width,
    super.height = FormaSpacing.base,
  }) : super._(borderRadius: height / 2);
}

class _BoxSkeleton extends FormaSkeleton {
  const _BoxSkeleton({
    super.key,
    super.width,
    double? height,
    super.borderRadius = 12,
  }) : super._(height: height ?? 80);
}
