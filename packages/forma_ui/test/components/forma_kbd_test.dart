import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaKbd', () {
    testWidgets('renders the key text', (tester) async {
      await tester.pumpWidget(wrapForTest(const FormaKbd('⌘K')));

      expect(find.text('⌘K'), findsOneWidget);
    });

    testWidgets('paints a bordered keycap', (tester) async {
      await tester.pumpWidget(wrapForTest(const FormaKbd('Esc')));

      final container = tester.widget<Container>(
        find.ancestor(of: find.text('Esc'), matching: find.byType(Container)),
      );
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.border, isA<Border>());
      expect(decoration.color, testExtension.appBackground);
    });
  });
}
