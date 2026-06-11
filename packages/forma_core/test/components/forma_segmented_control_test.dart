import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';

import '../test_theme.dart';

void main() {
  group('FormaSegmentedControl', () {
    testWidgets('renders all segment labels', (tester) async {
      await tester.pumpWidget(
        wrapForTest(
          FormaSegmentedControl(
            selectedIndex: 0,
            onChanged: (_) {},
            segments: const [
              FormaSegment(label: 'Foto', icon: Icons.photo_camera),
              FormaSegment(label: 'Texto'),
              FormaSegment(label: 'Check'),
            ],
          ),
        ),
      );

      expect(find.text('Foto'), findsOneWidget);
      expect(find.text('Texto'), findsOneWidget);
      expect(find.text('Check'), findsOneWidget);
      expect(find.byIcon(Icons.photo_camera), findsOneWidget);
    });

    testWidgets('reports the tapped segment index', (tester) async {
      int? tapped;
      await tester.pumpWidget(
        wrapForTest(
          FormaSegmentedControl(
            selectedIndex: 0,
            onChanged: (i) => tapped = i,
            segments: const [
              FormaSegment(label: 'A'),
              FormaSegment(label: 'B'),
            ],
          ),
        ),
      );

      await tester.tap(find.text('B'));
      expect(tapped, 1);
    });
  });
}
