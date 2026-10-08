import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

void main() {
  group('FormaPagination', () {
    testWidgets('renders the summary when total and pageSize are given', (
      tester,
    ) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaPagination(
            page: 1,
            totalPages: 7,
            total: 135,
            pageSize: 20,
            onPageChanged: (_) {},
          ),
        ),
      );

      expect(find.text('Mostrando 1–20 de 135 registros'), findsOneWidget);
    });

    testWidgets('fires onPageChanged when a page button is tapped', (
      tester,
    ) async {
      int? requested;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaPagination(
            page: 1,
            totalPages: 5,
            onPageChanged: (p) => requested = p,
          ),
        ),
      );

      await tester.tap(find.text('3'));
      expect(requested, 3);
    });

    testWidgets('collapses large ranges with an ellipsis', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaPagination(page: 6, totalPages: 12, onPageChanged: (_) {}),
        ),
      );

      expect(find.text('…'), findsWidgets);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets('next advances the page', (tester) async {
      int? requested;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaPagination(
            page: 2,
            totalPages: 5,
            onPageChanged: (p) => requested = p,
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.chevron_right));
      expect(requested, 3);
    });
  });
}
