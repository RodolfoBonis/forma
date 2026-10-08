import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaToast', () {
    testWidgets('shows a toast with message and description', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          Builder(
            builder: (context) => FormaButton.primary(
              label: 'Mostrar',
              onPressed: () => FormaToast.show(
                context,
                message: 'Salvo',
                description: 'Alterações aplicadas',
                variant: FormaToastVariant.success,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Mostrar'));
      await tester.pump(); // post-frame insert
      await tester.pumpAndSettle(); // slide-in completes

      expect(find.text('Salvo'), findsOneWidget);
      expect(find.text('Alterações aplicadas'), findsOneWidget);

      // Dismiss manually so no auto-dismiss timer leaks.
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text('Salvo'), findsNothing);
    });

    testWidgets('auto-dismisses after its duration', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          Builder(
            builder: (context) => FormaButton.primary(
              label: 'Mostrar',
              onPressed: () => FormaToast.show(
                context,
                message: 'Efêmero',
                duration: const Duration(milliseconds: 500),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Mostrar'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      expect(find.text('Efêmero'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 500)); // duration elapses
      await tester.pumpAndSettle(); // reverse animation + removal
      expect(find.text('Efêmero'), findsNothing);
    });

    testWidgets('invokes the action callback', (tester) async {
      var actions = 0;
      await tester.pumpWidget(
        wrapForTest(
          Builder(
            builder: (context) => FormaButton.primary(
              label: 'Mostrar',
              onPressed: () => FormaToast.show(
                context,
                message: 'Desfazer?',
                actionLabel: 'Desfazer',
                onAction: () => actions++,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Mostrar'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));

      await tester.tap(find.text('Desfazer'));
      await tester.pumpAndSettle();
      expect(actions, 1);
    });
  });
}
