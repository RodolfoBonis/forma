import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaEmptyState component — zero-data placeholder playground.
GalleryComponent formaEmptyStateComponent() {
  return GalleryComponent(
    'FormaEmptyState',
    docs: const ComponentDocs(
      description:
          'A centered empty / zero-data placeholder: an icon in a soft '
          'primary circle, a title, an optional muted message and an optional '
          'action.',
      props: [
        PropDoc('icon', 'IconData', required: true),
        PropDoc('title', 'String', required: true),
        PropDoc('message', 'String?'),
        PropDoc('action', 'Widget?'),
        PropDoc('compact', 'bool', defaultValue: 'false'),
      ],
      codeSnippet: '''
FormaEmptyState(
  icon: Icons.inbox_outlined,
  title: 'Nenhum projeto',
  message: 'Crie seu primeiro projeto para começar.',
  action: FormaButton.primary(label: 'Novo projeto', onPressed: () {}),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final title = k.string(label: 'Title', initialValue: 'Nenhum projeto');
        final message = k.string(
          label: 'Message',
          initialValue: 'Crie seu primeiro projeto para começar.',
        );
        final compact = k.boolean(label: 'Compact', initialValue: false);
        final withAction = k.boolean(label: 'With action', initialValue: true);

        return FormaEmptyState(
          icon: Icons.inbox_outlined,
          title: title,
          message: message,
          compact: compact,
          action: withAction
              ? FormaButton.primary(label: 'Novo projeto', onPressed: () {})
              : null,
        );
      }),
    ],
  );
}
