import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTextField story — with knobs for label, hint, enabled, and error.
GalleryComponent formaTextFieldComponent() {
  return GalleryComponent(
    'FormaTextField',
    docs: const ComponentDocs(
      description:
          'A themed text field rendering an optional overline label above the '
          'input (not a floating label). Supports validation, prefix/suffix '
          'widgets, and obscured text for password entry.',
      props: [
        PropDoc('label', 'String?', description: 'Overline label above input.'),
        PropDoc(
          'hint',
          'String?',
          description: 'Placeholder shown when the field is empty.',
        ),
        PropDoc(
          'validator',
          'String? Function(String?)?',
          description: 'Returns an error string or null.',
        ),
        PropDoc('prefix', 'Widget?', description: 'Widget before the input.'),
        PropDoc('suffix', 'Widget?', description: 'Widget after the input.'),
        PropDoc(
          'enabled',
          'bool',
          defaultValue: 'true',
          description: 'Whether the field accepts input.',
        ),
        PropDoc(
          'obscureText',
          'bool',
          defaultValue: 'false',
          description: 'Obscures text (e.g. for passwords).',
        ),
      ],
      codeSnippet: '''
FormaTextField(
  label: 'EMAIL',
  hint: 'nome@email.com',
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.stringOrNull(label: 'Label', initialValue: 'EMAIL');
        final hint = k.stringOrNull(
          label: 'Hint',
          initialValue: 'nome@email.com',
        );
        final enabled = k.boolean(label: 'Enabled', initialValue: true);
        final showError = k.boolean(label: 'Show Error', initialValue: false);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaTextField(
            label: label,
            hint: hint,
            enabled: enabled,
            validator: showError ? (_) => 'Campo obrigatorio' : null,
          ),
        );
      }),
    ],
  );
}
