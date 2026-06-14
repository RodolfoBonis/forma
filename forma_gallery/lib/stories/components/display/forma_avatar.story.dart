import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

/// FormaAvatar story — all sizes with knobs.
GalleryComponent formaAvatarComponent() {
  return GalleryComponent(
    'FormaAvatar',
    docs: const ComponentDocs(
      description:
          'A colored circle showing a single-character initial or a network '
          'image. Used for user and team avatars, with optional border and '
          'outer role ring.',
      props: [
        PropDoc(
          'initial',
          'String',
          required: true,
          description: 'Single character shown when no image is provided.',
        ),
        PropDoc(
          'color',
          'Color',
          required: true,
          description: 'Background color behind the initial.',
        ),
        PropDoc('imageUrl', 'String?', description: 'Optional network image.'),
        PropDoc(
          'size',
          'FormaAvatarSize',
          defaultValue: 'medium',
          description: 'Size preset (diameter, radius, font).',
        ),
        PropDoc(
          'ringColor',
          'Color?',
          description: 'Optional outer ring color (e.g. a role marker).',
        ),
      ],
      codeSnippet: '''
FormaAvatar(
  initial: 'A',
  color: Color(0xFF7E1A36),
  size: FormaAvatarSize.large,
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final initial = k.string(label: 'Initial', initialValue: 'A');
        final size = k.object.dropdown<FormaAvatarSize>(
          label: 'Size',
          options: FormaAvatarSize.values,
          labelBuilder: (s) => s.name,
          initialOption: FormaAvatarSize.medium,
        );

        return Center(
          child: FormaAvatar(
            initial: initial,
            color: PfColors.primary700,
            size: size,
          ),
        );
      }),
      UseCase('All Sizes', (context, k) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final size in FormaAvatarSize.values) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormaAvatar(
                      initial: 'A',
                      color: PfColors.primary700,
                      size: size,
                    ),
                    const SizedBox(height: 8),
                    Text(size.name, style: const TextStyle(fontSize: 11)),
                  ],
                ),
                const SizedBox(width: 16),
              ],
            ],
          ),
        );
      }),
      UseCase('Role rings (Dom / Sub)', (context, k) {
        return const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormaAvatar(
                initial: 'R',
                color: Color(0xFF7E1A36),
                size: FormaAvatarSize.large,
                ringColor: DominusColors.roleDom,
              ),
              SizedBox(width: 24),
              FormaAvatar(
                initial: 'M',
                color: Color(0xFF7E1A36),
                size: FormaAvatarSize.large,
                ringColor: DominusColors.roleSub,
              ),
            ],
          ),
        );
      }),
    ],
  );
}
