import 'package:flutter/material.dart';

/// A named [ThemeData] selectable from the preview toolbar.
class GalleryTheme {
  /// Creates a named theme.
  const GalleryTheme(this.name, this.data);

  /// Display name in the theme switcher.
  final String name;

  /// The Flutter theme applied to the preview canvas.
  final ThemeData data;

  /// Whether the theme is dark (drives the preview background default).
  bool get isDark => data.brightness == Brightness.dark;
}
