import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A task / order card: a status row, title, description, a row of tag
/// chips, and an optional trailing action.
///
/// Slots ([status], [tags], [action]) compose with other Forma components
/// (e.g. `FormaBadge`, `FormaSelectChip`, `FormaButton`). Colors come from
/// [FormaThemeExtension].
class FormaOrderCard extends StatelessWidget {
  /// Creates a [FormaOrderCard].
  const FormaOrderCard({
    required this.title,
    this.description,
    this.status,
    this.timeLabel,
    this.tags = const [],
    this.action,
    super.key,
  });

  /// Card title.
  final String title;

  /// Optional supporting description.
  final String? description;

  /// Optional leading status widget (e.g. a `FormaBadge`).
  final Widget? status;

  /// Optional trailing timestamp label shown on the top row.
  final String? timeLabel;

  /// Tag chips shown above the action row.
  final List<Widget> tags;

  /// Optional trailing action (e.g. a `FormaButton`).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.all(FormaSpacing.base),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.cardLg),
        ),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status != null || timeLabel != null) ...[
            Row(
              children: [
                if (status != null) status!,
                const Spacer(),
                if (timeLabel != null)
                  Text(
                    timeLabel!,
                    style: FormaTypography.caption12.copyWith(
                      color: ext.textMuted,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: FormaSpacing.md),
          ],
          Text(
            title,
            style: FormaTypography.title16.copyWith(color: ext.textPrimary),
          ),
          if (description != null) ...[
            const SizedBox(height: FormaSpacing.xs),
            Text(
              description!,
              style: FormaTypography.body14.copyWith(color: ext.textMuted),
            ),
          ],
          if (tags.isNotEmpty || action != null) ...[
            const SizedBox(height: FormaSpacing.base),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: FormaSpacing.sm,
                    runSpacing: FormaSpacing.sm,
                    children: tags,
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(width: FormaSpacing.sm),
                  action!,
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
