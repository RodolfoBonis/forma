import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaTextField story — with knobs for label, hint, enabled, and error.
WidgetbookComponent formaTextFieldComponent() {
  return WidgetbookComponent(
    name: 'FormaTextField',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final label = context.knobs.stringOrNull(
            label: 'Label',
            initialValue: 'EMAIL',
          );
          final hint = context.knobs.stringOrNull(
            label: 'Hint',
            initialValue: 'nome@email.com',
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );
          final showError = context.knobs.boolean(
            label: 'Show Error',
            initialValue: false,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaTextField(
              label: label,
              hint: hint,
              enabled: enabled,
              validator: showError ? (_) => 'Campo obrigatorio' : null,
            ),
          );
        },
      ),
    ],
  );
}
