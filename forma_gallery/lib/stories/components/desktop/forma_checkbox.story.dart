import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaCheckbox component — compact desktop checkbox with label/description.
GalleryComponent formaCheckboxComponent() {
  return GalleryComponent(
    'FormaCheckbox',
    docs: const ComponentDocs(
      description:
          'Compact custom checkbox with an animated check, optional label and '
          'description. The whole row is clickable, focusable and '
          'keyboard-operable (Space / Enter).',
      props: [
        PropDoc('value', 'bool', required: true),
        PropDoc('onChanged', 'ValueChanged<bool>?', required: true),
        PropDoc('label', 'String?'),
        PropDoc('description', 'String?'),
        PropDoc('enabled', 'bool', defaultValue: 'true'),
      ],
      codeSnippet: '''
FormaCheckbox(
  value: accepted,
  onChanged: (v) => setState(() => accepted = v),
  label: 'Aceito os termos',
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.string(
          label: 'Label',
          initialValue: 'Aceito os termos',
        );
        final description = k.stringOrNull(label: 'Description');
        final enabled = k.boolean(label: 'Enabled', initialValue: true);
        return _CheckboxDemo(
          label: label,
          description: description,
          enabled: enabled,
        );
      }),
    ],
  );
}

class _CheckboxDemo extends StatefulWidget {
  const _CheckboxDemo({
    required this.label,
    required this.description,
    required this.enabled,
  });

  final String label;
  final String? description;
  final bool enabled;

  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: FormaCheckbox(
          value: _value,
          enabled: widget.enabled,
          label: widget.label,
          description: widget.description,
          onChanged: (v) => setState(() => _value = v),
        ),
      ),
    );
  }
}
