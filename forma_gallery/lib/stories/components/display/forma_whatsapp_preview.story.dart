import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaWhatsAppPreview story — WhatsApp message preview.
GalleryComponent formaWhatsAppPreviewComponent() {
  return GalleryComponent(
    'FormaWhatsAppPreview',
    docs: const ComponentDocs(
      description:
          'A mock WhatsApp conversation — green header plus a single message '
          'bubble — used to preview the copy of an outgoing invite or message.',
      props: [
        PropDoc(
          'message',
          'String',
          required: true,
          description: 'Text shown inside the message bubble.',
        ),
      ],
      codeSnippet: '''
FormaWhatsAppPreview(
  message: 'Rodolfo te convidou! Clique: plantaofacil.app/convite/xK9pQ',
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final message = k.string(
          label: 'Message',
          initialValue:
              'Rodolfo te convidou! Clique: plantaofacil.app/convite/xK9pQ',
        );

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaWhatsAppPreview(message: message),
        );
      }),
    ],
  );
}
