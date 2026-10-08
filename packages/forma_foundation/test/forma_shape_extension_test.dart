import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_foundation/forma_foundation.dart';

const _extension = FormaThemeExtension(
  appBackground: Color(0xFFFFFFFF),
  cardBackground: Color(0xFFFFFFFF),
  primaryColor: Color(0xFFFF6B6B),
  primarySurface: Color(0xFFFFF5F5),
  primaryBorder: Color(0xFFFFC9C9),
  secondaryColor: Color(0xFF26C5C5),
  secondarySurface: Color(0xFFE6F7F7),
  accentColor: Color(0xFF26C5C5),
  accentSurface: Color(0xFFE6F7F7),
  textPrimary: Color(0xFF222222),
  textMuted: Color(0xFF7B7B7B),
  textHint: Color(0xFF9D9D9D),
  border: Color(0xFFE8E8E8),
  borderStrong: Color(0xFFD9D9D9),
  successColor: Color(0xFF00A699),
  successSurface: Color(0xFFD4EDDA),
  successText: Color(0xFF008489),
  warningColor: Color(0xFFF4A261),
  warningSurface: Color(0xFFFFF3CD),
  warningText: Color(0xFFE76F51),
  urgencySurface: Color(0xFFF8D7DA),
  errorColor: Color(0xFFD93025),
  errorSurface: Color(0xFFF8D7DA),
  errorText: Color(0xFFB71C1C),
  infoSurface: Color(0xFFD1ECF1),
  infoText: Color(0xFF01579B),
);

void main() {
  group('FormaShapeExtension', () {
    test('mobile preset keeps the pre-existing Forma values', () {
      const shape = FormaShapeExtension.mobile;
      expect(shape.buttonRadius, FormaRadius.button);
      expect(shape.inputRadius, FormaRadius.input);
      expect(shape.buttonHeight, 56);
      expect(shape.inputHeight, 56);
      expect(shape.expandButtons, isTrue);
    });

    test('desktop preset is compact', () {
      const shape = FormaShapeExtension.desktop;
      expect(
        shape.buttonHeight,
        lessThan(FormaShapeExtension.mobile.buttonHeight),
      );
      expect(shape.expandButtons, isFalse);
      expect(shape.visualDensity, VisualDensity.compact);
    });

    test('lerp interpolates numeric slots', () {
      final mid = FormaShapeExtension.mobile.lerp(
        FormaShapeExtension.desktop,
        0.5,
      );
      expect(mid.buttonHeight, (56 + 38) / 2);
    });

    test('copyWith overrides only the given slot', () {
      final shape = FormaShapeExtension.desktop.copyWith(buttonRadius: 2);
      expect(shape.buttonRadius, 2);
      expect(shape.inputRadius, FormaShapeExtension.desktop.inputRadius);
    });

    test('FormaTheme.build registers the shape and density', () {
      final theme = FormaTheme.build(
        extension: _extension,
        fontFamily: 'Inter',
        seedColor: const Color(0xFFFF6B6B),
        shape: FormaShapeExtension.desktop,
      );
      expect(
        theme.extension<FormaShapeExtension>(),
        FormaShapeExtension.desktop,
      );
      expect(theme.visualDensity, VisualDensity.compact);
    });

    testWidgets('context.formaShape falls back to mobile', (tester) async {
      late FormaShapeExtension resolved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = context.formaShape;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(resolved, FormaShapeExtension.mobile);
    });
  });
}
