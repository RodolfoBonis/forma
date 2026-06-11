import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';

import '../tokens/dominus_colors.dart';

/// Dominus dark theme built on the Forma Design System.
///
/// Wine-red brand with brass accent. Dominus is dark-only — there is no
/// light variant. Apply with `MaterialApp(theme: DominusTheme.dark)` (or
/// `darkTheme:` + `themeMode: ThemeMode.dark`).
class DominusTheme {
  /// Dominus dark theme.
  static ThemeData get dark => FormaTheme.build(
    brightness: Brightness.dark,
    extension: const FormaThemeExtension(
      appBackground: DominusColors.bgCanvas,
      cardBackground: DominusColors.bgSurface,
      primaryColor: DominusColors.brandPrimary,
      primarySurface: DominusColors.brandPrimarySubtle,
      primaryBorder: DominusColors.brandPrimaryBorder,
      secondaryColor: DominusColors.roleSub,
      secondarySurface: DominusColors.roleSubSubtle,
      accentColor: DominusColors.brass,
      accentSurface: DominusColors.brassSubtle,
      textPrimary: DominusColors.textPrimary,
      textMuted: DominusColors.textSecondary,
      textHint: DominusColors.textMuted,
      border: DominusColors.borderSubtle,
      borderStrong: DominusColors.borderDefault,
      successColor: DominusColors.success,
      successSurface: DominusColors.successSurface,
      successText: DominusColors.successText,
      warningColor: DominusColors.warning,
      warningSurface: DominusColors.warningSurface,
      warningText: DominusColors.warningText,
      urgencySurface: DominusColors.safewordSurface,
      errorColor: DominusColors.danger,
      errorSurface: DominusColors.dangerSurface,
      errorText: DominusColors.dangerText,
      infoSurface: DominusColors.infoSurface,
      infoText: DominusColors.infoText,
      // Extended slots — Dominus brand-state tokens.
      primaryHover: DominusColors.brandPrimaryHover,
      primaryPress: DominusColors.brandPrimaryPress,
      primarySubtle: DominusColors.brandPrimarySubtle,
      onPrimary: DominusColors.textOnPrimary,
      surfaceElevated: DominusColors.bgSurfaceElevated,
    ),
    fontFamily: 'Inter',
    seedColor: DominusColors.brandPrimary,
  );
}
