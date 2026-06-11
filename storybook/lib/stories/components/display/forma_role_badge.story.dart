import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaRoleBadge story.
WidgetbookComponent formaRoleBadgeComponent() {
  return WidgetbookComponent(
    name: 'FormaRoleBadge',
    useCases: [
      WidgetbookUseCase(
        name: 'Dom / Sub',
        builder: (context) {
          return const Center(
            child: Wrap(
              spacing: 12,
              children: [
                FormaRoleBadge(label: 'Dom', color: DominusColors.roleDom),
                FormaRoleBadge(label: 'Sub', color: DominusColors.roleSub),
              ],
            ),
          );
        },
      ),
    ],
  );
}
