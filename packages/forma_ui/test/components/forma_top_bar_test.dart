import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaTopBar', () {
    testWidgets('renders the title and actions', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaTopBar(title: 'Projetos', actions: [Icon(Icons.settings)]),
        ),
      );

      expect(find.text('Projetos'), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('renders a custom center over the title', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaTopBar(title: 'Ignorado', center: Text('Busca')),
        ),
      );

      expect(find.text('Busca'), findsOneWidget);
      expect(find.text('Ignorado'), findsNothing);
    });

    testWidgets('exposes its height as the preferred size', (tester) async {
      const bar = FormaTopBar(height: 72);
      expect(bar.preferredSize.height, 72);
    });
  });
}
