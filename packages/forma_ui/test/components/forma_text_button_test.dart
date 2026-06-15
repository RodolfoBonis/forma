import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaTextButton', () {
    testWidgets('renders the label', (tester) async {
      await tester.pumpWidget(
        wrapForTest(const FormaTextButton(label: 'Já tenho conta')),
      );

      expect(find.text('Já tenho conta'), findsOneWidget);
    });

    testWidgets('fires onPressed on tap', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrapForTest(FormaTextButton(label: 'Entrar', onPressed: () => taps++)),
      );

      await tester.tap(find.text('Entrar'));
      expect(taps, 1);
    });

    testWidgets('is disabled when onPressed is null', (tester) async {
      await tester.pumpWidget(
        wrapForTest(const FormaTextButton(label: 'Entrar')),
      );

      final button = tester.widget<TextButton>(find.byType(TextButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('primary variant paints the label with primaryColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(FormaTextButton.primary(label: 'Entrar', onPressed: () {})),
      );

      final text = tester.widget<Text>(find.text('Entrar'));
      expect(text.style?.color, testExtension.primaryColor);
    });

    testWidgets('danger variant paints the label with errorColor', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(FormaTextButton.danger(label: 'Apagar', onPressed: () {})),
      );

      final text = tester.widget<Text>(find.text('Apagar'));
      expect(text.style?.color, testExtension.errorColor);
    });

    testWidgets('neutral variant paints the label with textMuted', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(FormaTextButton.neutral(label: 'Pular', onPressed: () {})),
      );

      final text = tester.widget<Text>(find.text('Pular'));
      expect(text.style?.color, testExtension.textMuted);
    });
  });
}
