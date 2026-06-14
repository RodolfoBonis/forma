import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

/// FormaStatTile story.
GalleryComponent formaStatTileComponent() {
  return GalleryComponent(
    'FormaStatTile',
    docs: const ComponentDocs(
      description:
          'A compact metric tile with a colored icon, a large value, and a '
          'label. Used for dashboard stats such as streaks, completed counts, '
          'or pending items.',
      props: [
        PropDoc(
          'value',
          'String',
          required: true,
          description: 'The prominent metric value (e.g. "12").',
        ),
        PropDoc(
          'label',
          'String',
          required: true,
          description: 'Caption shown beneath the value.',
        ),
        PropDoc(
          'icon',
          'IconData',
          required: true,
          description: 'Leading icon.',
        ),
        PropDoc(
          'color',
          'Color?',
          description: 'Icon tint. Defaults to the primary brand color.',
        ),
        PropDoc('width', 'double?', description: 'Fixed width.'),
      ],
      codeSnippet: '''
FormaStatTile(
  value: '12',
  label: 'rótulo',
  icon: Icons.local_fire_department,
  color: DominusColors.brass,
)''',
    ),
    useCases: [
      UseCase('Row of stats', (context, k) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: FormaStatTile(
                    value: '12',
                    label: 'rótulo',
                    icon: Icons.local_fire_department,
                    color: DominusColors.brass,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FormaStatTile(
                    value: '12',
                    label: 'rótulo',
                    icon: Icons.check_circle_outline,
                    color: DominusColors.success,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FormaStatTile(
                    value: '12',
                    label: 'rótulo',
                    icon: Icons.schedule,
                    color: DominusColors.info,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ],
  );
}
