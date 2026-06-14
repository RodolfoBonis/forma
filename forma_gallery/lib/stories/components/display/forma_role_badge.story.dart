import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

/// FormaRoleBadge story.
GalleryComponent formaRoleBadgeComponent() {
  return GalleryComponent(
    'FormaRoleBadge',
    docs: const ComponentDocs(
      description:
          'A small pill with a colored leading dot and a label, tinted by a '
          'single color. Used for role / category markers such as Dom / Sub.',
      props: [
        PropDoc(
          'label',
          'String',
          required: true,
          description: 'Text shown in the badge.',
        ),
        PropDoc(
          'color',
          'Color',
          required: true,
          description: 'Tint applied to the dot, border, and text.',
        ),
      ],
      codeSnippet: '''
FormaRoleBadge(
  label: 'Dom',
  color: DominusColors.roleDom,
)''',
    ),
    useCases: [
      UseCase('Dom / Sub', (context, k) {
        return const Center(
          child: Wrap(
            spacing: 12,
            children: [
              FormaRoleBadge(label: 'Dom', color: DominusColors.roleDom),
              FormaRoleBadge(label: 'Sub', color: DominusColors.roleSub),
            ],
          ),
        );
      }),
    ],
  );
}
