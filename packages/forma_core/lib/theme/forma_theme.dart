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
  ///
  /// Pass [brightness] to produce a dark theme (defaults to
  /// [Brightness.light] to preserve existing light-only themes).
  static ThemeData build({
    required FormaThemeExtension extension,
    required String fontFamily,
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final textTheme = GoogleFonts.getTextTheme(fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: extension.appBackground,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[extension],
    );
  }
}
