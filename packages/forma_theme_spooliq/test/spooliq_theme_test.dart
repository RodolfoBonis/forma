import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_foundation/forma_foundation.dart';
import 'package:forma_theme_spooliq/forma_theme_spooliq.dart';

void main() {
  group('SpooliqTheme', () {
    for (final (name, theme, brightness) in [
      ('light', SpooliqTheme.light, Brightness.light),
      ('dark', SpooliqTheme.dark, Brightness.dark),
    ]) {
      test('$name registers Forma extensions with desktop shape', () {
        expect(theme.brightness, brightness);
        expect(theme.extension<FormaThemeExtension>(), isNotNull);
        expect(theme.extension<FormaTypographyExtension>(), isNotNull);
        expect(
          theme.extension<FormaShapeExtension>(),
          FormaShapeExtension.desktop,
        );
      });

      test('$name uses the coral brand as primary', () {
        expect(
          theme.extension<FormaThemeExtension>()!.primaryColor,
          SpooliqColors.primary500,
        );
        expect(theme.colorScheme.primary, SpooliqColors.primary500);
      });
    }
  });
}
