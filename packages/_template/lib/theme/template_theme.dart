import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';

import '../tokens/template_colors.dart';

/// Template light theme built on the Forma Design System.
///
/// Replace [TemplateColors] values with your brand palette.
class TemplateTheme {
  /// Light theme using placeholder Material colors.
  static ThemeData get light => FormaTheme.build(
    extension: const FormaThemeExtension(
      appBackground: TemplateColors.neutral50,
      cardBackground: TemplateColors.white,
      primaryColor: TemplateColors.primary700,
      primarySurface: TemplateColors.primary50,
      primaryBorder: TemplateColors.primary200,
      secondaryColor: TemplateColors.secondary500,
      secondarySurface: TemplateColors.secondary50,
      accentColor: TemplateColors.accent500,
      accentSurface: TemplateColors.accent50,
      textPrimary: TemplateColors.neutral900,
      textMuted: TemplateColors.neutral600,
      textHint: TemplateColors.neutral400,
      border: TemplateColors.neutral200,
      borderStrong: TemplateColors.neutral400,
      successColor: TemplateColors.success,
      successSurface: TemplateColors.successSurface,
      successText: TemplateColors.successText,
      warningColor: TemplateColors.warning,
      warningSurface: TemplateColors.warningSurface,
      warningText: TemplateColors.warningText,
      urgencySurface: TemplateColors.urgencySurface,
      errorColor: TemplateColors.error,
      errorSurface: TemplateColors.errorSurface,
      errorText: TemplateColors.errorText,
      infoSurface: TemplateColors.infoSurface,
      infoText: TemplateColors.infoText,
    ),
    fontFamily: 'Inter',
    seedColor: TemplateColors.primary700,
  );
}
