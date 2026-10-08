import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';
import 'desktop_test_helpers.dart';

void main() {
  group('FormaIconButton respects FormaShapeExtension', () {
    testWidgets('keeps the 48px touch target on mobile', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaIconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ),
      );

      final button = tester.widget<IconButton>(find.byType(IconButton));
      expect(button.constraints?.minWidth, 48);
      expect(button.constraints?.minHeight, 48);
    });

    testWidgets('tightens the touch target on desktop', (tester) async {
      await tester.pumpWidget(
        wrapForDesktopTest(
          FormaIconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ),
      );

      final button = tester.widget<IconButton>(find.byType(IconButton));
      expect(button.constraints?.minWidth, 32);
      expect(button.constraints?.minHeight, 32);
    });
  });

  group('FormaCard basic respects FormaShapeExtension', () {
    BorderRadius radiusOf(WidgetTester tester) {
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(FormaCard),
          matching: find.byType(Container),
        ),
      );
      final decoration = container.decoration! as BoxDecoration;
      return decoration.borderRadius! as BorderRadius;
    }

    testWidgets('keeps the historical 20px radius on mobile', (tester) async {
      await tester.pumpWidget(wrapForTest(const FormaCard(child: Text('Olá'))));

      expect(radiusOf(tester).topLeft.x, 20);
    });

    testWidgets('tightens the radius on desktop', (tester) async {
      await tester.pumpWidget(
        wrapForDesktopTest(const FormaCard(child: Text('Olá'))),
      );

      expect(radiusOf(tester).topLeft.x, 12);
    });
  });
}
