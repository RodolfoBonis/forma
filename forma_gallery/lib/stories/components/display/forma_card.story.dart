import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';

/// FormaCard story — all variants.
GalleryComponent formaCardComponent() {
  return GalleryComponent(
    'FormaCard',
    docs: const ComponentDocs(
      description:
          'A themed card container supporting four variants (basic, heroDark, '
          'swap, shift) with optional accent color and selection state.',
      props: [
        PropDoc(
          'child',
          'Widget',
          required: true,
          description: 'Content rendered inside the card.',
        ),
        PropDoc(
          'variant',
          'FormaCardVariant',
          defaultValue: 'basic',
          description: 'Visual style of the card.',
        ),
        PropDoc(
          'accentColor',
          'Color?',
          description: 'Left accent color for the swap variant.',
        ),
        PropDoc(
          'selected',
          'bool',
          defaultValue: 'false',
          description: 'Highlights the border (shift variant only).',
        ),
        PropDoc(
          'backgroundColor',
          'Color?',
          description: 'Custom background; defaults per variant.',
        ),
        PropDoc('width', 'double?', description: 'Fixed width.'),
        PropDoc('height', 'double?', description: 'Fixed height.'),
      ],
      codeSnippet: '''
FormaCard(
  variant: FormaCardVariant.basic,
  child: Text('Card content goes here'),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final variant = k.object.dropdown<FormaCardVariant>(
          label: 'Variant',
          options: FormaCardVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaCardVariant.basic,
        );
        final selected = k.boolean(
          label: 'Selected (shift only)',
          initialValue: false,
        );
        final useCustomBg = k.boolean(
          label: 'Custom background',
          initialValue: false,
        );
        final width = k.double.input(label: 'Width', initialValue: 0);
        final height = k.double.input(label: 'Height', initialValue: 0);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaCard(
            variant: variant,
            selected: selected,
            accentColor: PfColors.primary700,
            selectedColor: PfColors.primary700,
            backgroundColor: useCustomBg ? PfColors.primary50 : null,
            width: width > 0 ? width : null,
            height: height > 0 ? height : null,
            child: const Text('Card content goes here'),
          ),
        );
      }),
      UseCase('All Variants', (context, k) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final variant in FormaCardVariant.values) ...[
                Text(
                  variant.name,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                FormaCard(
                  variant: variant,
                  accentColor: PfColors.primary700,
                  child: Text(
                    'Card variant: ${variant.name}',
                    style: TextStyle(
                      color: variant == FormaCardVariant.heroDark
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        );
      }),
    ],
  );
}
