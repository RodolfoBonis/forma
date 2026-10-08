import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaKbd component — keycap chip playground.
GalleryComponent formaKbdComponent() {
  return GalleryComponent(
    'FormaKbd',
    docs: const ComponentDocs(
      description:
          'A small keycap chip that renders a keyboard shortcut (e.g. ⌘K, '
          'Esc). Used inside menus and the command palette to hint at '
          'shortcuts.',
      props: [
        PropDoc(
          'keys',
          'String',
          required: true,
          description: 'Shortcut text.',
        ),
      ],
      codeSnippet: "FormaKbd('⌘K')",
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final keys = k.string(label: 'Keys', initialValue: '⌘K');
        return Center(child: FormaKbd(keys));
      }),
      UseCase('Examples', (context, k) {
        return const Center(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FormaKbd('⌘K'),
              FormaKbd('Esc'),
              FormaKbd('Enter'),
              FormaKbd('Ctrl+S'),
              FormaKbd('⇧⌘P'),
            ],
          ),
        );
      }),
    ],
  );
}
