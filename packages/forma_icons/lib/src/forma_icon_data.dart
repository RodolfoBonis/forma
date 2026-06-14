import 'package:flutter/widgets.dart';

/// A backend-agnostic icon descriptor.
///
/// An icon is either a Material glyph ([MaterialFormaIcon]) or a brand SVG
/// asset ([SvgFormaIcon]). The [FormaIcon] widget renders whichever variant it
/// receives, so call sites never care which backend a brand chose.
sealed class FormaIconData {
  const FormaIconData();
}

/// A Material [IconData] glyph — the default backend for every semantic key.
class MaterialFormaIcon extends FormaIconData {
  /// Wraps a Material [IconData].
  const MaterialFormaIcon(this.icon);

  /// The underlying Material glyph.
  final IconData icon;
}

/// A brand SVG asset, resolved via `flutter_svg`.
class SvgFormaIcon extends FormaIconData {
  /// References an SVG [assetPath], optionally from another [package].
  const SvgFormaIcon(this.assetPath, {this.package});

  /// Asset path of the SVG (e.g. `assets/icons/proof.svg`).
  final String assetPath;

  /// Owning package when the asset ships in a dependency rather than the app.
  final String? package;
}
