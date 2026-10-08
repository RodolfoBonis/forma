import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaSideSheet', () {
    testWidgets('shows the scaffold title, body and footer', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          Builder(
            builder: (context) => FormaButton.primary(
              label: 'Abrir',
              onPressed: () => FormaSideSheet.show<void>(
                context,
                builder: (_) => const FormaSideSheetScaffold(
                  title: 'Detalhes',
                  subtitle: 'Edição',
                  body: Text('Conteúdo'),
                  footer: Text('Rodapé'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();

      expect(find.text('Detalhes'), findsOneWidget);
      expect(find.text('Edição'), findsOneWidget);
      expect(find.text('Conteúdo'), findsOneWidget);
      expect(find.text('Rodapé'), findsOneWidget);
    });

    testWidgets('closes when the close button is tapped', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          Builder(
            builder: (context) => FormaButton.primary(
              label: 'Abrir',
              onPressed: () => FormaSideSheet.show<void>(
                context,
                builder: (_) => const FormaSideSheetScaffold(
                  title: 'Detalhes',
                  body: Text('Conteúdo'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Conteúdo'), findsNothing);
    });
  });
}
