import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaStepIndicator story — horizontal step progress.
WidgetbookComponent formaStepIndicatorComponent() {
  return WidgetbookComponent(
    name: 'FormaStepIndicator',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final totalSteps = context.knobs.int.slider(
            label: 'Total Steps',
            initialValue: 4,
            min: 2,
            max: 8,
          );
          final currentStep = context.knobs.int.slider(
            label: 'Current Step',
            initialValue: 2,
            min: 1,
            max: 8,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaStepIndicator(
              currentStep: currentStep.clamp(1, totalSteps),
              totalSteps: totalSteps,
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Progress Demo',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int step = 1; step <= 4; step++) ...[
                  Text('Passo $step de 4',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  FormaStepIndicator(currentStep: step, totalSteps: 4),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          );
        },
      ),
    ],
  );
}
