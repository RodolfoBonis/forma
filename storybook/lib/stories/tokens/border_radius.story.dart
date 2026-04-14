import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// Border radius story — visualizes the FormaRadius scale.
WidgetbookComponent borderRadiusComponent() {
  return WidgetbookComponent(
    name: 'Border Radius',
    useCases: [
      WidgetbookUseCase(
        name: 'Scale',
        builder: (context) => const _BorderRadiusScale(),
      ),
    ],
  );
}

class _BorderRadiusScale extends StatelessWidget {
  const _BorderRadiusScale();

  @override
  Widget build(BuildContext context) {
    const items = <(String, double)>[
      ('subtle (4)', FormaRadius.subtle),
      ('input (8)', FormaRadius.input),
      ('small (12)', FormaRadius.small),
      ('card (16)', FormaRadius.card),
      ('button (18)', FormaRadius.button),
      ('cardLg (20)', FormaRadius.cardLg),
      ('large (22)', FormaRadius.large),
      ('chip (24)', FormaRadius.chip),
      ('sheet (28)', FormaRadius.sheet),
      ('xLarge (40)', FormaRadius.xlarge),
      ('appIcon (54)', FormaRadius.appIcon),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, value) in items) ...[
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Container(
              width: 120,
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.15),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(value),
              ),
              alignment: Alignment.center,
              child: Text(
                '${value.toInt()}px',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
