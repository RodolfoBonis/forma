import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaUrgencyHeader story — urgency notification banner.
WidgetbookComponent formaUrgencyHeaderComponent() {
  return WidgetbookComponent(
    name: 'FormaUrgencyHeader',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final title = context.knobs.string(
            label: 'Title',
            initialValue: 'Solicitacao de troca recebida',
          );
          final subtitle = context.knobs.stringOrNull(
            label: 'Subtitle',
            initialValue: 'Responda para confirmar o acordo.',
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaUrgencyHeader(title: title, subtitle: subtitle),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Variants',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'With subtitle',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const FormaUrgencyHeader(
                  title: 'Solicitacao de troca recebida',
                  subtitle: 'Responda para confirmar o acordo.',
                ),
                const SizedBox(height: 24),
                const Text(
                  'Title only',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                const FormaUrgencyHeader(
                  title: 'Plantao precisa de cobertura urgente',
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
