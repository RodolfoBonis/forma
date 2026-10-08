import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaDateField', () {
    testWidgets('shows the hint when no value', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(FormaDateField(onChanged: (_) {})),
      );

      expect(find.text('dd/mm/aaaa'), findsOneWidget);
    });

    testWidgets('formats the value as dd/MM/yyyy', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDateField(value: DateTime(2026, 3, 7), onChanged: (_) {}),
        ),
      );

      expect(find.text('07/03/2026'), findsOneWidget);
    });

    testWidgets('clear button resets the value', (tester) async {
      DateTime? value = DateTime(2026, 3, 7);
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDateField(value: value, onChanged: (v) => value = v),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      expect(value, isNull);
    });

    testWidgets('renders the error text', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDateField(onChanged: (_) {}, errorText: 'Data inválida'),
        ),
      );

      expect(find.text('Data inválida'), findsOneWidget);
    });

    testWidgets('formatDate pads single digits', (tester) async {
      expect(FormaDateField.formatDate(DateTime(2026, 1, 5)), '05/01/2026');
    });
  });
}
