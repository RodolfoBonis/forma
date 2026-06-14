import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Forma typography scale exposed as a [ThemeExtension].
///
/// Unlike the legacy static [FormaTypography] (which is hard-wired to Inter),
/// this extension resolves every text style from the brand's `fontFamily`,
/// so each theme can ship its own typeface. Build it via
/// [FormaTypographyExtension.fromFont] inside the theme factory and register
/// it in [ThemeData.extensions].
///
/// Read it from a widget with `Theme.of(context).extension<…>()`, or the
/// [BuildContextFormaTypography.formaTypography] shortcut.
@immutable
class FormaTypographyExtension
    extends ThemeExtension<FormaTypographyExtension> {
  /// Creates a [FormaTypographyExtension] with every text-style slot.
  const FormaTypographyExtension({
    required this.displayHero,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.title18,
    required this.title16,
    required this.title15,
    required this.body16,
    required this.body14,
    required this.body14Medium,
    required this.body13,
    required this.body13Bold,
    required this.caption12,
    required this.caption12Med,
    required this.overline10,
    required this.nav10,
    required this.nav10Bold,
  });

  /// Builds the scale from a Google Fonts [fontFamily].
  ///
  /// Falls back to a plain [TextStyle] carrying [fontFamily] when the font
  /// cannot be resolved (offline, tests with runtime fetching disabled, or an
  /// unknown family), so theme construction never throws.
  factory FormaTypographyExtension.fromFont(String fontFamily) {
    TextStyle style(double size, FontWeight weight, {double? letterSpacing}) {
      try {
        return GoogleFonts.getFont(
          fontFamily,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: letterSpacing,
        );
      } on Exception {
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          fontWeight: weight,
          letterSpacing: letterSpacing,
        );
      }
    }

    return FormaTypographyExtension(
      displayHero: style(52, FontWeight.w700),
      h1: style(34, FontWeight.w700),
      h2: style(26, FontWeight.w700),
      h3: style(22, FontWeight.w700),
      h4: style(20, FontWeight.w700),
      title18: style(18, FontWeight.w700),
      title16: style(16, FontWeight.w700),
      title15: style(15, FontWeight.w600),
      body16: style(16, FontWeight.w400),
      body14: style(14, FontWeight.w400),
      body14Medium: style(14, FontWeight.w500),
      body13: style(13, FontWeight.w400),
      body13Bold: style(13, FontWeight.w600),
      caption12: style(12, FontWeight.w400),
      caption12Med: style(12, FontWeight.w500),
      overline10: style(10, FontWeight.w500, letterSpacing: 0.8),
      nav10: style(10, FontWeight.w400),
      nav10Bold: style(10, FontWeight.w600),
    );
  }

  /// 52px / bold — hero display text for splash / marketing screens.
  final TextStyle displayHero;

  /// 34px / bold — primary page heading.
  final TextStyle h1;

  /// 26px / bold — secondary heading.
  final TextStyle h2;

  /// 22px / bold — tertiary heading.
  final TextStyle h3;

  /// 20px / bold — quaternary heading.
  final TextStyle h4;

  /// 18px / bold — large title.
  final TextStyle title18;

  /// 16px / bold — medium title.
  final TextStyle title16;

  /// 15px / semi-bold — compact title.
  final TextStyle title15;

  /// 16px / regular — default body text.
  final TextStyle body16;

  /// 14px / regular — secondary body text.
  final TextStyle body14;

  /// 14px / medium — emphasized body text.
  final TextStyle body14Medium;

  /// 13px / regular — small body text.
  final TextStyle body13;

  /// 13px / semi-bold — emphasized small body text.
  final TextStyle body13Bold;

  /// 12px / regular — caption / helper text.
  final TextStyle caption12;

  /// 12px / medium — emphasized caption text.
  final TextStyle caption12Med;

  /// 10px / medium — uppercase overline label.
  final TextStyle overline10;

  /// 10px / regular — navigation label.
  final TextStyle nav10;

  /// 10px / semi-bold — emphasized navigation label.
  final TextStyle nav10Bold;

  @override
  FormaTypographyExtension copyWith({
    TextStyle? displayHero,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? h4,
    TextStyle? title18,
    TextStyle? title16,
    TextStyle? title15,
    TextStyle? body16,
    TextStyle? body14,
    TextStyle? body14Medium,
    TextStyle? body13,
    TextStyle? body13Bold,
    TextStyle? caption12,
    TextStyle? caption12Med,
    TextStyle? overline10,
    TextStyle? nav10,
    TextStyle? nav10Bold,
  }) {
    return FormaTypographyExtension(
      displayHero: displayHero ?? this.displayHero,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      title18: title18 ?? this.title18,
      title16: title16 ?? this.title16,
      title15: title15 ?? this.title15,
      body16: body16 ?? this.body16,
      body14: body14 ?? this.body14,
      body14Medium: body14Medium ?? this.body14Medium,
      body13: body13 ?? this.body13,
      body13Bold: body13Bold ?? this.body13Bold,
      caption12: caption12 ?? this.caption12,
      caption12Med: caption12Med ?? this.caption12Med,
      overline10: overline10 ?? this.overline10,
      nav10: nav10 ?? this.nav10,
      nav10Bold: nav10Bold ?? this.nav10Bold,
    );
  }

  @override
  FormaTypographyExtension lerp(FormaTypographyExtension? other, double t) {
    if (other is! FormaTypographyExtension) return this;
    return FormaTypographyExtension(
      displayHero: TextStyle.lerp(displayHero, other.displayHero, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      h4: TextStyle.lerp(h4, other.h4, t)!,
      title18: TextStyle.lerp(title18, other.title18, t)!,
      title16: TextStyle.lerp(title16, other.title16, t)!,
      title15: TextStyle.lerp(title15, other.title15, t)!,
      body16: TextStyle.lerp(body16, other.body16, t)!,
      body14: TextStyle.lerp(body14, other.body14, t)!,
      body14Medium: TextStyle.lerp(body14Medium, other.body14Medium, t)!,
      body13: TextStyle.lerp(body13, other.body13, t)!,
      body13Bold: TextStyle.lerp(body13Bold, other.body13Bold, t)!,
      caption12: TextStyle.lerp(caption12, other.caption12, t)!,
      caption12Med: TextStyle.lerp(caption12Med, other.caption12Med, t)!,
      overline10: TextStyle.lerp(overline10, other.overline10, t)!,
      nav10: TextStyle.lerp(nav10, other.nav10, t)!,
      nav10Bold: TextStyle.lerp(nav10Bold, other.nav10Bold, t)!,
    );
  }
}

/// Convenience access to [FormaTypographyExtension] from a [BuildContext].
extension BuildContextFormaTypography on BuildContext {
  /// The resolved Forma typography scale for the current theme.
  ///
  /// Throws if no [FormaTypographyExtension] is registered — every theme built
  /// with `FormaTheme.build` registers one automatically.
  FormaTypographyExtension get formaTypography =>
      Theme.of(this).extension<FormaTypographyExtension>()!;
}
