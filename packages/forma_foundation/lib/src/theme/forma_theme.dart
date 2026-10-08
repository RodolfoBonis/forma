import 'package:flutter/material.dart';

import 'forma_shape_extension.dart';
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
  ///
  /// Pass [shape] to tune radii and control sizes (e.g.
  /// [FormaShapeExtension.desktop]); defaults to [FormaShapeExtension.mobile].
  static ThemeData build({
    required FormaThemeExtension extension,
    required String fontFamily,
    required Color seedColor,
    Brightness brightness = Brightness.light,
    FormaShapeExtension shape = FormaShapeExtension.mobile,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    // Build the brand typography scale once: it both feeds the Material
    // [TextTheme] (so bare `Text` widgets render with DS fonts/sizes/colors)
    // and is registered as an extension (so components can read named styles).
    final typography = FormaTypographyExtension.fromFont(fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      visualDensity: shape.visualDensity,
      scaffoldBackgroundColor: extension.appBackground,
      textTheme: _buildTextTheme(typography, extension),
      extensions: <ThemeExtension<dynamic>>[extension, typography, shape],
    );
  }

  /// Maps the Forma typography scale onto Material's [TextTheme] slots and
  /// paints them with the brand's semantic text colors.
  ///
  /// Display and heading slots use [FormaThemeExtension.textPrimary]; muted
  /// label/overline slots use [FormaThemeExtension.textMuted]. This makes a
  /// plain `Text` widget render in the right brand color on any background,
  /// instead of falling back to Material's default (which is tuned for the
  /// opposite brightness and produces low-contrast text on dark themes).
  static TextTheme _buildTextTheme(
    FormaTypographyExtension t,
    FormaThemeExtension colors,
  ) {
    final primary = colors.textPrimary;
    final muted = colors.textMuted;

    return TextTheme(
      // Display — hero / large marketing headings.
      displayLarge: t.displayHero.copyWith(color: primary),
      displayMedium: t.h1.copyWith(color: primary),
      displaySmall: t.h2.copyWith(color: primary),
      // Headline — page and section headings.
      headlineLarge: t.h2.copyWith(color: primary),
      headlineMedium: t.h3.copyWith(color: primary),
      headlineSmall: t.h4.copyWith(color: primary),
      // Title — card titles, dialog headers, list headers.
      titleLarge: t.title18.copyWith(color: primary),
      titleMedium: t.title16.copyWith(color: primary),
      titleSmall: t.title15.copyWith(color: primary),
      // Body — primary copy.
      bodyLarge: t.body16.copyWith(color: primary),
      bodyMedium: t.body14.copyWith(color: primary),
      bodySmall: t.body13.copyWith(color: primary),
      // Label — buttons, captions, overlines (secondary emphasis).
      labelLarge: t.body14Medium.copyWith(color: primary),
      labelMedium: t.caption12Med.copyWith(color: muted),
      labelSmall: t.overline10.copyWith(color: muted),
    );
  }
}
