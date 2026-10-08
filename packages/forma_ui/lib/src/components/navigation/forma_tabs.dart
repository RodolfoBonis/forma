import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A single tab descriptor for [FormaTabs].
class FormaTab {
  /// Creates a [FormaTab] with a [label] and optional [count]/[icon].
  const FormaTab({required this.label, this.count, this.icon});

  /// Tab text.
  final String label;

  /// Optional count rendered as a small pill after the label.
  final int? count;

  /// Optional leading icon.
  final IconData? icon;
}

/// An underline-style, animated tab strip for desktop layouts.
///
/// A controlled widget: the caller owns the selected [index] and updates it in
/// [onChanged]. The active tab is tinted with [FormaThemeExtension.primaryColor]
/// and marked by an animated 2px underline indicator. Each tab is keyboard
/// focusable, exposes button semantics, and shows a pointer cursor on hover.
class FormaTabs extends StatelessWidget {
  /// Creates a [FormaTabs] strip.
  const FormaTabs({
    required this.tabs,
    required this.index,
    required this.onChanged,
    super.key,
  });

  /// The tabs to render, in order.
  final List<FormaTab> tabs;

  /// The currently selected tab index.
  final int index;

  /// Called with the tapped tab index.
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ext.border)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < tabs.length; i++)
            _FormaTabButton(
              tab: tabs[i],
              selected: i == index,
              onTap: () => onChanged(i),
            ),
        ],
      ),
    );
  }
}

class _FormaTabButton extends StatelessWidget {
  const _FormaTabButton({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  final FormaTab tab;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final color = selected ? ext.primaryColor : ext.textMuted;

    return Semantics(
      button: true,
      selected: selected,
      label: tab.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(FormaRadius.subtle),
          ),
          child: AnimatedContainer(
            duration: FormaDurations.fade,
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(
              horizontal: FormaSpacing.md,
              vertical: FormaSpacing.md,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: selected ? ext.primaryColor : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (tab.icon != null) ...[
                  Icon(tab.icon, size: 16, color: color),
                  const SizedBox(width: FormaSpacing.sm),
                ],
                Text(
                  tab.label,
                  style: typo.body14Medium.copyWith(color: color),
                ),
                if (tab.count != null) ...[
                  const SizedBox(width: FormaSpacing.sm),
                  _CountPill(count: tab.count!, selected: selected),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountPill extends StatelessWidget {
  const _CountPill({required this.count, required this.selected});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      constraints: const BoxConstraints(minWidth: 18),
      decoration: BoxDecoration(
        color: selected ? ext.primarySurface : ext.appBackground,
        borderRadius: const BorderRadius.all(Radius.circular(FormaRadius.chip)),
      ),
      child: Text(
        '$count',
        textAlign: TextAlign.center,
        style: typo.caption12Med.copyWith(
          color: selected ? ext.primaryColor : ext.textMuted,
          height: 1.3,
        ),
      ),
    );
  }
}
