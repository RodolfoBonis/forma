import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaWhatsAppPreview story — WhatsApp message preview.
WidgetbookComponent formaWhatsAppPreviewComponent() {
  return WidgetbookComponent(
    name: 'FormaWhatsAppPreview',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final message = context.knobs.string(
            label: 'Message',
            initialValue:
                'Rodolfo te convidou! Clique: plantaofacil.app/convite/xK9pQ',
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaWhatsAppPreview(message: message),
          );
        },
      ),
    ],
  );
}
