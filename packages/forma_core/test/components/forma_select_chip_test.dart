import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';

import '../test_theme.dart';

void main() {
  group('FormaSelectChip', () {
    testWidgets('toggles selection on tap', (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        wrapForTest(
          FormaSelectChip(
            label: 'Foto',
            selected: false,
            icon: Icons.photo_camera,
            onSelected: (v) => newValue = v,
          ),
        ),
      );

      expect(find.text('Foto'), findsOneWidget);
      await tester.tap(find.text('Foto'));
      expect(newValue, isTrue);
    });

    testWidgets('reports false when a selected chip is tapped', (tester) async {
      bool? newValue;
      await tester.pumpWidget(
        wrapForTest(
          FormaSelectChip(
            label: 'Selecionada',
            selected: true,
            onSelected: (v) => newValue = v,
          ),
        ),
      );

      await tester.tap(find.text('Selecionada'));
      expect(newValue, isFalse);
    });
  });
}
