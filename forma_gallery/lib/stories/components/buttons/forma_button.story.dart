import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaButton component — playground with knobs + all variants.
GalleryComponent formaButtonComponent() {
  return GalleryComponent(
    'FormaButton',
    docs: const ComponentDocs(
      description:
          'Action button with semantic variants (primary, secondary, danger, '
          'ghost, disabled) and a loading state. Use the most prominent variant '
          'for the single primary action on a screen.',
      props: [
        PropDoc('label', 'String', required: true, description: 'Button text.'),
        PropDoc(
          'onPressed',
          'VoidCallback?',
          description: 'Tap handler; null disables the button.',
        ),
        PropDoc(
          'variant',
          'FormaButtonVariant',
          defaultValue: 'primary',
          description: 'Visual style of the button.',
        ),
        PropDoc(
          'isLoading',
          'bool',
          defaultValue: 'false',
          description: 'Shows a spinner and blocks taps.',
        ),
        PropDoc('icon', 'Widget?', description: 'Optional leading icon.'),
        PropDoc(
          'width',
          'double?',
          description: 'Fixed width; defaults to fill.',
        ),
      ],
      codeSnippet: '''
FormaButton(
  label: 'Confirmar',
  variant: FormaButtonVariant.primary,
  onPressed: () {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(label: 'Label', initialValue: 'Confirmar');
        final variant = k.object.dropdown<FormaButtonVariant>(
          label: 'Variant',
          options: FormaButtonVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaButtonVariant.primary,
        );
        final isLoading = k.boolean(label: 'Loading', initialValue: false);
        final enabled = k.boolean(label: 'Enabled', initialValue: true);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaButton(
            label: label,
            variant: enabled ? variant : FormaButtonVariant.disabled,
            isLoading: isLoading,
            onPressed: () {},
          ),
        );
      }),
      UseCase('All Variants', (context, k) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final variant in FormaButtonVariant.values) ...[
                Text(
                  variant.name,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                FormaButton(
                  label: 'Button ${variant.name}',
                  variant: variant,
                  onPressed: variant == FormaButtonVariant.disabled
                      ? null
                      : () {},
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
