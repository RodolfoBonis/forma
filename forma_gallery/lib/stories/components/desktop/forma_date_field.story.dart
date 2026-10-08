import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaDateField component — compact desktop date picker field.
GalleryComponent formaDateFieldComponent() {
  return GalleryComponent(
    'FormaDateField',
    docs: const ComponentDocs(
      description:
          'Read-only field that opens the themed date picker on tap, shows the '
          'value as dd/MM/yyyy, a calendar icon and an optional clear button.',
      props: [
        PropDoc('value', 'DateTime?'),
        PropDoc('onChanged', 'ValueChanged<DateTime?>', required: true),
        PropDoc('label', 'String?'),
        PropDoc('clearable', 'bool', defaultValue: 'true'),
        PropDoc('errorText', 'String?'),
      ],
      codeSnippet: '''
FormaDateField(
  label: 'Nascimento',
  value: birthday,
  onChanged: (d) => setState(() => birthday = d),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final error = k.boolean(label: 'Error', initialValue: false);
        final enabled = k.boolean(label: 'Enabled', initialValue: true);
        return _DateDemo(error: error, enabled: enabled);
      }),
    ],
  );
}

class _DateDemo extends StatefulWidget {
  const _DateDemo({required this.error, required this.enabled});

  final bool error;
  final bool enabled;

  @override
  State<_DateDemo> createState() => _DateDemoState();
}

class _DateDemoState extends State<_DateDemo> {
  DateTime? _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 240,
          child: FormaDateField(
            label: 'Nascimento',
            value: _value,
            enabled: widget.enabled,
            errorText: widget.error ? 'Data inválida' : null,
            onChanged: (d) => setState(() => _value = d),
          ),
        ),
      ),
    );
  }
}
