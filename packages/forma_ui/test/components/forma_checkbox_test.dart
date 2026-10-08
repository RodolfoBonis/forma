import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaCheckbox', () {
    testWidgets('renders the label and description', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCheckbox(
            value: false,
            onChanged: (_) {},
            label: 'Aceito os termos',
            description: 'Você concorda com a política.',
          ),
        ),
      );

      expect(find.text('Aceito os termos'), findsOneWidget);
      expect(find.text('Você concorda com a política.'), findsOneWidget);
    });

    testWidgets('toggles value on tap', (tester) async {
      bool? latest;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCheckbox(
            value: false,
            onChanged: (v) => latest = v,
            label: 'Marcar',
          ),
        ),
      );

      await tester.tap(find.text('Marcar'));
      expect(latest, isTrue);
    });

    testWidgets('reveals the check mark when checked', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(const FormaCheckbox(value: true, onChanged: null)),
      );
      await tester.pumpAndSettle();

      final opacity = tester.widget<AnimatedOpacity>(
        find.ancestor(
          of: find.byIcon(Icons.check),
          matching: find.byType(AnimatedOpacity),
        ),
      );
      expect(opacity.opacity, 1);
    });

    testWidgets('does not toggle when disabled', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaCheckbox(
            value: false,
            enabled: false,
            onChanged: (_) => taps++,
            label: 'X',
          ),
        ),
      );

      await tester.tap(find.text('X'));
      await tester.pump();
      expect(taps, 0);
    });
  });
}
