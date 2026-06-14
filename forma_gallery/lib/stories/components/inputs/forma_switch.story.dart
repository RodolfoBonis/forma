import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSwitch story.
GalleryComponent formaSwitchComponent() {
  return GalleryComponent(
    'FormaSwitch',
    docs: const ComponentDocs(
      description:
          'A themed on/off switch. The track uses the primary color when on '
          'and a muted surface when off; the thumb slides between the two '
          'states. A null onChanged disables the switch.',
      props: [
        PropDoc(
          'value',
          'bool',
          required: true,
          description: 'Whether the switch is on.',
        ),
        PropDoc(
          'onChanged',
          'ValueChanged<bool>?',
          required: true,
          description: 'Called with the new value; null disables the switch.',
        ),
        PropDoc(
          'semanticLabel',
          'String?',
          description: 'Optional accessibility label.',
        ),
      ],
      codeSnippet: '''
FormaSwitch(
  value: true,
  onChanged: (value) {},
)''',
    ),
    useCases: [
      UseCase('Interactive', (context, k) {
        var value = true;
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return FormaSwitch(
                value: value,
                onChanged: (v) => setState(() => value = v),
              );
            },
          ),
        );
      }),
      UseCase('States', (context, k) {
        return const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormaSwitch(value: true, onChanged: _noop),
              SizedBox(width: 24),
              FormaSwitch(value: false, onChanged: _noop),
              SizedBox(width: 24),
              FormaSwitch(value: true, onChanged: null),
            ],
          ),
        );
      }),
    ],
  );
}

void _noop(bool _) {}
