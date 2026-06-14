import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaUrgencyHeader story — urgency notification banner.
GalleryComponent formaUrgencyHeaderComponent() {
  return GalleryComponent(
    'FormaUrgencyHeader',
    docs: const ComponentDocs(
      description:
          'Prominent banner with a title and optional subtitle on an '
          'urgency-colored background to draw immediate attention.',
      props: [
        PropDoc(
          'title',
          'String',
          required: true,
          description: 'The main urgency message.',
        ),
        PropDoc(
          'subtitle',
          'String?',
          description: 'Optional secondary message with extra context.',
        ),
      ],
      codeSnippet: '''
FormaUrgencyHeader(
  title: 'Solicitacao de troca recebida',
  subtitle: 'Responda para confirmar o acordo.',
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final title = k.string(
          label: 'Title',
          initialValue: 'Solicitacao de troca recebida',
        );
        final subtitle = k.stringOrNull(
          label: 'Subtitle',
          initialValue: 'Responda para confirmar o acordo.',
        );

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaUrgencyHeader(title: title, subtitle: subtitle),
        );
      }),
      UseCase('Variants', (context, k) {
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
      }),
    ],
  );
}
