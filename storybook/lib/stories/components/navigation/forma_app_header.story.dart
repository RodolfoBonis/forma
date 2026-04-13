import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaAppHeader story — all variants.
WidgetbookComponent formaAppHeaderComponent() {
  return WidgetbookComponent(
    name: 'FormaAppHeader',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final title = context.knobs.string(
            label: 'Title',
            initialValue: 'Detalhes',
          );
          final variant = context.knobs.object.dropdown<FormaHeaderVariant>(
            label: 'Variant',
            options: FormaHeaderVariant.values,
            labelBuilder: (v) => v.name,
            initialOption: FormaHeaderVariant.withBack,
          );
          final showTrailing = context.knobs.boolean(
            label: 'Show Trailing',
            initialValue: false,
          );

          return FormaAppHeader(
            title: title,
            variant: variant,
            onBack: () {},
            trailing: showTrailing ? const Icon(Icons.more_vert) : null,
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All Variants',
        builder: (context) {
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
        },
      ),
    ],
  );
}
