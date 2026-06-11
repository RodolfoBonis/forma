import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

void main() {
  group('DominusTheme.dark', () {
    testWidgets('is a dark Material 3 theme', (tester) async {
      late ThemeData theme;
      await tester.pumpWidget(
        MaterialApp(
          theme: DominusTheme.dark,
          home: Builder(
            builder: (context) {
              theme = Theme.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(theme.brightness, Brightness.dark);
      expect(theme.useMaterial3, isTrue);
      expect(theme.scaffoldBackgroundColor, DominusColors.bgCanvas);
    });

    testWidgets('registers a FormaThemeExtension with Dominus colors', (
      tester,
    ) async {
      late FormaThemeExtension ext;
      await tester.pumpWidget(
        MaterialApp(
          theme: DominusTheme.dark,
          home: Builder(
            builder: (context) {
              ext = Theme.of(context).extension<FormaThemeExtension>()!;
              return const SizedBox();
            },
          ),
        ),
      );

      // Base slots.
      expect(ext.primaryColor, DominusColors.brandPrimary);
      expect(ext.appBackground, DominusColors.bgCanvas);
      expect(ext.cardBackground, DominusColors.bgSurface);
      // Extended brand-state slots.
      expect(ext.primaryHover, DominusColors.brandPrimaryHover);
      expect(ext.primaryPress, DominusColors.brandPrimaryPress);
      expect(ext.onPrimary, DominusColors.textOnPrimary);
      expect(ext.surfaceElevated, DominusColors.bgSurfaceElevated);
    });
  });
}
