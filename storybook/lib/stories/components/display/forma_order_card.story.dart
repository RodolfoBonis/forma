import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaOrderCard story.
WidgetbookComponent formaOrderCardComponent() {
  return WidgetbookComponent(
    name: 'FormaOrderCard',
    useCases: [
      WidgetbookUseCase(
        name: 'Task order',
        builder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FormaOrderCard(
                status: const FormaBadge(
                  label: 'Pendente',
                  variant: FormaBadgeVariant.pendente,
                ),
                timeLabel: 'Hoje · 21:00',
                title: 'Beba 2L de água',
                description:
                    'Registre com foto da garrafa vazia antes de dormir.',
                tags: const [
                  FormaSelectChip(
                    label: 'Foto',
                    selected: false,
                    onSelected: _noop,
                    icon: Icons.photo_camera_outlined,
                  ),
                  FormaSelectChip(
                    label: 'Diária',
                    selected: false,
                    onSelected: _noop,
                    icon: Icons.repeat,
                  ),
                ],
                action: FormaButton.primary(
                  label: 'Marcar feita',
                  onPressed: () {},
                ),
              ),
            ),
          );
        },
      ),
    ],
  );
}

void _noop(bool _) {}
