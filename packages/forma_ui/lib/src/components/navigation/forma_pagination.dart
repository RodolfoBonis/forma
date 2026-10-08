import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact, desktop-styled pagination control.
///
/// Shows an optional "Mostrando x–y de N registros" summary on the left (when
/// both [total] and [pageSize] are provided) and page navigation on the right:
/// previous / next icon buttons plus numbered page buttons with ellipsis
/// collapsing (e.g. `1 … 4 5 6 … 12`). The current page is highlighted with
/// the theme's primary surface / color.
///
/// Pages are **1-based**: [page] ranges from 1 to [totalPages].
class FormaPagination extends StatelessWidget {
  /// Creates a [FormaPagination].
  const FormaPagination({
    required this.page,
    required this.totalPages,
    required this.onPageChanged,
    this.total,
    this.pageSize,
    this.itemLabel = 'registros',
    super.key,
  });

  /// The current 1-based page.
  final int page;

  /// The total number of pages (>= 1).
  final int totalPages;

  /// Called with the requested 1-based page when the user navigates.
  final ValueChanged<int> onPageChanged;

  /// Total number of items across all pages. When provided with [pageSize],
  /// the "Mostrando x–y de N" summary is shown.
  final int? total;

  /// Number of items per page. See [total].
  final int? pageSize;

  /// Noun used in the summary (e.g. "registros", "itens"). Defaults to
  /// `registros`.
  final String itemLabel;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final canPrev = page > 1;
    final canNext = page < totalPages;

    return Row(
      children: [
        if (total != null && pageSize != null)
          Expanded(
            child: Text(
              _summary(total!, pageSize!),
              style: typo.caption12.copyWith(color: ext.textMuted),
            ),
          )
        else
          const Spacer(),
        _NavButton(
          icon: Icons.chevron_left,
          enabled: canPrev,
          tooltip: 'Anterior',
          onTap: () => onPageChanged(page - 1),
        ),
        const SizedBox(width: FormaSpacing.xs),
        for (final entry in _pageEntries()) ...[
          if (entry == null)
            _Ellipsis(color: ext.textHint, style: typo.caption12Med)
          else
            _PageButton(
              page: entry,
              selected: entry == page,
              onTap: () => onPageChanged(entry),
            ),
          const SizedBox(width: FormaSpacing.xs),
        ],
        _NavButton(
          icon: Icons.chevron_right,
          enabled: canNext,
          tooltip: 'Próxima',
          onTap: () => onPageChanged(page + 1),
        ),
      ],
    );
  }

  String _summary(int total, int pageSize) {
    if (total == 0) return 'Nenhum $itemLabel';
    final start = (page - 1) * pageSize + 1;
    final end = math.min(page * pageSize, total);
    return 'Mostrando $start–$end de $total $itemLabel';
  }

  /// Builds the sequence of page numbers, using `null` for an ellipsis gap.
  List<int?> _pageEntries() {
    if (totalPages <= 7) {
      return [for (var i = 1; i <= totalPages; i++) i];
    }

    final pages = <int>{1, totalPages, page};
    for (final p in [page - 1, page + 1]) {
      if (p >= 1 && p <= totalPages) pages.add(p);
    }

    final sorted = pages.toList()..sort();
    final result = <int?>[];
    int? previous;
    for (final p in sorted) {
      if (previous != null && p - previous > 1) result.add(null);
      result.add(p);
      previous = p;
    }
    return result;
  }
}

/// A single numbered page button with hover and selected states.
class _PageButton extends StatefulWidget {
  const _PageButton({
    required this.page,
    required this.selected,
    required this.onTap,
  });

  final int page;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<_PageButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final bg = widget.selected
        ? ext.primarySurface
        : (_hovered ? ext.appBackground : Colors.transparent);
    final fg = widget.selected ? ext.primaryColor : ext.textMuted;
    final borderColor = widget.selected ? ext.primaryBorder : ext.border;

    return Semantics(
      button: true,
      selected: widget.selected,
      label: 'Página ${widget.page}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: FormaDurations.fade,
            constraints: const BoxConstraints(minWidth: 32),
            height: 32,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.sm),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: borderColor),
            ),
            child: Text(
              '${widget.page}',
              style: typo.caption12Med.copyWith(color: fg),
            ),
          ),
        ),
      ),
    );
  }
}

/// A previous / next navigation icon button.
class _NavButton extends StatefulWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  final String tooltip;

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final fg = widget.enabled ? ext.textMuted : ext.textHint;
    final bg = _hovered && widget.enabled
        ? ext.appBackground
        : Colors.transparent;

    return Semantics(
      button: true,
      enabled: widget.enabled,
      label: widget.tooltip,
      child: MouseRegion(
        cursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.enabled ? widget.onTap : null,
          child: AnimatedContainer(
            duration: FormaDurations.fade,
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: ext.border),
            ),
            child: Icon(widget.icon, size: 18, color: fg),
          ),
        ),
      ),
    );
  }
}

/// A non-interactive ellipsis gap between page buttons.
class _Ellipsis extends StatelessWidget {
  const _Ellipsis({required this.color, required this.style});

  final Color color;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 32,
      child: Center(
        child: Text('…', style: style.copyWith(color: color)),
      ),
    );
  }
}
