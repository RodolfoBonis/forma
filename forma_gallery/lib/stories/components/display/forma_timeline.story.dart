import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTimeline story — event timeline with steps.
GalleryComponent formaTimelineComponent() {
  return GalleryComponent(
    'FormaTimeline',
    docs: const ComponentDocs(
      description:
          'A titled event timeline: a vertical list of steps, each with a '
          'bullet indicator, a label, and a right-aligned timing.',
      props: [
        PropDoc(
          'title',
          'String',
          required: true,
          description: 'Heading shown above the step list.',
        ),
        PropDoc(
          'steps',
          'List<FormaTimelineStep>',
          required: true,
          description: 'Ordered steps; each has a label and a timing.',
        ),
      ],
      codeSnippet: '''
FormaTimeline(
  title: 'O que acontece agora',
  steps: const [
    FormaTimelineStep(label: 'Solicitacao enviada', timing: 'Imediato'),
    FormaTimelineStep(label: 'Aprovacao confirmada', timing: 'Apos resposta'),
  ],
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final title = k.string(
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
      }),
    ],
  );
}
