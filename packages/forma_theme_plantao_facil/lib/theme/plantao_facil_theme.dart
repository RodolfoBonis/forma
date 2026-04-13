import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';

import '../tokens/pf_colors.dart';

/// Plantao Facil light theme built on the Forma Design System.
///
/// Uses [FormaTheme.build] to produce a [ThemeData] seeded with
/// Verde Floresta primary, Indigo secondary, and Terracota accent.
class PlantaoFacilTheme {
  /// Light theme for Plantao Facil.
  static ThemeData get light => FormaTheme.build(
        extension: const FormaThemeExtension(
          appBackground: PfColors.neutral50,
          cardBackground: PfColors.white,
          primaryColor: PfColors.primary700,
          primarySurface: PfColors.primary50,
          primaryBorder: PfColors.primary200,
          secondaryColor: PfColors.secondary500,
          secondarySurface: PfColors.secondary50,
          accentColor: PfColors.accent500,
          accentSurface: PfColors.accent50,
          textPrimary: PfColors.neutral900,
          textMuted: PfColors.neutral600,
          textHint: PfColors.neutral400,
          border: PfColors.neutral200,
          borderStrong: PfColors.neutral400,
          successColor: PfColors.success,
          successSurface: PfColors.successSurface,
          successText: PfColors.successText,
          warningColor: PfColors.warning,
          warningSurface: PfColors.warningSurface,
          warningText: PfColors.warningText,
          urgencySurface: PfColors.urgencySurface,
          errorColor: PfColors.error,
          errorSurface: PfColors.errorSurface,
          errorText: PfColors.errorText,
          infoSurface: PfColors.infoSurface,
          infoText: PfColors.infoText,
        ),
        fontFamily: 'Inter',
        seedColor: PfColors.primary700,
      );
}
