import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaStepIndicator story — horizontal step progress.
GalleryComponent formaStepIndicatorComponent() {
  return GalleryComponent(
    'FormaStepIndicator',
    docs: const ComponentDocs(
      description:
          'Horizontal step progress indicator showing completed and future '
          'segments plus a "Passo N de M" label.',
      props: [
        PropDoc(
          'currentStep',
          'int',
          required: true,
          description: 'The current step (1-based).',
        ),
        PropDoc(
          'totalSteps',
          'int',
          required: true,
          description: 'Total number of steps.',
        ),
      ],
      codeSnippet: '''
FormaStepIndicator(currentStep: 2, totalSteps: 4)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final totalSteps = k.int.slider(
          label: 'Total Steps',
          initialValue: 4,
          min: 2,
          max: 8,
        );
        final currentStep = k.int.slider(
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
      }),
      UseCase('Progress Demo', (context, k) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var step = 1; step <= 4; step++) ...[
                Text(
                  'Passo $step de 4',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                FormaStepIndicator(currentStep: step, totalSteps: 4),
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      }),
    ],
  );
}
