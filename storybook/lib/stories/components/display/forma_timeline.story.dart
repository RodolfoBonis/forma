import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaTimeline story — event timeline with steps.
WidgetbookComponent formaTimelineComponent() {
  return WidgetbookComponent(
    name: 'FormaTimeline',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final title = context.knobs.string(
            label: 'Title',
            initialValue: 'O que acontece agora',
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaTimeline(
              title: title,
              steps: const [
                FormaTimelineStep(
                  label: 'Solicitacao enviada',
                  timing: 'Imediato',
                ),
                FormaTimelineStep(
                  label: 'Outra pessoa recebe notificacao',
                  timing: 'Em segundos',
                ),
                FormaTimelineStep(
                  label: 'Aprovacao confirmada',
                  timing: 'Apos resposta',
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
