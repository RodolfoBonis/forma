import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaDialog component — centered modal dialog playground.
GalleryComponent formaDialogComponent() {
  return GalleryComponent(
    'FormaDialog',
    docs: const ComponentDocs(
      description:
          'A centered modal dialog with a header (icon, title, description, '
          'close), a body and right-aligned footer actions. Presented via '
          'FormaDialog.show with a scale + fade transition and a 45% scrim. '
          'FormaConfirmDialog is a confirm/cancel convenience built on top.',
      props: [
        PropDoc('title', 'String', required: true),
        PropDoc('child', 'Widget', required: true),
        PropDoc('description', 'String?'),
        PropDoc('actions', 'List<Widget>', defaultValue: 'const []'),
        PropDoc('width', 'double', defaultValue: '480'),
        PropDoc('icon', 'Widget?'),
        PropDoc('scrollable', 'bool', defaultValue: 'true'),
      ],
      codeSnippet: '''
FormaDialog.show<void>(
  context,
  title: 'Convidar membros',
  description: 'Adicione pessoas ao workspace.',
  child: FormaTextField(label: 'E-mail'),
  actions: [
    FormaButton.secondary(label: 'Cancelar', small: true, onPressed: () {}),
    FormaButton.primary(label: 'Convidar', small: true, onPressed: () {}),
  ],
);''',
    ),
    useCases: [
      UseCase('Dialog', (context, k) {
        return Center(
          child: FormaButton.primary(
            label: 'Abrir diálogo',
            onPressed: () => FormaDialog.show<void>(
              context,
              title: 'Convidar membros',
              description: 'Adicione pessoas ao seu workspace.',
              icon: const Icon(Icons.group_add_outlined),
              child: const FormaTextField(
                label: 'E-mail',
                hint: 'nome@empresa.com',
              ),
              actions: [
                Builder(
                  builder: (ctx) => FormaButton.secondary(
                    label: 'Cancelar',
                    small: true,
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
                Builder(
                  builder: (ctx) => FormaButton.primary(
                    label: 'Convidar',
                    small: true,
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      UseCase('Confirm (destructive)', (context, k) {
        return Center(
          child: FormaButton.danger(
            label: 'Excluir projeto',
            onPressed: () => FormaConfirmDialog.show(
              context,
              title: 'Excluir projeto?',
              message: 'Esta ação é permanente e não pode ser desfeita.',
              confirmLabel: 'Excluir',
              destructive: true,
            ),
          ),
        );
      }),
    ],
  );
}
