import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

void main() {
  group('DominusTheme.dark', () {
    final theme = DominusTheme.dark;

    test('is a dark Material 3 theme', () {
      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, isTrue);
    });

    test('registers a FormaThemeExtension with Dominus colors', () {
      final ext = theme.extension<FormaThemeExtension>();
      expect(ext, isNotNull);
      expect(ext!.primaryColor, DominusColors.brandPrimary);
      expect(ext.appBackground, DominusColors.bgCanvas);
      expect(ext.cardBackground, DominusColors.bgSurface);
    });

    test('populates the extended brand-state slots', () {
      final ext = theme.extension<FormaThemeExtension>()!;
      expect(ext.primaryHover, DominusColors.brandPrimaryHover);
      expect(ext.primaryPress, DominusColors.brandPrimaryPress);
      expect(ext.onPrimary, DominusColors.textOnPrimary);
      expect(ext.surfaceElevated, DominusColors.bgSurfaceElevated);
    });

    test('uses the brand color as the scaffold seed/background', () {
      expect(theme.scaffoldBackgroundColor, DominusColors.bgCanvas);
    });
  });
}
