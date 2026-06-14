import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forma_foundation/forma_foundation.dart';

import 'forma_icon_data.dart';
import 'forma_icon_key.dart';
import 'forma_icon_registry.dart';

/// Renders a Forma icon, resolving Material glyphs and brand SVGs uniformly.
///
/// Reference icons by semantic intent with the default constructor
/// (`FormaIcon(FormaIconKey.confirm)`) so a brand can override the rendering
/// via a [FormaIconScope]. Use [FormaIcon.data] for an ad-hoc [FormaIconData].
class FormaIcon extends StatelessWidget {
  /// Renders the icon registered for [key] in the nearest [FormaIconScope]
  /// (falling back to the Material default).
  const FormaIcon(this.key0, {this.size = 24, this.color, super.key})
    : _data = null;

  /// Renders an explicit [data] descriptor, bypassing the registry.
  const FormaIcon.data(
    FormaIconData data, {
    this.size = 24,
    this.color,
    super.key,
  }) : _data = data,
       key0 = null;

  /// Semantic key resolved through the registry (null when [FormaIcon.data]).
  final FormaIconKey? key0;

  final FormaIconData? _data;

  /// Rendered size in logical pixels (square).
  final double size;

  /// Icon color. Defaults to the theme's `textPrimary`, then `IconTheme`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final data = _data ?? FormaIconScope.of(context).resolve(key0!);
    final resolvedColor =
        color ??
        Theme.of(context).extension<FormaThemeExtension>()?.textPrimary ??
        IconTheme.of(context).color ??
        const Color(0xFF000000);

    return switch (data) {
      MaterialFormaIcon(:final icon) => Icon(
        icon,
        size: size,
        color: resolvedColor,
      ),
      SvgFormaIcon(:final assetPath, :final package) => SvgPicture.asset(
        assetPath,
        package: package,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(resolvedColor, BlendMode.srcIn),
      ),
    };
  }
}
