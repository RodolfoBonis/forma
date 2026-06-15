import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTextButton component — playground with knobs + all variants.
GalleryComponent formaTextButtonComponent() {
  return GalleryComponent(
    'FormaTextButton',
    docs: const ComponentDocs(
      description:
          'Flat, text-only button (no fill or border) for low-emphasis or '
          'secondary actions — e.g. a "sign in" link beneath a primary CTA. '
          'Keeps a 48px touch target and fills its width by default.',
      props: [
        PropDoc('label', 'String', required: true, description: 'Button text.'),
        PropDoc(
          'onPressed',
          'VoidCallback?',
          description: 'Tap handler; null disables the button.',
        ),
        PropDoc(
          'variant',
          'FormaTextButtonVariant',
          defaultValue: 'primary',
          description: 'Label color: primary, danger, or neutral.',
        ),
        PropDoc(
          'width',
          'double?',
          description: 'Fixed width; defaults to fill.',
        ),
      ],
      codeSnippet: '''
FormaTextButton.primary(
  label: 'Já tenho conta',
  onPressed: () {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(label: 'Label', initialValue: 'Já tenho conta');
        final variant = k.object.dropdown<FormaTextButtonVariant>(
          label: 'Variant',
          options: FormaTextButtonVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaTextButtonVariant.primary,
        );
        final enabled = k.boolean(label: 'Enabled', initialValue: true);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaTextButton(
            label: label,
            variant: variant,
            onPressed: enabled ? () {} : null,
          ),
        );
      }),
      UseCase('All Variants', (context, k) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final variant in FormaTextButtonVariant.values) ...[
                Text(
                  variant.name,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                FormaTextButton(
                  label: 'Text ${variant.name}',
                  variant: variant,
                  onPressed: () {},
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
