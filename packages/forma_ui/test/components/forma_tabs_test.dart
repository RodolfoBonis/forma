import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaTabs', () {
    testWidgets('renders tab labels and counts', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaTabs(
            index: 0,
            onChanged: (_) {},
            tabs: const [
              FormaTab(label: 'Abertos', count: 3),
              FormaTab(label: 'Fechados'),
            ],
          ),
        ),
      );

      expect(find.text('Abertos'), findsOneWidget);
      expect(find.text('Fechados'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('fires onChanged with the tapped index', (tester) async {
      var selected = 0;
      await tester.pumpWidget(
        wrapForTest(
          FormaTabs(
            index: 0,
            onChanged: (i) => selected = i,
            tabs: const [
              FormaTab(label: 'Abertos'),
              FormaTab(label: 'Fechados'),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Fechados'));
      expect(selected, 1);
    });

    testWidgets('paints the selected label with primaryColor', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaTabs(
            index: 1,
            onChanged: (_) {},
            tabs: const [
              FormaTab(label: 'Abertos'),
              FormaTab(label: 'Fechados'),
            ],
          ),
        ),
      );

      final selected = tester.widget<Text>(find.text('Fechados'));
      expect(selected.style?.color, testExtension.primaryColor);
    });
  });
}
