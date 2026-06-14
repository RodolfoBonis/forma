import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A single step in a [FormaTimeline].
class FormaTimelineStep {
  /// Creates a [FormaTimelineStep].
  const FormaTimelineStep({required this.label, required this.timing});

  /// Description of what happens at this step.
  final String label;

  /// When this step occurs (e.g. "Imediato", "Em segundos").
  final String timing;
}

/// An event timeline widget following Forma Design System specs.
///
/// Displays a titled list of [steps] with bullet indicators and
/// timing labels aligned to the right.
class FormaTimeline extends StatelessWidget {
  /// Creates a [FormaTimeline].
  const FormaTimeline({super.key, required this.title, required this.steps});

  /// The title displayed above the step list.
  final String title;

  /// The timeline steps to display.
  final List<FormaTimelineStep> steps;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.all(FormaSpacing.md),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: FormaTypography.title16.copyWith(color: ext.textPrimary),
          ),
          const SizedBox(height: FormaSpacing.md),
          for (int i = 0; i < steps.length; i++) ...[
            if (i > 0) const SizedBox(height: FormaSpacing.sm),
            _buildStep(steps[i], ext),
          ],
        ],
      ),
    );
  }

  Widget _buildStep(FormaTimelineStep step, FormaThemeExtension ext) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: ext.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: FormaSpacing.sm),
        Expanded(
          child: Text(
            step.label,
            style: FormaTypography.body14.copyWith(color: ext.textPrimary),
          ),
        ),
        Text(
          step.timing,
          style: FormaTypography.caption12.copyWith(color: ext.textMuted),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
