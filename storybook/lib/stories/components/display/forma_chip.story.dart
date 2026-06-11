import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaChip story.
WidgetbookComponent formaChipComponent() {
  return WidgetbookComponent(
    name: 'FormaChip',
    useCases: [
      WidgetbookUseCase(
        name: 'Tags',
        builder: (context) {
          return const Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FormaChip(label: 'Foto', icon: Icons.photo_camera_outlined),
                FormaChip(label: 'Texto', icon: Icons.notes),
                FormaChip(label: 'Check', icon: Icons.check),
                FormaChip(label: 'Diária', icon: Icons.repeat),
                FormaChip(
                  label: 'Alta',
                  icon: Icons.flag_outlined,
                  color: DominusColors.brass,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
