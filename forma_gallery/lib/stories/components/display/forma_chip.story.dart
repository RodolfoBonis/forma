import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

/// FormaChip story.
GalleryComponent formaChipComponent() {
  return GalleryComponent(
    'FormaChip',
    docs: const ComponentDocs(
      description:
          'A small read-only tag chip with an optional leading icon. Neutral '
          'by default; pass a color to tint the icon, label, and border for '
          'emphasis.',
      props: [
        PropDoc(
          'label',
          'String',
          required: true,
          description: 'Text shown in the chip.',
        ),
        PropDoc('icon', 'IconData?', description: 'Optional leading icon.'),
        PropDoc(
          'color',
          'Color?',
          description: 'Optional tint for icon, label, and border.',
        ),
      ],
      codeSnippet: '''
FormaChip(
  label: 'Foto',
  icon: Icons.photo_camera_outlined,
)''',
    ),
    useCases: [
      UseCase('Tags', (context, k) {
        return const Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FormaChip(label: 'Foto', icon: Icons.photo_camera_outlined),
              FormaChip(label: 'Texto', icon: Icons.notes),
              FormaChip(label: 'Check', icon: Icons.check),
              FormaChip(label: 'Diária', icon: Icons.repeat),
              FormaChip(
                label: 'Alta',
                icon: Icons.flag_outlined,
                color: DominusColors.brass,
              ),
            ],
          ),
        );
      }),
    ],
  );
}
