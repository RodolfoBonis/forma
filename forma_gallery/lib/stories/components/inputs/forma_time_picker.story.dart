import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTimePicker story — time input field.
GalleryComponent formaTimePickerComponent() {
  return GalleryComponent(
    'FormaTimePicker',
    docs: const ComponentDocs(
      description:
          'A styled time picker field that opens the platform time picker on '
          'tap. Displays the selected value formatted as HH:mm, or a '
          'placeholder when no time is selected.',
      props: [
        PropDoc('label', 'String?', description: 'Overline label above field.'),
        PropDoc('value', 'TimeOfDay?', description: 'Currently selected time.'),
        PropDoc(
          'onChanged',
          'ValueChanged<TimeOfDay>?',
          description: 'Called when the user picks a new time.',
        ),
      ],
      codeSnippet: '''
FormaTimePicker(
  label: 'Horario',
  value: const TimeOfDay(hour: 8, minute: 0),
  onChanged: (time) {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final label = k.stringOrNull(label: 'Label', initialValue: 'Horario');
        final hasValue = k.boolean(label: 'Has Value', initialValue: true);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaTimePicker(
            label: label,
            value: hasValue ? const TimeOfDay(hour: 8, minute: 0) : null,
            onChanged: (_) {},
          ),
        );
      }),
      UseCase('States', (context, k) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'With label + value',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              FormaTimePicker(
                label: 'Inicio',
                value: const TimeOfDay(hour: 8, minute: 0),
                onChanged: (_) {},
              ),
              const SizedBox(height: 24),
              const Text(
                'With label, no value (placeholder)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              FormaTimePicker(label: 'Fim', onChanged: (_) {}),
              const SizedBox(height: 24),
              const Text(
                'No label',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              FormaTimePicker(
                value: const TimeOfDay(hour: 20, minute: 0),
                onChanged: (_) {},
              ),
            ],
          ),
        );
      }),
    ],
  );
}
