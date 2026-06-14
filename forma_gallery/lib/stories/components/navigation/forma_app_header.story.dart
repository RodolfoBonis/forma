import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaAppHeader story — all variants.
GalleryComponent formaAppHeaderComponent() {
  return GalleryComponent(
    'FormaAppHeader',
    docs: const ComponentDocs(
      description:
          'Application header bar with a back-button variant, a title-only '
          'variant, or a fully custom leading widget. Implements '
          'PreferredSizeWidget so it can be used as an AppBar.',
      props: [
        PropDoc('title', 'String?', description: 'Centered header title.'),
        PropDoc(
          'variant',
          'FormaHeaderVariant',
          defaultValue: 'withBack',
          description: 'Header layout variant.',
        ),
        PropDoc(
          'onBack',
          'VoidCallback?',
          description: 'Back tap handler for the withBack variant.',
        ),
        PropDoc(
          'leading',
          'Widget?',
          description: 'Custom leading widget for the custom variant.',
        ),
        PropDoc(
          'trailing',
          'Widget?',
          description: 'Optional trailing widget on the right.',
        ),
      ],
      codeSnippet: '''
FormaAppHeader(
  title: 'Detalhes',
  variant: FormaHeaderVariant.withBack,
  onBack: () {},
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final title = k.string(label: 'Title', initialValue: 'Detalhes');
        final variant = k.object.dropdown<FormaHeaderVariant>(
          label: 'Variant',
          options: FormaHeaderVariant.values,
          labelBuilder: (v) => v.name,
          initialOption: FormaHeaderVariant.withBack,
        );
        final showTrailing = k.boolean(
          label: 'Show Trailing',
          initialValue: false,
        );

        return FormaAppHeader(
          title: title,
          variant: variant,
          onBack: () {},
          trailing: showTrailing ? const Icon(Icons.more_vert) : null,
        );
      }),
      UseCase('All Variants', (context, k) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FormaAppHeader(
              title: 'With Back',
              variant: FormaHeaderVariant.withBack,
            ),
            const SizedBox(height: 16),
            const FormaAppHeader(
              title: 'Title Only',
              variant: FormaHeaderVariant.titleOnly,
            ),
            const SizedBox(height: 16),
            FormaAppHeader(
              title: 'Custom Leading',
              variant: FormaHeaderVariant.custom,
              leading: const Icon(Icons.menu),
              trailing: const Icon(Icons.notifications_outlined),
            ),
          ],
        );
      }),
    ],
  );
}
