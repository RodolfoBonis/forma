import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaToast component — overlay notification playground.
GalleryComponent formaToastComponent() {
  return GalleryComponent(
    'FormaToast',
    docs: const ComponentDocs(
      description:
          'Transient, overlay-based notifications stacked at the top-right. '
          'FormaToast.show inserts a toast into the root overlay so it floats '
          'above dialogs and routes. Toasts stack, slide + fade in, '
          'auto-dismiss, and can be closed early.',
      props: [
        PropDoc('message', 'String', required: true),
        PropDoc('description', 'String?'),
        PropDoc(
          'variant',
          'FormaToastVariant',
          defaultValue: 'FormaToastVariant.info',
        ),
        PropDoc('duration', 'Duration', defaultValue: 'Duration(seconds: 4)'),
        PropDoc('actionLabel', 'String?'),
        PropDoc('onAction', 'VoidCallback?'),
      ],
      codeSnippet: '''
FormaToast.show(
  context,
  message: 'Projeto salvo',
  description: 'Suas alterações foram aplicadas.',
  variant: FormaToastVariant.success,
  actionLabel: 'Desfazer',
  onAction: () {},
);''',
    ),
    useCases: [
      UseCase('Variants', (context, k) {
        return Center(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final variant in FormaToastVariant.values)
                FormaButton.secondary(
                  label: variant.name,
                  onPressed: () => FormaToast.show(
                    context,
                    message: 'Toast ${variant.name}',
                    description: 'Mensagem de exemplo para ${variant.name}.',
                    variant: variant,
                    actionLabel: 'Desfazer',
                    onAction: () {},
                  ),
                ),
            ],
          ),
        );
      }),
    ],
  );
}
