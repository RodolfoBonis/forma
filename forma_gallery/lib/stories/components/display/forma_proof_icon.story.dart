import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaProofIcon story.
GalleryComponent formaProofIconComponent() {
  return GalleryComponent(
    'FormaProofIcon',
    docs: const ComponentDocs(
      description:
          'A small square icon badge indicating a proof / evidence type '
          '(photo, text, or check). Surface and outline colors come from the '
          'active theme.',
      props: [
        PropDoc(
          'type',
          'FormaProofType',
          required: true,
          description: 'The proof type, controlling which icon is shown.',
        ),
        PropDoc(
          'color',
          'Color?',
          description: 'Optional icon tint. Defaults to muted text color.',
        ),
        PropDoc(
          'size',
          'double',
          defaultValue: '32',
          description: 'Side length of the square badge.',
        ),
      ],
      codeSnippet: 'FormaProofIcon(type: FormaProofType.foto)',
    ),
    useCases: [
      UseCase('All types', (context, k) {
        return const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormaProofIcon(type: FormaProofType.foto),
              SizedBox(width: 12),
              FormaProofIcon(type: FormaProofType.texto),
              SizedBox(width: 12),
              FormaProofIcon(type: FormaProofType.check),
            ],
          ),
        );
      }),
    ],
  );
}
