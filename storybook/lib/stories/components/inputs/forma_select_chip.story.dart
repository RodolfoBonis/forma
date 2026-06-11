import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaSelectChip story.
WidgetbookComponent formaSelectChipComponent() {
  return WidgetbookComponent(
    name: 'FormaSelectChip',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final label = context.knobs.string(
            label: 'Label',
            initialValue: 'Opção',
          );
          final withIcon = context.knobs.boolean(label: 'With icon');
          var selected = true;
          return Center(
            child: StatefulBuilder(
              builder: (context, setState) {
                return FormaSelectChip(
                  label: label,
                  selected: selected,
                  icon: withIcon ? Icons.flag_outlined : null,
                  onSelected: (v) => setState(() => selected = v),
                );
              },
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'On / Off',
        builder: (context) {
          return const Center(
            child: Wrap(
              spacing: 12,
              children: [
                FormaSelectChip(
                  label: 'Selecionada',
                  selected: true,
                  onSelected: _noop,
                  icon: Icons.repeat,
                ),
                FormaSelectChip(
                  label: 'Não selecionada',
                  selected: false,
                  onSelected: _noop,
                  icon: Icons.calendar_today,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

void _noop(bool _) {}
