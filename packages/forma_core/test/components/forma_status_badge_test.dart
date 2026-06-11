import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';

import '../test_theme.dart';

void main() {
  group('FormaStatusBadge', () {
    testWidgets('renders the default label for each variant', (tester) async {
      for (final variant in FormaStatusVariant.values) {
        await tester.pumpWidget(
          wrapForTest(FormaStatusBadge(variant: variant)),
        );
        expect(find.text(variant.label), findsOneWidget);
      }
    });

    testWidgets('honors a label override', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaStatusBadge(
            variant: FormaStatusVariant.concluida,
            label: 'Feita',
          ),
        ),
      );
      expect(find.text('Feita'), findsOneWidget);
      expect(find.text('Concluída'), findsNothing);
    });

    testWidgets('tints success status with the theme success color', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaStatusBadge(variant: FormaStatusVariant.concluida),
        ),
      );
      final label = tester.widget<Text>(find.text('Concluída'));
      expect(label.style?.color, testExtension.successColor);
    });
  });
}
