import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaPersonChip story — active and inactive states.
WidgetbookComponent formaPersonChipComponent() {
  return WidgetbookComponent(
    name: 'FormaPersonChip',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final name = context.knobs.string(label: 'Name', initialValue: 'Ana');
          final isActive = context.knobs.boolean(
            label: 'Active',
            initialValue: true,
          );

          return Center(
            child: FormaPersonChip(
              initial: name.isNotEmpty ? name[0] : 'A',
              name: name,
              color: PfPersonColors.ana,
              surfaceColor: PfPersonColors.anaSurface,
              isActive: isActive,
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All People',
        builder: (context) {
          return Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const FormaPersonChip(
                  initial: 'A',
                  name: 'Ana',
                  color: PfPersonColors.ana,
                  surfaceColor: PfPersonColors.anaSurface,
                  isActive: true,
                ),
                const FormaPersonChip(
                  initial: 'D',
                  name: 'Diogenes',
                  color: PfPersonColors.diogenes,
                  surfaceColor: PfPersonColors.diogenesSurface,
                  isActive: true,
                ),
                const FormaPersonChip(
                  initial: 'A',
                  name: 'Augusto',
                  color: PfPersonColors.augusto,
                  surfaceColor: PfPersonColors.augustoSurface,
                  isActive: false,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
