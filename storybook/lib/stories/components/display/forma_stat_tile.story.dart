import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaStatTile story.
WidgetbookComponent formaStatTileComponent() {
  return WidgetbookComponent(
    name: 'FormaStatTile',
    useCases: [
      WidgetbookUseCase(
        name: 'Row of stats',
        builder: (context) {
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
        },
      ),
    ],
  );
}
