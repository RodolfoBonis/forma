import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

Widget _launcher(void Function(BuildContext) onPressed) {
  return wrapForTest(
    Builder(
      builder: (context) => FormaButton.primary(
        label: 'Abrir',
        onPressed: () => onPressed(context),
      ),
    ),
  );
}

void main() {
  group('FormaDialog', () {
    testWidgets('shows title, description and body', (tester) async {
      await tester.pumpWidget(
        _launcher(
          (context) => FormaDialog.show<void>(
            context,
            title: 'Título',
            description: 'Subtítulo',
            child: const Text('Corpo'),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();

      expect(find.text('Título'), findsOneWidget);
      expect(find.text('Subtítulo'), findsOneWidget);
      expect(find.text('Corpo'), findsOneWidget);
    });

    testWidgets('closes when the close button is tapped', (tester) async {
      await tester.pumpWidget(
        _launcher(
          (context) => FormaDialog.show<void>(
            context,
            title: 'Título',
            child: const Text('Corpo'),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Corpo'), findsNothing);
    });
  });

  group('FormaConfirmDialog', () {
    testWidgets('returns true when confirmed', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _launcher((context) async {
          result = await FormaConfirmDialog.show(
            context,
            title: 'Excluir?',
            message: 'Esta ação não pode ser desfeita.',
            confirmLabel: 'Excluir',
            destructive: true,
          );
        }),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Excluir'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('returns false when cancelled', (tester) async {
      bool? result;
      await tester.pumpWidget(
        _launcher((context) async {
          result = await FormaConfirmDialog.show(
            context,
            title: 'Excluir?',
            message: 'Esta ação não pode ser desfeita.',
          );
        }),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });
  });
}
