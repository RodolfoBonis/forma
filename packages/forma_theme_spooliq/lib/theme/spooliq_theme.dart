import 'package:flutter/material.dart';
import 'package:forma_foundation/forma_foundation.dart';

import '../tokens/spooliq_colors.dart';

/// SpoolIQ themes built on the Forma Design System.
///
/// Desktop-first: both variants use [FormaShapeExtension.desktop] (compact
/// controls, 8px radii). Apply with
/// `MaterialApp(theme: SpooliqTheme.light, darkTheme: SpooliqTheme.dark)`.
abstract final class SpooliqTheme {
  /// Semantic colors for the light variant.
  static const FormaThemeExtension lightColors = FormaThemeExtension(
    appBackground: SpooliqColors.neutral50,
    cardBackground: SpooliqColors.neutral0,
    primaryColor: SpooliqColors.primary500,
    primarySurface: SpooliqColors.primary50,
    primaryBorder: SpooliqColors.primary200,
    secondaryColor: SpooliqColors.accent500,
    secondarySurface: SpooliqColors.accent50,
    accentColor: SpooliqColors.accent500,
    accentSurface: SpooliqColors.accent50,
    textPrimary: SpooliqColors.neutral900,
    textMuted: SpooliqColors.neutral500,
    textHint: SpooliqColors.neutral400,
    border: SpooliqColors.neutral150,
    borderStrong: SpooliqColors.neutral200,
    successColor: SpooliqColors.success,
    successSurface: SpooliqColors.successLight,
    successText: SpooliqColors.successDark,
    warningColor: SpooliqColors.warning,
    warningSurface: SpooliqColors.warningLight,
    warningText: SpooliqColors.warningDark,
    urgencySurface: SpooliqColors.errorLight,
    errorColor: SpooliqColors.error,
    errorSurface: SpooliqColors.errorLight,
    errorText: SpooliqColors.errorDark,
    infoSurface: SpooliqColors.infoLight,
    infoText: SpooliqColors.infoDark,
    primaryHover: SpooliqColors.primary600,
    primaryPress: SpooliqColors.primary700,
    primarySubtle: SpooliqColors.primary100,
    onPrimary: SpooliqColors.neutral0,
    surfaceElevated: SpooliqColors.neutral0,
  );

  /// Semantic colors for the dark variant.
  static const FormaThemeExtension darkColors = FormaThemeExtension(
    appBackground: SpooliqColors.neutral1000,
    cardBackground: SpooliqColors.neutral950,
    primaryColor: SpooliqColors.primary500,
    primarySurface: Color(0xFF2B1A1A),
    primaryBorder: Color(0xFF5A2E2E),
    secondaryColor: SpooliqColors.accent500,
    secondarySurface: Color(0xFF122A2A),
    accentColor: SpooliqColors.accent500,
    accentSurface: Color(0xFF122A2A),
    textPrimary: Color(0xFFF2F2F2),
    textMuted: Color(0xFFA1A1A1),
    textHint: Color(0xFF6E6E6E),
    border: SpooliqColors.neutral800,
    borderStrong: Color(0xFF3A3A3A),
    successColor: Color(0xFF1FBFB0),
    successSurface: Color(0xFF0F2725),
    successText: Color(0xFF6FDCCF),
    warningColor: SpooliqColors.warning,
    warningSurface: Color(0xFF2E2213),
    warningText: Color(0xFFF6C08F),
    urgencySurface: Color(0xFF2E1517),
    errorColor: Color(0xFFEF5350),
    errorSurface: Color(0xFF2E1517),
    errorText: Color(0xFFF4A3A1),
    infoSurface: Color(0xFF10233A),
    infoText: Color(0xFF8CC8F2),
    primaryHover: SpooliqColors.primary400,
    primaryPress: SpooliqColors.primary600,
    primarySubtle: Color(0xFF3A2020),
    onPrimary: SpooliqColors.neutral0,
    surfaceElevated: SpooliqColors.neutral850,
  );

  /// SpoolIQ light theme.
  static ThemeData get light => _build(lightColors, Brightness.light);

  /// SpoolIQ dark theme.
  static ThemeData get dark => _build(darkColors, Brightness.dark);

  static ThemeData _build(FormaThemeExtension c, Brightness brightness) {
    const shape = FormaShapeExtension.desktop;
    final base = FormaTheme.build(
      extension: c,
      fontFamily: 'Inter',
      seedColor: SpooliqColors.primary500,
      brightness: brightness,
      shape: shape,
    );
    final scheme = base.colorScheme.copyWith(
      primary: c.primaryColor,
      onPrimary: c.onPrimary,
      secondary: c.accentColor,
      error: c.errorColor,
      surface: c.cardBackground,
      onSurface: c.textPrimary,
      outline: c.borderStrong,
      outlineVariant: c.border,
      surfaceContainerLowest: c.cardBackground,
      surfaceContainerLow: c.cardBackground,
      surfaceContainer: c.surfaceElevated,
      surfaceContainerHigh: c.surfaceElevated,
      surfaceContainerHighest: c.appBackground,
    );
    final radius = BorderRadius.circular(shape.dialogRadius);

    return base.copyWith(
      colorScheme: scheme,
      canvasColor: c.appBackground,
      dividerColor: c.border,
      splashFactory: NoSplash.splashFactory,
      hoverColor: c.textPrimary.withValues(alpha: 0.04),
      focusColor: c.primaryColor.withValues(alpha: 0.12),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.primaryColor,
        selectionColor: c.primaryColor.withValues(alpha: 0.25),
        selectionHandleColor: c.primaryColor,
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      scrollbarTheme: ScrollbarThemeData(
        thickness: const WidgetStatePropertyAll<double>(8),
        radius: const Radius.circular(8),
        thumbColor: WidgetStatePropertyAll<Color>(
          c.textMuted.withValues(alpha: 0.35),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        textStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: brightness == Brightness.light
              ? SpooliqColors.neutral0
              : SpooliqColors.neutral900,
        ),
        decoration: BoxDecoration(
          color: brightness == Brightness.light
              ? SpooliqColors.neutral900
              : SpooliqColors.neutral100,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.cardBackground,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: radius),
        elevation: 12,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.surfaceElevated,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: c.border),
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color?>(c.surfaceElevated),
          surfaceTintColor: const WidgetStatePropertyAll<Color>(
            Colors.transparent,
          ),
          shape: WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: c.border),
            ),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: c.borderStrong, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? c.primaryColor
              : Colors.transparent,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.primaryColor,
        linearTrackColor: c.primarySurface,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.surfaceElevated,
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
    );
  }
}
