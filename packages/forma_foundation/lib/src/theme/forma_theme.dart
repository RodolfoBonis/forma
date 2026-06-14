import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forma_theme_extension.dart';
import 'forma_typography_extension.dart';

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

    // Fall back to the default text theme when the Google font can't be
    // resolved (e.g. offline, or in tests with runtime fetching disabled).
    // Skip the lookup entirely when runtime fetching is off, since
    // `getTextTheme` schedules unawaited font loads that throw asynchronously.
    TextTheme? textTheme;
    if (GoogleFonts.config.allowRuntimeFetching) {
      try {
        textTheme = GoogleFonts.getTextTheme(fontFamily);
      } on Exception {
        textTheme = null;
      }
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: extension.appBackground,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        extension,
        FormaTypographyExtension.fromFont(fontFamily),
      ],
    );
  }
}
