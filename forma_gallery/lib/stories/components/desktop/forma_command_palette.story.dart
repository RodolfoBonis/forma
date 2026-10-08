import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaCommandPalette component — ⌘K palette playground.
GalleryComponent formaCommandPaletteComponent() {
  return GalleryComponent(
    'FormaCommandPalette',
    docs: const ComponentDocs(
      description:
          'A centered command palette (⌘K style) for fast keyboard-driven '
          'actions. Static items are filtered (case/diacritics-insensitive) '
          'and grouped; optional async results are fetched (debounced) and '
          'shown below. ↑/↓ move the highlight, Enter selects, Esc closes.',
      props: [
        PropDoc('items', 'List<FormaCommandItem>', required: true),
        PropDoc('onSearch', 'Future<List<FormaCommandItem>> Function(String)?'),
        PropDoc('hint', 'String', defaultValue: "'Buscar ou executar…'"),
      ],
      codeSnippet: '''
FormaCommandPalette.show(
  context,
  items: [
    FormaCommandItem(id: 'new', label: 'Novo projeto', icon: Icons.add,
      group: 'Ações', shortcut: '⌘N', onSelected: () {}),
  ],
);''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        List<FormaCommandItem> items() => [
          FormaCommandItem(
            id: 'new',
            label: 'Novo projeto',
            icon: Icons.add,
            group: 'Ações',
            shortcut: '⌘N',
            keywords: const ['criar', 'adicionar'],
            onSelected: () {},
          ),
          FormaCommandItem(
            id: 'invite',
            label: 'Convidar membro',
            icon: Icons.person_add_outlined,
            group: 'Ações',
            onSelected: () {},
          ),
          FormaCommandItem(
            id: 'settings',
            label: 'Configurações',
            icon: Icons.settings_outlined,
            group: 'Navegação',
            subtitle: 'Preferências do workspace',
            shortcut: '⌘,',
            onSelected: () {},
          ),
          FormaCommandItem(
            id: 'docs',
            label: 'Documentação',
            icon: Icons.menu_book_outlined,
            group: 'Navegação',
            onSelected: () {},
          ),
        ];

        return Center(
          child: FormaButton.primary(
            label: 'Abrir paleta (⌘K)',
            onPressed: () => FormaCommandPalette.show(context, items: items()),
          ),
        );
      }),
    ],
  );
}
