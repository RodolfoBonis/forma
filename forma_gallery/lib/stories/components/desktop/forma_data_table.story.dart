import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

class _Row {
  const _Row(this.name, this.email, this.status);
  final String name;
  final String email;
  final String status;
}

const _data = <_Row>[
  _Row('Ana Silva', 'ana@acme.com', 'Ativo'),
  _Row('Bruno Costa', 'bruno@acme.com', 'Pendente'),
  _Row('Carla Dias', 'carla@acme.com', 'Ativo'),
  _Row('Diego Melo', 'diego@acme.com', 'Inativo'),
];

/// FormaDataTable component — desktop data grid with sorting and states.
GalleryComponent formaDataTableComponent() {
  return GalleryComponent(
    'FormaDataTable',
    docs: const ComponentDocs(
      description:
          'Compact desktop data table: sticky sortable header, hover + '
          'keyboard-focusable rows, loading skeletons, empty state and an '
          'optional trailing actions cell.',
      props: [
        PropDoc(
          'columns',
          'List<FormaColumn<T>>',
          required: true,
          description: 'Column definitions (id, label, cellBuilder, …).',
        ),
        PropDoc('rows', 'List<T>', required: true, description: 'Row data.'),
        PropDoc(
          'onRowTap',
          'void Function(T)?',
          description: 'Row activation handler (tap / Enter).',
        ),
        PropDoc(
          'onSort',
          'void Function(String, bool)?',
          description: 'Called when a sortable header is clicked.',
        ),
        PropDoc('loading', 'bool', defaultValue: 'false'),
      ],
      codeSnippet: '''
FormaDataTable<User>(
  columns: [
    FormaColumn(id: 'name', label: 'Nome', cellBuilder: (c, u) => Text(u.name)),
  ],
  rows: users,
  onRowTap: (u) => openUser(u),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final loading = k.boolean(label: 'Loading', initialValue: false);
        final empty = k.boolean(label: 'Empty', initialValue: false);
        final withActions = k.boolean(
          label: 'Trailing actions',
          initialValue: true,
        );

        return Padding(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            height: 320,
            child: FormaDataTable<_Row>(
              loading: loading,
              rows: empty ? const [] : _data,
              sortColumnId: 'name',
              onSort: (_, __) {},
              onRowTap: (_) {},
              trailingBuilder: withActions
                  ? (context, row) => const Icon(Icons.more_horiz, size: 18)
                  : null,
              columns: [
                FormaColumn<_Row>(
                  id: 'name',
                  label: 'Nome',
                  sortable: true,
                  cellBuilder: (context, row) => Text(row.name),
                ),
                FormaColumn<_Row>(
                  id: 'email',
                  label: 'E-mail',
                  flex: 2,
                  cellBuilder: (context, row) => Text(row.email),
                ),
                FormaColumn<_Row>(
                  id: 'status',
                  label: 'Status',
                  width: 120,
                  cellBuilder: (context, row) => Text(row.status),
                ),
              ],
            ),
          ),
        );
      }),
    ],
  );
}
