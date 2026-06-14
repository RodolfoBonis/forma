import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaBottomSheet story — draggable bottom sheet modal.
GalleryComponent formaBottomSheetComponent() {
  return GalleryComponent(
    'FormaBottomSheet',
    docs: const ComponentDocs(
      description:
          'Draggable modal bottom sheet with a drag handle and optional title. '
          'Present it with the static FormaBottomSheet.show method.',
      props: [
        PropDoc(
          'child',
          'Widget',
          required: true,
          description: 'The sheet body content.',
        ),
        PropDoc(
          'title',
          'String?',
          description: 'Optional title below the drag handle.',
        ),
        PropDoc(
          'minChildSize',
          'double',
          defaultValue: '0.3',
          description: 'Minimum fraction of screen height.',
        ),
        PropDoc(
          'maxChildSize',
          'double',
          defaultValue: '0.9',
          description: 'Maximum fraction of screen height.',
        ),
        PropDoc(
          'isDismissible',
          'bool',
          defaultValue: 'true',
          description: 'Whether tapping outside dismisses the sheet.',
        ),
      ],
      codeSnippet: '''
FormaBottomSheet.show(
  context: context,
  title: 'Titulo da acao',
  child: const Padding(
    padding: EdgeInsets.all(24),
    child: Text('Detalhe do plantao selecionado'),
  ),
)''',
    ),
    useCases: [
      UseCase('Demo', (context, k) {
        final title = k.stringOrNull(
          label: 'Title',
          initialValue: 'Titulo da acao',
        );
        final isDismissible = k.boolean(
          label: 'Dismissible',
          initialValue: true,
        );

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FormaButton(
              label: 'Open Bottom Sheet',
              variant: FormaButtonVariant.primary,
              onPressed: () {
                FormaBottomSheet.show(
                  context: context,
                  title: title,
                  isDismissible: isDismissible,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detalhe do plantao selecionado',
                          style: FormaTypography.body14.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 12),
                        _infoRow('Data', '8 de abril'),
                        const SizedBox(height: 8),
                        _infoRow('Horario', '08:00 - 20:00'),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: FormaButton(
                            label: 'Acao principal',
                            variant: FormaButtonVariant.primary,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    ],
  );
}

Widget _infoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: FormaTypography.body14),
      Text(value, style: FormaTypography.body14),
    ],
  );
}
