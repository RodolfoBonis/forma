import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaCard story — all variants.
WidgetbookComponent formaCardComponent() {
  return WidgetbookComponent(
    name: 'FormaCard',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final variant = context.knobs.object.dropdown<FormaCardVariant>(
            label: 'Variant',
            options: FormaCardVariant.values,
            labelBuilder: (v) => v.name,
            initialOption: FormaCardVariant.basic,
          );
          final selected = context.knobs.boolean(
            label: 'Selected (shift only)',
            initialValue: false,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaCard(
              variant: variant,
              selected: selected,
              accentColor: PfColors.primary700,
              selectedColor: PfColors.primary700,
              child: const Text('Card content goes here'),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All Variants',
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final variant in FormaCardVariant.values) ...[
                  Text(variant.name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  FormaCard(
                    variant: variant,
                    accentColor: PfColors.primary700,
                    child: Text(
                      'Card variant: ${variant.name}',
                      style: TextStyle(
                        color: variant == FormaCardVariant.heroDark
                            ? Colors.white
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ],
            ),
          );
        },
      ),
    ],
  );
}
