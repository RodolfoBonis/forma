import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

const _options = <FormaSelectOption<String>>[
  FormaSelectOption(value: 'a', label: 'Opção A'),
  FormaSelectOption(value: 'b', label: 'Opção B'),
  FormaSelectOption(value: 'c', label: 'Opção C'),
];

void main() {
  group('FormaSelect', () {
    testWidgets('shows the hint when nothing is selected', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaSelect<String>(options: _options, onChanged: (_) {}),
        ),
      );

      expect(find.text('Selecione…'), findsOneWidget);
    });

    testWidgets('opens the overlay and selects an option', (tester) async {
      String? selected;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaSelect<String>(
            options: _options,
            onChanged: (v) => selected = v,
          ),
        ),
      );

      await tester.tap(find.text('Selecione…'));
      await tester.pumpAndSettle();
      expect(find.text('Opção B'), findsOneWidget);

      await tester.tap(find.text('Opção B'));
      await tester.pumpAndSettle();
      expect(selected, 'b');
    });

    testWidgets('shows the selected label', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaSelect<String>(options: _options, value: 'c', onChanged: (_) {}),
        ),
      );

      expect(find.text('Opção C'), findsOneWidget);
    });

    testWidgets('clear button resets the value', (tester) async {
      String? selected = 'a';
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaSelect<String>(
            options: _options,
            value: 'a',
            clearable: true,
            onChanged: (v) => selected = v,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      expect(selected, isNull);
    });

    testWidgets('filters options when searchable', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaSelect<String>(
            options: _options,
            searchable: true,
            onChanged: (_) {},
          ),
        ),
      );

      await tester.tap(find.text('Selecione…'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'B');
      await tester.pumpAndSettle();

      expect(find.text('Opção B'), findsOneWidget);
      expect(find.text('Opção A'), findsNothing);
    });
  });
}
