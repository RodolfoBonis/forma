import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaStatTile', () {
    testWidgets('renders value, label, and icon', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaStatTile(
            value: '12',
            label: 'streak',
            icon: Icons.local_fire_department,
          ),
        ),
      );
      expect(find.text('12'), findsOneWidget);
      expect(find.text('streak'), findsOneWidget);
      expect(find.byIcon(Icons.local_fire_department), findsOneWidget);
    });
  });

  group('FormaSettingsRow', () {
    testWidgets('renders title/subtitle and fires onTap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        wrapForTest(
          FormaSettingsRow(
            icon: Icons.lock_outline,
            title: 'Segurança',
            subtitle: 'PIN e biometria',
            onTap: () => tapped = true,
          ),
        ),
      );
      expect(find.text('Segurança'), findsOneWidget);
      expect(find.text('PIN e biometria'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);

      await tester.tap(find.text('Segurança'));
      expect(tapped, isTrue);
    });
  });
}
