import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaMenuButton component — dropdown menu playground.
GalleryComponent formaMenuButtonComponent() {
  return GalleryComponent(
    'FormaMenuButton',
    docs: const ComponentDocs(
      description:
          'A compact dropdown menu triggered by an icon button or a custom '
          'builder. Built on MenuAnchor for free keyboard traversal and '
          'dismissal. Items support an icon, a shortcut hint, a disabled '
          'state, dividers, and a destructive style.',
      props: [
        PropDoc('items', 'List<FormaMenuItem>', required: true),
        PropDoc('icon', 'IconData', defaultValue: 'Icons.more_horiz'),
        PropDoc('tooltip', 'String?'),
        PropDoc('builder', 'Widget Function(BuildContext, VoidCallback)?'),
      ],
      codeSnippet: '''
FormaMenuButton(
  items: [
    FormaMenuItem(label: 'Editar', icon: Icons.edit, shortcut: '⌘E', onTap: () {}),
    const FormaMenuItem.divider(),
    FormaMenuItem(label: 'Excluir', icon: Icons.delete, destructive: true, onTap: () {}),
  ],
)''',
    ),
    useCases: [
      UseCase('Icon trigger', (context, k) {
        return Center(
          child: FormaMenuButton(
            tooltip: 'Ações',
            items: [
              FormaMenuItem(
                label: 'Editar',
                icon: Icons.edit_outlined,
                shortcut: '⌘E',
                onTap: () {},
              ),
              FormaMenuItem(
                label: 'Duplicar',
                icon: Icons.copy_outlined,
                shortcut: '⌘D',
                onTap: () {},
              ),
              const FormaMenuItem.divider(),
              FormaMenuItem(
                label: 'Arquivar',
                icon: Icons.archive_outlined,
                enabled: false,
                onTap: () {},
              ),
              FormaMenuItem(
                label: 'Excluir',
                icon: Icons.delete_outline,
                destructive: true,
                onTap: () {},
              ),
            ],
          ),
        );
      }),
      UseCase('Custom trigger', (context, k) {
        return Center(
          child: FormaMenuButton(
            items: [
              FormaMenuItem(label: 'Perfil', onTap: () {}),
              FormaMenuItem(label: 'Sair', destructive: true, onTap: () {}),
            ],
            builder: (context, open) => FormaButton.secondary(
              label: 'Opções',
              icon: const Icon(Icons.expand_more, size: 16),
              onPressed: open,
            ),
          ),
        );
      }),
    ],
  );
}
