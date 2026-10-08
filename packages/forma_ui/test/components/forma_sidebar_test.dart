import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  const sections = [
    FormaSidebarSection(
      title: 'Geral',
      items: [
        FormaSidebarItem(icon: Icons.home, label: 'Início', selected: true),
        FormaSidebarItem(
          icon: Icons.notifications,
          label: 'Alertas',
          badge: '5',
          badgeVariant: FormaSidebarBadgeVariant.primary,
        ),
      ],
    ),
  ];

  group('FormaSidebar', () {
    testWidgets('renders section title, items and badge when expanded', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(
          const SizedBox(height: 600, child: FormaSidebar(sections: sections)),
        ),
      );

      expect(find.text('GERAL'), findsOneWidget);
      expect(find.text('Início'), findsOneWidget);
      expect(find.text('Alertas'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('hides labels and section titles when collapsed', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTest(
          const SizedBox(
            height: 600,
            child: FormaSidebar(sections: sections, collapsed: true),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Início'), findsNothing);
      expect(find.text('GERAL'), findsNothing);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('fires onTap when an item is tapped', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        wrapForTest(
          SizedBox(
            height: 600,
            child: FormaSidebar(
              sections: [
                FormaSidebarSection(
                  items: [
                    FormaSidebarItem(
                      icon: Icons.home,
                      label: 'Início',
                      onTap: () => taps++,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Início'));
      expect(taps, 1);
    });

    testWidgets('shows a toggle that fires onToggleCollapsed', (tester) async {
      var toggled = 0;
      await tester.pumpWidget(
        wrapForTest(
          SizedBox(
            height: 600,
            child: FormaSidebar(
              sections: sections,
              onToggleCollapsed: () => toggled++,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.chevron_left));
      expect(toggled, 1);
    });
  });
}
