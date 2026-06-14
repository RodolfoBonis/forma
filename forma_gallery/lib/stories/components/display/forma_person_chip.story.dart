import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

/// FormaPersonChip story — active and inactive states.
GalleryComponent formaPersonChipComponent() {
  return GalleryComponent(
    'FormaPersonChip',
    docs: const ComponentDocs(
      description:
          'A person chip showing an avatar initial and name. Uses FormaAvatar '
          'internally and switches between active (tinted) and inactive '
          '(muted) styles.',
      props: [
        PropDoc(
          'initial',
          'String',
          required: true,
          description: 'Single character shown in the avatar.',
        ),
        PropDoc(
          'name',
          'String',
          required: true,
          description: "The person's name shown next to the avatar.",
        ),
        PropDoc(
          'color',
          'Color',
          required: true,
          description: "The person's assigned color.",
        ),
        PropDoc(
          'surfaceColor',
          'Color',
          required: true,
          description: "The person's surface/background color.",
        ),
        PropDoc(
          'isActive',
          'bool',
          defaultValue: 'false',
          description: 'Whether the chip is in the active/selected state.',
        ),
      ],
      codeSnippet: '''
FormaPersonChip(
  initial: 'A',
  name: 'Ana',
  color: PfPersonColors.ana,
  surfaceColor: PfPersonColors.anaSurface,
  isActive: true,
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final name = k.string(label: 'Name', initialValue: 'Ana');
        final isActive = k.boolean(label: 'Active', initialValue: true);

        return Center(
          child: FormaPersonChip(
            initial: name.isNotEmpty ? name[0] : 'A',
            name: name,
            color: PfPersonColors.ana,
            surfaceColor: PfPersonColors.anaSurface,
            isActive: isActive,
          ),
        );
      }),
      UseCase('All People', (context, k) {
        return Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const FormaPersonChip(
                initial: 'A',
                name: 'Ana',
                color: PfPersonColors.ana,
                surfaceColor: PfPersonColors.anaSurface,
                isActive: true,
              ),
              const FormaPersonChip(
                initial: 'D',
                name: 'Diogenes',
                color: PfPersonColors.diogenes,
                surfaceColor: PfPersonColors.diogenesSurface,
                isActive: true,
              ),
              const FormaPersonChip(
                initial: 'A',
                name: 'Augusto',
                color: PfPersonColors.augusto,
                surfaceColor: PfPersonColors.augustoSurface,
                isActive: false,
              ),
            ],
          ),
        );
      }),
    ],
  );
}
