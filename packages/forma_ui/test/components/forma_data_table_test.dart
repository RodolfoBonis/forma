import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

class _Person {
  const _Person(this.name, this.age);
  final String name;
  final int age;
}

List<FormaColumn<_Person>> _columns() => [
  FormaColumn<_Person>(
    id: 'name',
    label: 'Nome',
    sortable: true,
    cellBuilder: (context, row) => Text(row.name),
  ),
  FormaColumn<_Person>(
    id: 'age',
    label: 'Idade',
    width: 80,
    cellBuilder: (context, row) => Text('${row.age}'),
  ),
];

void main() {
  group('FormaDataTable', () {
    testWidgets('renders headers and row cells', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDataTable<_Person>(
            columns: _columns(),
            shrinkWrap: true,
            rows: const [_Person('Ana', 30), _Person('Beto', 25)],
          ),
        ),
      );

      expect(find.text('Nome'), findsOneWidget);
      expect(find.text('Idade'), findsOneWidget);
      expect(find.text('Ana'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
    });

    testWidgets('shows the default empty message', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDataTable<_Person>(
            columns: _columns(),
            shrinkWrap: true,
            rows: const [],
          ),
        ),
      );

      expect(find.text('Nenhum registro'), findsOneWidget);
    });

    testWidgets('fires onRowTap when a row is tapped', (tester) async {
      _Person? tapped;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDataTable<_Person>(
            columns: _columns(),
            shrinkWrap: true,
            rows: const [_Person('Ana', 30)],
            onRowTap: (row) => tapped = row,
          ),
        ),
      );

      await tester.tap(find.text('Ana'));
      expect(tapped?.name, 'Ana');
    });

    testWidgets('fires onSort when a sortable header is tapped', (
      tester,
    ) async {
      String? sortedColumn;
      bool? ascending;
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDataTable<_Person>(
            columns: _columns(),
            shrinkWrap: true,
            rows: const [_Person('Ana', 30)],
            onSort: (id, asc) {
              sortedColumn = id;
              ascending = asc;
            },
          ),
        ),
      );

      await tester.tap(find.text('Nome'));
      expect(sortedColumn, 'name');
      expect(ascending, isTrue);
    });

    testWidgets('renders skeletons while loading', (tester) async {
      await tester.pumpWidget(
        wrapForTestDesktop(
          FormaDataTable<_Person>(
            columns: _columns(),
            shrinkWrap: true,
            loading: true,
            skeletonRows: 3,
            rows: const [],
          ),
        ),
      );

      expect(find.text('Nenhum registro'), findsNothing);
      expect(find.byType(FormaShimmer), findsWidgets);
    });
  });
}
