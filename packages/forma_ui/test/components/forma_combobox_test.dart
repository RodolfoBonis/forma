import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

Future<List<FormaSelectOption<String>>> _search(String query) async {
  const all = [
    FormaSelectOption(value: 'ana', label: 'Ana'),
    FormaSelectOption(value: 'beto', label: 'Beto'),
  ];
  if (query.isEmpty) return all;
  return all
      .where((o) => o.label.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

void main() {
  group('FormaCombobox', () {
    testWidgets('shows the hint when nothing is selected', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCombobox<String>(search: _search, onChanged: (_) {}),
        ),
      );

      expect(find.text('Buscar…'), findsOneWidget);
    });

    testWidgets('seeds results on open and selects one', (tester) async {
      FormaSelectOption<String>? selected;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCombobox<String>(
            search: _search,
            onChanged: (v) => selected = v,
          ),
        ),
      );

      await tester.tap(find.text('Buscar…'));
      await tester.pumpAndSettle();

      expect(find.text('Ana'), findsOneWidget);
      expect(find.text('Beto'), findsOneWidget);

      await tester.tap(find.text('Beto'));
      await tester.pumpAndSettle();
      expect(selected?.value, 'beto');
    });

    testWidgets('shows "Erro ao buscar" when search throws', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCombobox<String>(
            search: (_) => Future.error(Exception('boom')),
            onChanged: (_) {},
          ),
        ),
      );

      await tester.tap(find.text('Buscar…'));
      await tester.pumpAndSettle();

      expect(find.text('Erro ao buscar'), findsOneWidget);
    });

    testWidgets('shows the selected value label', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCombobox<String>(
            search: _search,
            value: const FormaSelectOption(value: 'ana', label: 'Ana'),
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Ana'), findsOneWidget);
    });
  });
}
