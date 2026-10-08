import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaNumberField', () {
    testWidgets('displays the formatted value', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaNumberField(value: 12.5, decimals: 2, onChanged: (_) {}),
        ),
      );

      expect(find.text('12,50'), findsOneWidget);
    });

    testWidgets('parses pt-BR comma input on change', (tester) async {
      num? latest;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaNumberField(decimals: 2, onChanged: (v) => latest = v),
        ),
      );

      await tester.enterText(find.byType(TextField), '3,14');
      expect(latest, 3.14);
    });

    testWidgets('clamps to max on blur', (tester) async {
      num? latest;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaNumberField(max: 10, onChanged: (v) => latest = v),
        ),
      );

      await tester.enterText(find.byType(TextField), '50');
      // Move focus away to trigger blur clamping.
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      expect(latest, 10);
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('renders prefix and suffix text', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaNumberField(
            value: 5,
            prefixText: r'R$',
            suffixText: '%',
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text(r'R$'), findsOneWidget);
      expect(find.text('%'), findsOneWidget);
    });

    testWidgets('shows stepper chevrons when step is set', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaNumberField(value: 1, step: 1, onChanged: (_) {}),
        ),
      );

      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });
  });
}
