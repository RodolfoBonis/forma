import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaAlertBanner story — all severity variants.
WidgetbookComponent formaAlertBannerComponent() {
  return WidgetbookComponent(
    name: 'FormaAlertBanner',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final message = context.knobs.string(
            label: 'Message',
            initialValue: 'Operacao realizada com sucesso!',
          );
          final variant = context.knobs.object.dropdown<FormaAlertVariant>(
            label: 'Variant',
            options: FormaAlertVariant.values,
            labelBuilder: (v) => v.name,
            initialOption: FormaAlertVariant.success,
          );
          final showIcon = context.knobs.boolean(
            label: 'Show Icon',
            initialValue: true,
          );

          final icon = showIcon ? Icon(_iconFor(variant), size: 20) : null;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaAlertBanner(
              message: message,
              variant: variant,
              icon: icon,
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
              children: [
                for (final variant in FormaAlertVariant.values) ...[
                  FormaAlertBanner(
                    message: 'Alert: ${variant.name}',
                    variant: variant,
                    icon: Icon(_iconFor(variant), size: 20),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          );
        },
      ),
    ],
  );
}

IconData _iconFor(FormaAlertVariant variant) {
  return switch (variant) {
    FormaAlertVariant.success => Icons.check_circle_outline,
    FormaAlertVariant.warning => Icons.warning_amber_outlined,
    FormaAlertVariant.error => Icons.error_outline,
    FormaAlertVariant.info => Icons.info_outline,
    FormaAlertVariant.urgency => Icons.priority_high,
  };
}
