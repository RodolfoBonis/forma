import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Workflow status shown by a [FormaStatusBadge].
///
/// Each value carries a default Portuguese [label]; override it via the
/// widget's `label` argument when needed.
enum FormaStatusVariant {
  /// Awaiting start — neutral.
  pendente('Pendente'),

  /// In progress — informational.
  emAndamento('Em andamento'),

  /// Awaiting approval — warning.
  aguardandoAprovacao('Aguardando aprovação'),

  /// Completed — success.
  concluida('Concluída'),

  /// Overdue — error.
  atrasada('Atrasada'),

  /// Paused — error.
  pausada('Pausada'),

  /// Rejected — error.
  rejeitada('Rejeitada');

  const FormaStatusVariant(this.label);

  /// Default label for this status.
  final String label;
}

/// A status pill with a colored leading dot and a label, on an elevated
/// surface.
///
/// Distinct from `FormaBadge` (a solid-filled pill): [FormaStatusBadge] uses
/// the dot + label style for workflow states. Colors resolve from
/// [FormaThemeExtension] semantic slots.
class FormaStatusBadge extends StatelessWidget {
  /// Creates a [FormaStatusBadge] for the given [variant].
  ///
  /// Pass [label] to override the variant's default text.
  const FormaStatusBadge({required this.variant, this.label, super.key});

  /// The workflow status, controlling color and default label.
  final FormaStatusVariant variant;

  /// Optional label override. Defaults to [FormaStatusVariant.label].
  final String? label;

  static const double _height = 28;
  static const double _dotSize = 7;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final color = _resolveColor(ext);
    final text = label ?? variant.label;

    return Semantics(
      label: text,
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
        decoration: BoxDecoration(
          color: ext.resolvedSurfaceElevated,
          borderRadius: const BorderRadius.all(Radius.circular(_height / 2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: FormaSpacing.sm),
            Text(
              text,
              style: FormaTypography.caption12Med.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }

  Color _resolveColor(FormaThemeExtension ext) {
    return switch (variant) {
      FormaStatusVariant.pendente => ext.textMuted,
      FormaStatusVariant.emAndamento => ext.infoText,
      FormaStatusVariant.aguardandoAprovacao => ext.warningColor,
      FormaStatusVariant.concluida => ext.successColor,
      FormaStatusVariant.atrasada ||
      FormaStatusVariant.pausada ||
      FormaStatusVariant.rejeitada => ext.errorColor,
    };
  }
}
