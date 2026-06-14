import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaOrderCard story.
GalleryComponent formaOrderCardComponent() {
  return GalleryComponent(
    'FormaOrderCard',
    docs: const ComponentDocs(
      description:
          'A task / order card composed of a status row, title, description, '
          'a row of tag chips, and an optional trailing action. Slots compose '
          'with other Forma components.',
      props: [
        PropDoc('title', 'String', required: true, description: 'Card title.'),
        PropDoc(
          'description',
          'String?',
          description: 'Optional supporting description.',
        ),
        PropDoc(
          'status',
          'Widget?',
          description: 'Optional leading status widget (e.g. a FormaBadge).',
        ),
        PropDoc(
          'timeLabel',
          'String?',
          description: 'Optional trailing timestamp on the top row.',
        ),
        PropDoc(
          'tags',
          'List<Widget>',
          defaultValue: 'const []',
          description: 'Tag chips shown above the action row.',
        ),
        PropDoc(
          'action',
          'Widget?',
          description: 'Optional trailing action (e.g. a FormaButton).',
        ),
      ],
      codeSnippet: '''
FormaOrderCard(
  status: const FormaBadge(
    label: 'Pendente',
    variant: FormaBadgeVariant.pendente,
  ),
  timeLabel: 'Hoje · 21:00',
  title: 'Beba 2L de água',
  description: 'Registre com foto da garrafa vazia.',
  action: FormaButton.primary(label: 'Marcar feita', onPressed: () {}),
)''',
    ),
    useCases: [
      UseCase('Task order', (context, k) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FormaOrderCard(
              status: const FormaBadge(
                label: 'Pendente',
                variant: FormaBadgeVariant.pendente,
              ),
              timeLabel: 'Hoje · 21:00',
              title: 'Beba 2L de água',
              description:
                  'Registre com foto da garrafa vazia antes de dormir.',
              tags: const [
                FormaSelectChip(
                  label: 'Foto',
                  selected: false,
                  onSelected: _noop,
                  icon: Icons.photo_camera_outlined,
                ),
                FormaSelectChip(
                  label: 'Diária',
                  selected: false,
                  onSelected: _noop,
                  icon: Icons.repeat,
                ),
              ],
              action: FormaButton.primary(
                label: 'Marcar feita',
                onPressed: () {},
              ),
            ),
          ),
        );
      }),
    ],
  );
}

void _noop(bool _) {}
