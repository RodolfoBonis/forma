import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaBadge story — all variants.
WidgetbookComponent formaBadgeComponent() {
  return WidgetbookComponent(
    name: 'FormaBadge',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final label = context.knobs.string(
            label: 'Label',
            initialValue: 'Confirmada',
          );
          final variant = context.knobs.object.dropdown<FormaBadgeVariant>(
            label: 'Variant',
            options: FormaBadgeVariant.values,
            labelBuilder: (v) => v.name,
            initialOption: FormaBadgeVariant.confirmada,
          );

          return Center(
            child: FormaBadge(label: label, variant: variant),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All Variants',
        builder: (context) {
          return Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final variant in FormaBadgeVariant.values)
                  FormaBadge(label: variant.name, variant: variant),
              ],
            ),
          );
        },
      ),
    ],
  );
}
