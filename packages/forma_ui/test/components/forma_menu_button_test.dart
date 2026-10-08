import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaMenuButton', () {
    testWidgets('opens the menu and renders items', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaMenuButton(
            items: [
              FormaMenuItem(label: 'Editar', icon: Icons.edit, onTap: () {}),
              const FormaMenuItem.divider(),
              FormaMenuItem(
                label: 'Excluir',
                icon: Icons.delete,
                destructive: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();

      expect(find.text('Editar'), findsOneWidget);
      expect(find.text('Excluir'), findsOneWidget);
    });

    testWidgets('fires onTap when an item is selected', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrapForTest(
          FormaMenuButton(
            items: [FormaMenuItem(label: 'Editar', onTap: () => taps++)],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Editar'));
      await tester.pumpAndSettle();

      expect(taps, 1);
    });

    testWidgets('divider reports isDivider', (tester) async {
      const divider = FormaMenuItem.divider();
      expect(divider.isDivider, isTrue);

      final item = FormaMenuItem(label: 'A', onTap: () {});
      expect(item.isDivider, isFalse);
    });
  });
}
