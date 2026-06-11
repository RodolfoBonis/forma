import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';

import '../test_theme.dart';

void main() {
  group('FormaRoleBadge', () {
    testWidgets('renders its label', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaRoleBadge(label: 'Dom', color: Color(0xFFC9A66B)),
        ),
      );
      expect(find.text('Dom'), findsOneWidget);
    });
  });

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

  group('FormaOrderCard', () {
    testWidgets('renders title, description, status, and action', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaOrderCard(
            status: const FormaBadge(
              label: 'Pendente',
              variant: FormaBadgeVariant.pendente,
            ),
            timeLabel: 'Hoje · 21:00',
            title: 'Beba 2L de água',
            description: 'Registre com foto.',
            action: FormaButton.primary(
              label: 'Marcar feita',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Beba 2L de água'), findsOneWidget);
      expect(find.text('Registre com foto.'), findsOneWidget);
      expect(find.text('Pendente'), findsOneWidget);
      expect(find.text('Hoje · 21:00'), findsOneWidget);
      expect(find.text('Marcar feita'), findsOneWidget);
    });
  });
}
