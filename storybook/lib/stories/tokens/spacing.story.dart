import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// Spacing story — visualizes the FormaSpacing scale.
WidgetbookComponent spacingComponent() {
  return WidgetbookComponent(
    name: 'Spacing',
    useCases: [
      WidgetbookUseCase(
        name: 'Scale',
        builder: (context) => const _SpacingScale(),
      ),
    ],
  );
}

class _SpacingScale extends StatelessWidget {
  const _SpacingScale();

  @override
  Widget build(BuildContext context) {
    const items = <(String, double)>[
      ('xs (4)', FormaSpacing.xs),
      ('sm (8)', FormaSpacing.sm),
      ('md (12)', FormaSpacing.md),
      ('base (16)', FormaSpacing.base),
      ('lg (20)', FormaSpacing.lg),
      ('xl (24)', FormaSpacing.xl),
      ('xxl (32)', FormaSpacing.xxl),
      ('xxxl (40)', FormaSpacing.xxxl),
      ('huge (48)', FormaSpacing.huge),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, value) in items) ...[
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Container(
              width: value,
              height: 24,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
