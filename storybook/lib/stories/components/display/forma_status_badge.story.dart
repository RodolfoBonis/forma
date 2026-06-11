import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaStatusBadge story.
WidgetbookComponent formaStatusBadgeComponent() {
  return WidgetbookComponent(
    name: 'FormaStatusBadge',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final variant = context.knobs.object.dropdown<FormaStatusVariant>(
            label: 'Status',
            options: FormaStatusVariant.values,
            labelBuilder: (v) => v.label,
            initialOption: FormaStatusVariant.pendente,
          );
          return Center(child: FormaStatusBadge(variant: variant));
        },
      ),
      WidgetbookUseCase(
        name: 'All statuses',
        builder: (context) {
          return Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final v in FormaStatusVariant.values)
                  FormaStatusBadge(variant: v),
              ],
            ),
          );
        },
      ),
    ],
  );
}
