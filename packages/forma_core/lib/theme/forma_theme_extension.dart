import 'package:flutter/material.dart';

/// Forma semantic color palette exposed as a [ThemeExtension].
///
/// Register an instance via [ThemeData.extensions] so widgets can access
/// colors with `Theme.of(context).extension<FormaThemeExtension>()`.
class FormaThemeExtension extends ThemeExtension<FormaThemeExtension> {
  /// Creates a [FormaThemeExtension] with all required semantic colors.
  const FormaThemeExtension({
    required this.appBackground,
    required this.cardBackground,
    required this.primaryColor,
    required this.primarySurface,
    required this.primaryBorder,
    required this.secondaryColor,
    required this.secondarySurface,
    required this.accentColor,
    required this.accentSurface,
    required this.textPrimary,
    required this.textMuted,
    required this.textHint,
    required this.border,
    required this.borderStrong,
    required this.successColor,
    required this.successSurface,
    required this.successText,
    required this.warningColor,
    required this.warningSurface,
    required this.warningText,
    required this.urgencySurface,
    required this.errorColor,
    required this.errorSurface,
    required this.errorText,
    required this.infoSurface,
    required this.infoText,
  });

  /// Main scaffold / page background.
  final Color appBackground;

  /// Default card / container surface.
  final Color cardBackground;

  /// Primary brand color for key actions and accents.
  final Color primaryColor;

  /// Light tinted surface for primary-related containers.
  final Color primarySurface;

  /// Border color used alongside primary surfaces.
  final Color primaryBorder;

  /// Secondary brand color.
  final Color secondaryColor;

  /// Light tinted surface for secondary containers.
  final Color secondarySurface;

  /// Accent color for highlights and decorative elements.
  final Color accentColor;

  /// Light tinted surface for accent containers.
  final Color accentSurface;

  /// Primary text color — headings, body copy.
  final Color textPrimary;

  /// Muted text color — secondary labels, metadata.
  final Color textMuted;

  /// Hint text color — placeholders, disabled labels.
  final Color textHint;

  /// Default border / divider color.
  final Color border;

  /// Stronger border for focused or emphasized elements.
  final Color borderStrong;

  /// Success semantic color — icons, indicators.
  final Color successColor;

  /// Success surface background.
  final Color successSurface;

  /// Success foreground text.
  final Color successText;

  /// Warning semantic color — icons, indicators.
  final Color warningColor;

  /// Warning surface background.
  final Color warningSurface;

  /// Warning foreground text.
  final Color warningText;

  /// Urgency surface background (high-priority items).
  final Color urgencySurface;

  /// Error / destructive semantic color.
  final Color errorColor;

  /// Error surface background.
  final Color errorSurface;

  /// Error foreground text.
  final Color errorText;

  /// Informational surface background.
  final Color infoSurface;

  /// Informational foreground text.
  final Color infoText;

  @override
  FormaThemeExtension copyWith({
    Color? appBackground,
    Color? cardBackground,
    Color? primaryColor,
    Color? primarySurface,
    Color? primaryBorder,
    Color? secondaryColor,
    Color? secondarySurface,
    Color? accentColor,
    Color? accentSurface,
    Color? textPrimary,
    Color? textMuted,
    Color? textHint,
    Color? border,
    Color? borderStrong,
    Color? successColor,
    Color? successSurface,
    Color? successText,
    Color? warningColor,
    Color? warningSurface,
    Color? warningText,
    Color? urgencySurface,
    Color? errorColor,
    Color? errorSurface,
    Color? errorText,
    Color? infoSurface,
    Color? infoText,
  }) {
    return FormaThemeExtension(
      appBackground: appBackground ?? this.appBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      primaryColor: primaryColor ?? this.primaryColor,
      primarySurface: primarySurface ?? this.primarySurface,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondarySurface: secondarySurface ?? this.secondarySurface,
      accentColor: accentColor ?? this.accentColor,
      accentSurface: accentSurface ?? this.accentSurface,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      textHint: textHint ?? this.textHint,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      successColor: successColor ?? this.successColor,
      successSurface: successSurface ?? this.successSurface,
      successText: successText ?? this.successText,
      warningColor: warningColor ?? this.warningColor,
      warningSurface: warningSurface ?? this.warningSurface,
      warningText: warningText ?? this.warningText,
      urgencySurface: urgencySurface ?? this.urgencySurface,
      errorColor: errorColor ?? this.errorColor,
      errorSurface: errorSurface ?? this.errorSurface,
      errorText: errorText ?? this.errorText,
      infoSurface: infoSurface ?? this.infoSurface,
      infoText: infoText ?? this.infoText,
    );
  }

  @override
  FormaThemeExtension lerp(FormaThemeExtension? other, double t) {
    if (other is! FormaThemeExtension) return this;
    return FormaThemeExtension(
      appBackground: Color.lerp(appBackground, other.appBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      primarySurface: Color.lerp(primarySurface, other.primarySurface, t)!,
      primaryBorder: Color.lerp(primaryBorder, other.primaryBorder, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      secondarySurface: Color.lerp(
        secondarySurface,
        other.secondarySurface,
        t,
      )!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      accentSurface: Color.lerp(accentSurface, other.accentSurface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      successSurface: Color.lerp(successSurface, other.successSurface, t)!,
      successText: Color.lerp(successText, other.successText, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      warningSurface: Color.lerp(warningSurface, other.warningSurface, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
      urgencySurface: Color.lerp(urgencySurface, other.urgencySurface, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      errorSurface: Color.lerp(errorSurface, other.errorSurface, t)!,
      errorText: Color.lerp(errorText, other.errorText, t)!,
      infoSurface: Color.lerp(infoSurface, other.infoSurface, t)!,
      infoText: Color.lerp(infoText, other.infoText, t)!,
    );
  }
}
