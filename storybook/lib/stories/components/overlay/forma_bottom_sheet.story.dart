import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaBottomSheet story — draggable bottom sheet modal.
WidgetbookComponent formaBottomSheetComponent() {
  return WidgetbookComponent(
    name: 'FormaBottomSheet',
    useCases: [
      WidgetbookUseCase(
        name: 'Demo',
        builder: (context) {
          final title = context.knobs.stringOrNull(
            label: 'Title',
            initialValue: 'Titulo da acao',
          );
          final isDismissible = context.knobs.boolean(
            label: 'Dismissible',
            initialValue: true,
          );

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: FormaButton(
                label: 'Open Bottom Sheet',
                variant: FormaButtonVariant.primary,
                onPressed: () {
                  FormaBottomSheet.show(
                    context: context,
                    title: title,
                    isDismissible: isDismissible,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalhe do plantao selecionado',
                            style: FormaTypography.body14.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 12),
                          _infoRow('Data', '8 de abril'),
                          const SizedBox(height: 8),
                          _infoRow('Horario', '08:00 - 20:00'),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: FormaButton(
                              label: 'Acao principal',
                              variant: FormaButtonVariant.primary,
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    ],
  );
}

Widget _infoRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: FormaTypography.body14),
      Text(value, style: FormaTypography.body14),
    ],
  );
}
