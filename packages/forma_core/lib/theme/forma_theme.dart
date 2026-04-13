import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forma_theme_extension.dart';

/// Builds a complete [ThemeData] for Forma-based applications.
///
/// Combines Material 3 defaults with a [FormaThemeExtension] color contract
/// and the specified font family.
class FormaTheme {
  /// Builds a [ThemeData] configured with Material 3, a seed-based
  /// [ColorScheme], the provided [extension], and the given [fontFamily].
  static ThemeData build({
    required FormaThemeExtension extension,
    required String fontFamily,
    required Color seedColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(seedColor: seedColor);
    final textTheme = GoogleFonts.getTextTheme(fontFamily);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[extension],
    );
  }
}
