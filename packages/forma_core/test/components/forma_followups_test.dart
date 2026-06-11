import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_core/forma_core.dart';

import '../test_theme.dart';

void main() {
  group('FormaButton.safeword', () {
    testWidgets('renders a loud-red filled button', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        wrapForTest(
          FormaButton.safeword(
            label: 'Safeword',
            onPressed: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Safeword'), findsOneWidget);
      await tester.tap(find.byType(FormaButton));
      expect(tapped, isTrue);
    });
  });

  group('FormaAvatar role ring', () {
    testWidgets('wraps the avatar with an outer ring when ringColor is set', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(
          const FormaAvatar(
            initial: 'R',
            color: Color(0xFF7E1A36),
            ringColor: Color(0xFFC9A66B),
          ),
        ),
      );

      // Outer ring container + inner avatar container both present.
      expect(find.byType(Container), findsWidgets);
      expect(find.text('R'), findsOneWidget);
    });
  });

  group('FormaBottomNav activeColor', () {
    testWidgets('tints the active item with activeColor', (tester) async {
      const dom = Color(0xFFC9A66B);
      await tester.pumpWidget(
        wrapForTest(
          SizedBox(
            width: 400,
            child: FormaBottomNav(
              activeIndex: 1,
              activeColor: dom,
              onTap: (_) {},
              items: const [
                FormaNavItem(label: 'Início', icon: Icons.home_outlined),
                FormaNavItem(label: 'Ordens', icon: Icons.list_alt),
              ],
            ),
          ),
        ),
      );

      final activeLabel = tester.widget<Text>(find.text('Ordens'));
      expect(activeLabel.style?.color, dom);
    });
  });

  group('FormaProofIcon', () {
    testWidgets('renders the icon for its type', (tester) async {
      await tester.pumpWidget(
        wrapForTest(const FormaProofIcon(type: FormaProofType.check)),
      );
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('FormaChip', () {
    testWidgets('renders label and optional icon', (tester) async {
      await tester.pumpWidget(
        wrapForTest(const FormaChip(label: 'Alta', icon: Icons.flag_outlined)),
      );
      expect(find.text('Alta'), findsOneWidget);
      expect(find.byIcon(Icons.flag_outlined), findsOneWidget);
    });
  });
}
