import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaStatusBadge story.
GalleryComponent formaStatusBadgeComponent() {
  return GalleryComponent(
    'FormaStatusBadge',
    docs: const ComponentDocs(
      description:
          'A status pill with a colored leading dot and a label, on an '
          'elevated surface. Uses the dot + label style for workflow states, '
          'distinct from the solid-filled FormaBadge.',
      props: [
        PropDoc(
          'variant',
          'FormaStatusVariant',
          required: true,
          description: 'Workflow status, controlling color and default label.',
        ),
        PropDoc(
          'label',
          'String?',
          description: "Optional override of the variant's default text.",
        ),
      ],
      codeSnippet: 'FormaStatusBadge(variant: FormaStatusVariant.pendente)',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final variant = k.object.dropdown<FormaStatusVariant>(
          label: 'Status',
          options: FormaStatusVariant.values,
          labelBuilder: (v) => v.label,
          initialOption: FormaStatusVariant.pendente,
        );
        return Center(child: FormaStatusBadge(variant: variant));
      }),
      UseCase('All statuses', (context, k) {
        return Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final v in FormaStatusVariant.values)
                FormaStatusBadge(variant: v),
            ],
          ),
        );
      }),
    ],
  );
}
