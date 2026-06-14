import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaBadge story — all variants.
GalleryComponent formaBadgeComponent() {
  return GalleryComponent(
    'FormaBadge',
    docs: const ComponentDocs(
      description:
          'A small solid-filled status pill showing a colored label. Each '
          'variant maps to a semantic background/text color pair from the '
          'active theme.',
      props: [
        PropDoc(
          'label',
          'String',
          required: true,
          description: 'Text displayed inside the badge.',
        ),
        PropDoc(
          'variant',
          'FormaBadgeVariant',
          required: true,
          description: 'Visual style controlling background and text color.',
        ),
      ],
      codeSnippet: '''
FormaBadge(
  label: 'Confirmada',
  variant: FormaBadgeVariant.confirmada,
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(label: 'Label', initialValue: 'Confirmada');
        final variant = k.object.dropdown<FormaBadgeVariant>(
          label: 'Variant',
          options: FormaBadgeVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaBadgeVariant.confirmada,
        );

        return Center(
          child: FormaBadge(label: label, variant: variant),
        );
      }),
      UseCase('All Variants', (context, k) {
        return Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final variant in FormaBadgeVariant.values)
                FormaBadge(label: variant.name, variant: variant),
            ],
          ),
        );
      }),
    ],
  );
}
