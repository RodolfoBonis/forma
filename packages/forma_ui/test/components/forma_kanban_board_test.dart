import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

class _Task {
  const _Task(this.id, this.title);
  final String id;
  final String title;
}

Widget _board({
  List<FormaKanbanColumn<_Task>>? columns,
  bool loading = false,
  void Function(_Task, String, String)? onMove,
}) {
  return wrapForTestDesktop(
    SizedBox(
      height: 600,
      width: 800,
      child: FormaKanbanBoard<_Task>(
        loading: loading,
        columns:
            columns ??
            const [
              FormaKanbanColumn<_Task>(
                id: 'todo',
                title: 'A Fazer',
                items: [_Task('1', 'Primeira'), _Task('2', 'Segunda')],
              ),
              FormaKanbanColumn<_Task>(
                id: 'done',
                title: 'Concluído',
                items: [],
              ),
            ],
        itemKey: (t) => t.id,
        cardBuilder: (context, t) =>
            Padding(padding: const EdgeInsets.all(8), child: Text(t.title)),
        onMove: onMove ?? (_, __, ___) {},
      ),
    ),
  );
}

void main() {
  group('FormaKanbanBoard', () {
    testWidgets('renders column titles and counts', (tester) async {
      await tester.pumpWidget(_board());

      expect(find.text('A Fazer'), findsOneWidget);
      expect(find.text('Concluído'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('renders cards for each item', (tester) async {
      await tester.pumpWidget(_board());

      expect(find.text('Primeira'), findsOneWidget);
      expect(find.text('Segunda'), findsOneWidget);
    });

    testWidgets('shows the empty text for empty columns', (tester) async {
      await tester.pumpWidget(_board());

      expect(find.text('Nenhum item'), findsOneWidget);
    });

    testWidgets('renders skeleton placeholders while loading', (tester) async {
      await tester.pumpWidget(_board(loading: true));

      expect(find.byType(FormaShimmer), findsWidgets);
      expect(find.text('Primeira'), findsNothing);
    });

    testWidgets('uses totalCount when provided', (tester) async {
      await tester.pumpWidget(
        _board(
          columns: const [
            FormaKanbanColumn<_Task>(
              id: 'todo',
              title: 'A Fazer',
              items: [_Task('1', 'Primeira')],
              totalCount: 42,
            ),
          ],
        ),
      );

      expect(find.text('42'), findsOneWidget);
    });
  });
}
