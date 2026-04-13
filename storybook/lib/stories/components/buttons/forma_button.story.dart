import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaButton story — all variants with knobs.
WidgetbookComponent formaButtonComponent() {
  return WidgetbookComponent(
    name: 'FormaButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final label = context.knobs.string(
            label: 'Label',
            initialValue: 'Confirmar',
          );
          final variant = context.knobs.object.dropdown<FormaButtonVariant>(
            label: 'Variant',
            options: FormaButtonVariant.values,
            labelBuilder: (v) => v.name,
            initialOption: FormaButtonVariant.primary,
          );
          final isLoading = context.knobs.boolean(
            label: 'Loading',
            initialValue: false,
          );
          final enabled = context.knobs.boolean(
            label: 'Enabled',
            initialValue: true,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaButton(
              label: label,
              variant: enabled ? variant : FormaButtonVariant.disabled,
              isLoading: isLoading,
              onPressed: () {},
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
                for (final variant in FormaButtonVariant.values) ...[
                  Text(variant.name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  FormaButton(
                    label: 'Button ${variant.name}',
                    variant: variant,
                    onPressed: variant == FormaButtonVariant.disabled ? null : () {},
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
