import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

Widget _launcher(
  List<FormaCommandItem> items, {
  Future<List<FormaCommandItem>> Function(String)? onSearch,
}) {
  return wrapForTest(
    Builder(
      builder: (context) => FormaButton.primary(
        label: 'Abrir',
        onPressed: () =>
            FormaCommandPalette.show(context, items: items, onSearch: onSearch),
      ),
    ),
  );
}

void main() {
  group('FormaCommandPalette', () {
    testWidgets('shows items grouped by header', (tester) async {
      await tester.pumpWidget(
        _launcher([
          FormaCommandItem(
            id: 'new',
            label: 'Novo projeto',
            group: 'Ações',
            onSelected: () {},
          ),
          FormaCommandItem(
            id: 'settings',
            label: 'Configurações',
            group: 'Navegação',
            onSelected: () {},
          ),
        ]),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();

      expect(find.text('Novo projeto'), findsOneWidget);
      expect(find.text('AÇÕES'), findsOneWidget);
      expect(find.text('NAVEGAÇÃO'), findsOneWidget);
    });

    testWidgets('filters case/diacritics-insensitively', (tester) async {
      await tester.pumpWidget(
        _launcher([
          FormaCommandItem(id: 'a', label: 'Configurações', onSelected: () {}),
          FormaCommandItem(id: 'b', label: 'Relatórios', onSelected: () {}),
        ]),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'configuracoes');
      await tester.pumpAndSettle();

      expect(find.text('Configurações'), findsOneWidget);
      expect(find.text('Relatórios'), findsNothing);
    });

    testWidgets('shows the empty state when nothing matches', (tester) async {
      await tester.pumpWidget(
        _launcher([
          FormaCommandItem(id: 'a', label: 'Configurações', onSelected: () {}),
        ]),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'zzz');
      await tester.pumpAndSettle();

      expect(find.text('Nenhum resultado'), findsOneWidget);
    });

    testWidgets('selecting an item closes and fires onSelected', (
      tester,
    ) async {
      var selected = 0;
      await tester.pumpWidget(
        _launcher([
          FormaCommandItem(
            id: 'a',
            label: 'Configurações',
            onSelected: () => selected++,
          ),
        ]),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Configurações'));
      await tester.pumpAndSettle();

      expect(selected, 1);
      expect(find.text('Configurações'), findsNothing);
    });

    testWidgets('merges debounced async results', (tester) async {
      await tester.pumpWidget(
        _launcher(
          const [],
          onSearch: (query) async => [
            FormaCommandItem(
              id: 'remote',
              label: 'Resultado remoto',
              group: 'Servidor',
              onSelected: () {},
            ),
          ],
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'remoto');
      await tester.pump(const Duration(milliseconds: 300)); // debounce
      await tester.pumpAndSettle();

      expect(find.text('Resultado remoto'), findsOneWidget);
    });
  });
}
