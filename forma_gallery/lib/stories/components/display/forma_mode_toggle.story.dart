import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaModeToggle story — segmented toggle with two options.
GalleryComponent formaModeToggleComponent() {
  return GalleryComponent(
    'FormaModeToggle',
    docs: const ComponentDocs(
      description:
          'A two-option segmented toggle. Exactly two options must be '
          'provided; the selected option is highlighted with the primary '
          'brand color.',
      props: [
        PropDoc(
          'options',
          'List<String>',
          required: true,
          description: 'The two option labels.',
        ),
        PropDoc(
          'selectedIndex',
          'int',
          required: true,
          description: 'Index of the selected option (0 or 1).',
        ),
        PropDoc(
          'onChanged',
          'void Function(int)',
          required: true,
          description: 'Called when the selection changes.',
        ),
      ],
      codeSnippet: '''
FormaModeToggle(
  options: const ['Com aprovacao', 'Acordo direto'],
  selectedIndex: 0,
  onChanged: (index) {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final optionA = k.string(
          label: 'Option A',
          initialValue: 'Com aprovacao',
        );
        final optionB = k.string(
          label: 'Option B',
          initialValue: 'Acordo direto',
        );
        final selectedIndex = k.int.slider(
          label: 'Selected Index',
          initialValue: 0,
          min: 0,
          max: 1,
        );

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaModeToggle(
            options: [optionA, optionB],
            selectedIndex: selectedIndex,
            onChanged: (_) {},
          ),
        );
      }),
      UseCase('Interactive', (context, k) => const _InteractiveModeToggle()),
    ],
  );
}

class _InteractiveModeToggle extends StatefulWidget {
  const _InteractiveModeToggle();

  @override
  State<_InteractiveModeToggle> createState() => _InteractiveModeToggleState();
}

class _InteractiveModeToggleState extends State<_InteractiveModeToggle> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormaModeToggle(
            options: const ['Com aprovacao', 'Acordo direto'],
            selectedIndex: _selected,
            onChanged: (index) => setState(() => _selected = index),
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: ${_selected == 0 ? "Com aprovacao" : "Acordo direto"}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
