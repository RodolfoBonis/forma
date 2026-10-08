import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSideSheet component — right-edge drawer playground.
GalleryComponent formaSideSheetComponent() {
  return GalleryComponent(
    'FormaSideSheet',
    docs: const ComponentDocs(
      description:
          'A right-edge side sheet (drawer) for desktop detail / form flows. '
          'FormaSideSheet.show slides a full-height panel in from the right. '
          'Pair it with FormaSideSheetScaffold for a sticky header/footer and '
          'a scrolling body.',
      props: [
        PropDoc('builder', 'Widget Function(BuildContext)', required: true),
        PropDoc('width', 'double', defaultValue: '560'),
        PropDoc('barrierDismissible', 'bool', defaultValue: 'true'),
      ],
      codeSnippet: '''
FormaSideSheet.show<void>(
  context,
  builder: (_) => FormaSideSheetScaffold(
    title: 'Detalhes do projeto',
    subtitle: 'Atualizado há 2h',
    body: Text('…'),
    footer: FormaButton.primary(label: 'Salvar', onPressed: () {}),
  ),
);''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        return Center(
          child: FormaButton.primary(
            label: 'Abrir side sheet',
            onPressed: () => FormaSideSheet.show<void>(
              context,
              builder: (sheetContext) => FormaSideSheetScaffold(
                title: 'Detalhes do projeto',
                subtitle: 'Atualizado há 2 horas',
                headerActions: [
                  FormaMenuButton(
                    items: [
                      FormaMenuItem(label: 'Duplicar', onTap: () {}),
                      FormaMenuItem(
                        label: 'Excluir',
                        destructive: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
                footer: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FormaButton.secondary(
                      label: 'Cancelar',
                      small: true,
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                    const SizedBox(width: 8),
                    FormaButton.primary(
                      label: 'Salvar',
                      small: true,
                      onPressed: () => Navigator.of(sheetContext).pop(),
                    ),
                  ],
                ),
                body: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormaTextField(label: 'Nome', hint: 'Projeto X'),
                    SizedBox(height: 16),
                    FormaTextField(
                      label: 'Descrição',
                      hint: 'Resumo do projeto',
                      maxLines: 5,
                      minLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    ],
  );
}
