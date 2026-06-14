import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaIconButton story — icon button with touch target.
GalleryComponent formaIconButtonComponent() {
  return GalleryComponent(
    'FormaIconButton',
    docs: const ComponentDocs(
      description:
          'A simple icon button with proper touch target sizing (48x48 '
          'minimum). Uses the theme muted text color as the default icon '
          'color.',
      props: [
        PropDoc(
          'icon',
          'Widget',
          required: true,
          description: 'The icon widget to display.',
        ),
        PropDoc('onPressed', 'VoidCallback?', description: 'Tap callback.'),
        PropDoc(
          'color',
          'Color?',
          description: 'Override color; defaults to theme textMuted.',
        ),
        PropDoc(
          'size',
          'double',
          defaultValue: '24',
          description: 'Icon size in logical pixels.',
        ),
      ],
      codeSnippet: '''
FormaIconButton(
  icon: const Icon(Icons.arrow_back),
  onPressed: () {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final icon = k.object.dropdown<IconData>(
          label: 'Icon',
          options: _iconOptions.values.toList(),
          labelBuilder: (v) =>
              _iconOptions.entries.firstWhere((e) => e.value == v).key,
          initialOption: Icons.arrow_back,
        );
        final size = k.double.slider(
          label: 'Size',
          initialValue: 24,
          min: 16,
          max: 48,
        );

        return Center(
          child: FormaIconButton(
            icon: Icon(icon),
            size: size,
            onPressed: () {},
          ),
        );
      }),
      UseCase('Gallery', (context, k) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              for (final entry in _iconOptions.entries)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormaIconButton(icon: Icon(entry.value), onPressed: () {}),
                    const SizedBox(height: 4),
                    Text(
                      entry.key,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
            ],
          ),
        );
      }),
    ],
  );
}

const _iconOptions = <String, IconData>{
  'arrow_back': Icons.arrow_back,
  'close': Icons.close,
  'more_vert': Icons.more_vert,
  'settings': Icons.settings,
  'edit': Icons.edit,
  'delete': Icons.delete_outline,
  'share': Icons.share,
  'notifications': Icons.notifications_outlined,
};
