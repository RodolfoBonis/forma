import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaTimePicker story — time input field.
WidgetbookComponent formaTimePickerComponent() {
  return WidgetbookComponent(
    name: 'FormaTimePicker',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final label = context.knobs.stringOrNull(
            label: 'Label',
            initialValue: 'Horario',
          );
          final hasValue = context.knobs.boolean(
            label: 'Has Value',
            initialValue: true,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaTimePicker(
              label: label,
              value: hasValue ? const TimeOfDay(hour: 8, minute: 0) : null,
              onChanged: (_) {},
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'States',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('With label + value',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                FormaTimePicker(
                  label: 'Inicio',
                  value: const TimeOfDay(hour: 8, minute: 0),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 24),
                const Text('With label, no value (placeholder)',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                FormaTimePicker(
                  label: 'Fim',
                  onChanged: (_) {},
                ),
                const SizedBox(height: 24),
                const Text('No label',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                FormaTimePicker(
                  value: const TimeOfDay(hour: 20, minute: 0),
                  onChanged: (_) {},
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
