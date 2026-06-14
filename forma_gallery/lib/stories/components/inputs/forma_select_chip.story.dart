import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSelectChip story.
GalleryComponent formaSelectChipComponent() {
  return GalleryComponent(
    'FormaSelectChip',
    docs: const ComponentDocs(
      description:
          'A toggleable filter chip with an optional leading icon. When '
          'selected, it uses a subtle primary-tinted surface with a primary '
          'border; otherwise it is outlined and muted.',
      props: [
        PropDoc('label', 'String', required: true, description: 'Chip text.'),
        PropDoc(
          'selected',
          'bool',
          required: true,
          description: 'Whether the chip is currently selected.',
        ),
        PropDoc(
          'onSelected',
          'ValueChanged<bool>',
          required: true,
          description: 'Called with the new selection state when tapped.',
        ),
        PropDoc('icon', 'IconData?', description: 'Optional leading icon.'),
      ],
      codeSnippet: '''
FormaSelectChip(
  label: 'Opção',
  selected: true,
  icon: Icons.flag_outlined,
  onSelected: (selected) {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(label: 'Label', initialValue: 'Opção');
        final withIcon = k.boolean(label: 'With icon');
        var selected = true;
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return FormaSelectChip(
                label: label,
                selected: selected,
                icon: withIcon ? Icons.flag_outlined : null,
                onSelected: (v) => setState(() => selected = v),
              );
            },
          ),
        );
      }),
      UseCase('On / Off', (context, k) {
        return const Center(
          child: Wrap(
            spacing: 12,
            children: [
              FormaSelectChip(
                label: 'Selecionada',
                selected: true,
                onSelected: _noop,
                icon: Icons.repeat,
              ),
              FormaSelectChip(
                label: 'Não selecionada',
                selected: false,
                onSelected: _noop,
                icon: Icons.calendar_today,
              ),
            ],
          ),
        );
      }),
    ],
  );
}

void _noop(bool _) {}
