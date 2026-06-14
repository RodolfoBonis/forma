import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A horizontal step progress indicator following Forma Design System specs.
///
/// Displays [totalSteps] segments with completed and future states,
/// plus a "Passo N de M" label.
class FormaStepIndicator extends StatelessWidget {
  /// Creates a [FormaStepIndicator].
  const FormaStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  /// The current step (1-based).
  final int currentStep;

  /// Total number of steps.
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Semantics(
      label: 'Passo $currentStep de $totalSteps',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(totalSteps * 2 - 1, (index) {
              // Odd indices are gaps
              if (index.isOdd) {
                return const SizedBox(width: 4);
              }

              final stepIndex = index ~/ 2;
              final isCompleted = stepIndex < currentStep;

              return Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: isCompleted ? ext.primaryColor : ext.primarySurface,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            'Passo $currentStep de $totalSteps',
            style: FormaTypography.caption12.copyWith(color: ext.textMuted),
          ),
        ],
      ),
    );
  }
}
