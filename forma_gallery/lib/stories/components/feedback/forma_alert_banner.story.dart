import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaAlertBanner story — all severity variants.
GalleryComponent formaAlertBannerComponent() {
  return GalleryComponent(
    'FormaAlertBanner',
    docs: const ComponentDocs(
      description:
          'Tinted message strip with an optional leading icon, used to '
          'communicate success, warning, error, info, or urgency states.',
      props: [
        PropDoc(
          'message',
          'String',
          required: true,
          description: 'The alert message text.',
        ),
        PropDoc(
          'variant',
          'FormaAlertVariant',
          required: true,
          description: 'Severity variant controlling colors.',
        ),
        PropDoc('icon', 'Widget?', description: 'Optional leading icon.'),
      ],
      codeSnippet: '''
FormaAlertBanner(
  message: 'Operacao realizada com sucesso!',
  variant: FormaAlertVariant.success,
  icon: const Icon(Icons.check_circle_outline, size: 20),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final message = k.string(
          label: 'Message',
          initialValue: 'Operacao realizada com sucesso!',
        );
        final variant = k.object.dropdown<FormaAlertVariant>(
          label: 'Variant',
          options: FormaAlertVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaAlertVariant.success,
        );
        final showIcon = k.boolean(label: 'Show Icon', initialValue: true);

        final icon = showIcon ? Icon(_iconFor(variant), size: 20) : null;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: FormaAlertBanner(
            message: message,
            variant: variant,
            icon: icon,
          ),
        );
      }),
      UseCase('All Variants', (context, k) {
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
      }),
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
