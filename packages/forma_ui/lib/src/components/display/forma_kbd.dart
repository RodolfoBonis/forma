import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A small keycap chip that renders a keyboard shortcut (e.g. `⌘K`, `Esc`).
///
/// Styled like a physical key: a subtle [FormaThemeExtension.border], the
/// [FormaThemeExtension.appBackground] fill and a compact monospace-ish caption.
/// Used inside menus and the command palette to hint at shortcuts.
class FormaKbd extends StatelessWidget {
  /// Creates a [FormaKbd] showing [keys] (e.g. `'⌘K'` or `'Ctrl+S'`).
  const FormaKbd(this.keys, {super.key});

  /// The shortcut text rendered inside the keycap.
  final String keys;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Semantics(
      label: keys,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: FormaSpacing.sm,
          vertical: 2,
        ),
        constraints: const BoxConstraints(minWidth: 20),
        decoration: BoxDecoration(
          color: ext.appBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(FormaRadius.subtle),
          ),
          border: Border.all(color: ext.border),
        ),
        child: Text(
          keys,
          textAlign: TextAlign.center,
          style: typo.caption12Med.copyWith(
            color: ext.textMuted,
            fontFamily: 'monospace',
            fontFamilyFallback: const ['Menlo', 'Courier'],
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
