import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaEmptyState', () {
    testWidgets('renders title, message and icon', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaEmptyState(
            icon: Icons.inbox,
            title: 'Sem itens',
            message: 'Nada por aqui ainda.',
          ),
        ),
      );

      expect(find.text('Sem itens'), findsOneWidget);
      expect(find.text('Nada por aqui ainda.'), findsOneWidget);
      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('renders an action when provided', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaEmptyState(
            icon: Icons.inbox,
            title: 'Sem itens',
            action: FormaButton.primary(label: 'Criar', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Criar'), findsOneWidget);
    });

    testWidgets('omits the message when null', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaEmptyState(icon: Icons.inbox, title: 'Sem itens'),
        ),
      );

      expect(find.text('Sem itens'), findsOneWidget);
    });
  });
}
