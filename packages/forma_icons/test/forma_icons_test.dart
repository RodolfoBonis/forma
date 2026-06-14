import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_icons/forma_icons.dart';

void main() {
  group('FormaIconRegistry', () {
    test('resolves Material defaults for every key', () {
      const registry = FormaIconRegistry();
      for (final key in FormaIconKey.values) {
        expect(registry.resolve(key), isA<MaterialFormaIcon>());
      }
    });

    test('brand overrides take precedence over defaults', () {
      const registry = FormaIconRegistry.withOverrides({
        FormaIconKey.confirm: SvgFormaIcon('assets/check.svg'),
      });

      expect(registry.resolve(FormaIconKey.confirm), isA<SvgFormaIcon>());
      // Untouched keys still fall back to Material.
      expect(registry.resolve(FormaIconKey.home), isA<MaterialFormaIcon>());
    });
  });

  group('FormaIcon', () {
    testWidgets('renders a Material glyph for a default key', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FormaIcon(FormaIconKey.confirm)),
      );

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('honors a brand override from the scope', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: FormaIconScope(
            registry: FormaIconRegistry.withOverrides({
              FormaIconKey.confirm: MaterialFormaIcon(Icons.verified_rounded),
            }),
            child: FormaIcon(FormaIconKey.confirm),
          ),
        ),
      );

      expect(find.byIcon(Icons.verified_rounded), findsOneWidget);
      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });
  });
}
