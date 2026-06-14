import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A single segment within a [FormaSegmentedControl].
class FormaSegment {
  /// Creates a segment with a [label] and optional leading [icon].
  const FormaSegment({required this.label, this.icon});

  /// Text shown in the segment.
  final String label;

  /// Optional leading icon.
  final IconData? icon;
}

/// A pill-shaped segmented control for switching between 2–3 options.
///
/// The active segment is highlighted with an elevated surface; inactive
/// segments use muted text. Colors are drawn from [FormaThemeExtension].
class FormaSegmentedControl extends StatelessWidget {
  /// Creates a [FormaSegmentedControl].
  const FormaSegmentedControl({
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  /// The segments to display (typically 2 or 3).
  final List<FormaSegment> segments;

  /// Index of the currently selected segment.
  final int selectedIndex;

  /// Called with the tapped segment index.
  final ValueChanged<int> onChanged;

  static const double _height = 44;
  static const double _innerPadding = 4;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Container(
      height: _height,
      padding: const EdgeInsets.all(_innerPadding),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.large),
        ),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      child: Row(
        children: [
          for (var i = 0; i < segments.length; i++)
            Expanded(child: _buildSegment(ext, typo, i)),
        ],
      ),
    );
  }

  Widget _buildSegment(
    FormaThemeExtension ext,
    FormaTypographyExtension typo,
    int index,
  ) {
    final segment = segments[index];
    final isActive = index == selectedIndex;
    final foreground = isActive ? ext.textPrimary : ext.textMuted;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(index),
      child: AnimatedContainer(
        duration: FormaDurations.fade,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? ext.resolvedSurfaceElevated : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(FormaRadius.small),
          ),
          border: isActive ? Border.all(color: ext.border, width: 0.5) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (segment.icon != null) ...[
              Icon(segment.icon, size: 16, color: foreground),
              const SizedBox(width: FormaSpacing.sm),
            ],
            Flexible(
              child: Text(
                segment.label,
                overflow: TextOverflow.ellipsis,
                style: (isActive ? typo.body14Medium : typo.body14).copyWith(
                  color: foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
