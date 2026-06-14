import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSegmentedControl story.
GalleryComponent formaSegmentedControlComponent() {
  return GalleryComponent(
    'FormaSegmentedControl',
    docs: const ComponentDocs(
      description:
          'Pill-shaped segmented control for switching between 2–3 options. '
          'The active segment is highlighted with an elevated surface while '
          'inactive segments use muted text.',
      props: [
        PropDoc(
          'segments',
          'List<FormaSegment>',
          required: true,
          description: 'Segments to display (typically 2 or 3).',
        ),
        PropDoc(
          'selectedIndex',
          'int',
          required: true,
          description: 'Index of the currently selected segment.',
        ),
        PropDoc(
          'onChanged',
          'ValueChanged<int>',
          required: true,
          description: 'Called with the tapped segment index.',
        ),
      ],
      codeSnippet: '''
FormaSegmentedControl(
  selectedIndex: 0,
  onChanged: (index) {},
  segments: const [
    FormaSegment(label: 'Criar relação'),
    FormaSegment(label: 'Tenho um convite'),
  ],
)''',
    ),
    useCases: [
      UseCase('Two segments', (context, k) {
        var selected = 0;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StatefulBuilder(
              builder: (context, setState) {
                return FormaSegmentedControl(
                  selectedIndex: selected,
                  onChanged: (i) => setState(() => selected = i),
                  segments: const [
                    FormaSegment(label: 'Criar relação'),
                    FormaSegment(label: 'Tenho um convite'),
                  ],
                );
              },
            ),
          ),
        );
      }),
      UseCase('Three segments with icons', (context, k) {
        var selected = 1;
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StatefulBuilder(
              builder: (context, setState) {
                return FormaSegmentedControl(
                  selectedIndex: selected,
                  onChanged: (i) => setState(() => selected = i),
                  segments: const [
                    FormaSegment(label: 'Foto', icon: Icons.photo_camera),
                    FormaSegment(label: 'Texto', icon: Icons.notes),
                    FormaSegment(label: 'Check', icon: Icons.check),
                  ],
                );
              },
            ),
          ),
        );
      }),
    ],
  );
}
