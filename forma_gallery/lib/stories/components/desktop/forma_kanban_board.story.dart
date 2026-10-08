import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

class _Card {
  const _Card(this.id, this.title);
  final String id;
  final String title;
}

/// FormaKanbanBoard component — drag & drop board with columns and states.
GalleryComponent formaKanbanBoardComponent() {
  return GalleryComponent(
    'FormaKanbanBoard',
    docs: const ComponentDocs(
      description:
          'Horizontally scrollable Kanban board with mouse drag & drop. '
          'Allowed drop columns highlight with a dashed primary border, '
          'disallowed columns dim, and the board calls onMove without '
          'mutating any list. Supports collapse, infinite scroll and loading.',
      props: [
        PropDoc(
          'columns',
          'List<FormaKanbanColumn<T>>',
          required: true,
          description: 'Columns with their items and metadata.',
        ),
        PropDoc(
          'itemKey',
          'Object Function(T)',
          required: true,
          description: 'Stable identity for an item.',
        ),
        PropDoc(
          'cardBuilder',
          'Widget Function(BuildContext, T)',
          required: true,
        ),
        PropDoc(
          'onMove',
          'void Function(T, String, String)',
          required: true,
          description: 'Called on a valid drop (item, fromId, toId).',
        ),
        PropDoc(
          'canMove',
          'bool Function(T, String, String)?',
          description: 'Gate which moves are allowed.',
        ),
      ],
      codeSnippet: '''
FormaKanbanBoard<Task>(
  columns: columns,
  itemKey: (t) => t.id,
  cardBuilder: (c, t) => TaskCard(t),
  onMove: (t, from, to) => moveTask(t, to),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final loading = k.boolean(label: 'Loading', initialValue: false);
        return _KanbanDemo(loading: loading);
      }),
    ],
  );
}

class _KanbanDemo extends StatefulWidget {
  const _KanbanDemo({required this.loading});

  final bool loading;

  @override
  State<_KanbanDemo> createState() => _KanbanDemoState();
}

class _KanbanDemoState extends State<_KanbanDemo> {
  final Map<String, List<_Card>> _columns = {
    'todo': [
      const _Card('1', 'Desenhar telas'),
      const _Card('2', 'Revisar API'),
    ],
    'doing': [const _Card('3', 'Implementar login')],
    'done': [const _Card('4', 'Configurar CI')],
  };

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        height: 460,
        child: FormaKanbanBoard<_Card>(
          loading: widget.loading,
          itemKey: (c) => c.id,
          columns: [
            FormaKanbanColumn<_Card>(
              id: 'todo',
              title: 'A Fazer',
              color: ext.textMuted,
              items: _columns['todo']!,
            ),
            FormaKanbanColumn<_Card>(
              id: 'doing',
              title: 'Em Progresso',
              color: ext.warningColor,
              items: _columns['doing']!,
            ),
            FormaKanbanColumn<_Card>(
              id: 'done',
              title: 'Concluído',
              color: ext.successColor,
              items: _columns['done']!,
            ),
          ],
          cardBuilder: (context, card) => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ext.cardBackground,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              card.title,
              style: context.formaTypography.body13.copyWith(
                color: ext.textPrimary,
              ),
            ),
          ),
          onMove: (card, from, to) {
            setState(() {
              _columns[from]!.remove(card);
              _columns[to]!.add(card);
            });
          },
        ),
      ),
    );
  }
}
