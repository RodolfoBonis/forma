import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaLoading story — adaptive loading indicator.
GalleryComponent formaLoadingComponent() {
  return GalleryComponent(
    'FormaLoading',
    docs: const ComponentDocs(
      description:
          'Centered adaptive loading indicator using '
          'CircularProgressIndicator.adaptive with the theme primary color.',
      props: [
        PropDoc(
          'size',
          'double',
          defaultValue: '24',
          description: 'Diameter of the indicator.',
        ),
        PropDoc(
          'strokeWidth',
          'double',
          defaultValue: '2.5',
          description: 'Stroke width of the circular indicator.',
        ),
        PropDoc(
          'color',
          'Color?',
          description: 'Color override; defaults to the theme primary.',
        ),
      ],
      codeSnippet: '''
FormaLoading(size: 24, strokeWidth: 2.5)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final size = k.double.slider(
          label: 'Size',
          initialValue: 24,
          min: 16,
          max: 64,
        );
        final strokeWidth = k.double.slider(
          label: 'Stroke Width',
          initialValue: 2.5,
          min: 1,
          max: 6,
        );

        return FormaLoading(size: size, strokeWidth: strokeWidth);
      }),
      UseCase('Sizes', (context, k) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (final size in [16.0, 24.0, 36.0, 48.0])
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormaLoading(size: size),
                    const SizedBox(height: 8),
                    Text(
                      '${size.toInt()}px',
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
