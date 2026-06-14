import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_foundation/forma_foundation.dart';

const _extension = FormaThemeExtension(
  appBackground: Color(0xFF0E0B0F),
  cardBackground: Color(0xFF17131A),
  primaryColor: Color(0xFF9B2242),
  primarySurface: Color(0xFF2A121A),
  primaryBorder: Color(0xFF5A2334),
  secondaryColor: Color(0xFFC77A93),
  secondarySurface: Color(0xFF2A171D),
  accentColor: Color(0xFFC9A66B),
  accentSurface: Color(0xFF2A2417),
  textPrimary: Color(0xFFF5F1F4),
  textMuted: Color(0xFFB6ABB8),
  textHint: Color(0xFF7C7280),
  border: Color(0xFF2A2430),
  borderStrong: Color(0xFF3A3340),
  successColor: Color(0xFF4E9A6B),
  successSurface: Color(0xFF15271C),
  successText: Color(0xFF8FD9AB),
  warningColor: Color(0xFFD89A3F),
  warningSurface: Color(0xFF2A2113),
  warningText: Color(0xFFEEC07A),
  urgencySurface: Color(0xFF2E1413),
  errorColor: Color(0xFFE5484D),
  errorSurface: Color(0xFF2E1517),
  errorText: Color(0xFFF2999B),
  infoSurface: Color(0xFF15203A),
  infoText: Color(0xFFA8C2F7),
);

void main() {
  group('FormaTheme.build', () {
    test('registers the color and typography extensions', () {
      final theme = FormaTheme.build(
        extension: _extension,
        fontFamily: 'Inter',
        seedColor: const Color(0xFF9B2242),
      );

      expect(theme.extension<FormaThemeExtension>(), isNotNull);
      expect(theme.extension<FormaTypographyExtension>(), isNotNull);
      expect(theme.scaffoldBackgroundColor, _extension.appBackground);
    });

    test('uses the brand font family for the typography scale', () {
      final theme = FormaTheme.build(
        extension: _extension,
        fontFamily: 'Roboto',
        seedColor: const Color(0xFF9B2242),
      );

      final typography = theme.extension<FormaTypographyExtension>()!;
      // Sizes stay constant; only the family changes per brand.
      expect(typography.body16.fontSize, 16);
      expect(typography.h1.fontWeight, FontWeight.w700);
    });
  });

  group('FormaTypographyExtension', () {
    test('lerp interpolates between two scales', () {
      final a = FormaTypographyExtension.fromFont('Inter');
      final b = FormaTypographyExtension.fromFont('Roboto');

      expect(a.lerp(b, 0).body16.fontSize, 16);
      expect(a.lerp(null, 0.5), same(a));
    });
  });
}
