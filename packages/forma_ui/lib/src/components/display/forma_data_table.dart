import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

import '../feedback/forma_skeleton.dart';

/// Describes a single column of a [FormaDataTable].
///
/// A column either has a fixed [width] or stretches to share the remaining
/// space according to its [flex]. [cellBuilder] renders the content for a given
/// row; [sortable] enables the clickable sort affordance in the header.
class FormaColumn<T> {
  /// Creates a [FormaColumn].
  const FormaColumn({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.width,
    this.flex = 1,
    this.sortable = false,
    this.alignment = Alignment.centerLeft,
  });

  /// Stable identifier used for sorting callbacks.
  final String id;

  /// Header label.
  final String label;

  /// Builds the cell widget for [row].
  final Widget Function(BuildContext context, T row) cellBuilder;

  /// Fixed column width. When null the column uses [flex].
  final double? width;

  /// Flex factor used when [width] is null.
  final int flex;

  /// Whether the column can be sorted (renders a clickable header + arrow).
  final bool sortable;

  /// Alignment of the cell content within the column.
  final Alignment alignment;
}

/// A compact, desktop-styled data table.
///
/// Renders a card container with a sticky header row and data rows separated by
/// hairline borders. Rows highlight on hover, show a click cursor and are
/// keyboard-focusable (Enter activates [onRowTap]) when [onRowTap] is set.
/// Sortable columns toggle ascending / descending through [onSort].
///
/// When [loading] is true, [skeletonRows] shimmering placeholder rows are
/// rendered. When there are no [rows] and not loading, [empty] is shown (or a
/// default "Nenhum registro" message).
///
/// By default the rows area is an [Expanded] scrollable list, so the table
/// fills its parent's height. Set [shrinkWrap] to true to size the table to its
/// content (e.g. inside a parent [SingleChildScrollView]).
class FormaDataTable<T> extends StatelessWidget {
  /// Creates a [FormaDataTable].
  const FormaDataTable({
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.sortColumnId,
    this.sortAscending = true,
    this.onSort,
    this.loading = false,
    this.empty,
    this.rowHeight = 52,
    this.rowKey,
    this.trailingBuilder,
    this.skeletonRows = 8,
    this.shrinkWrap = false,
    super.key,
  });

  /// Column definitions, in display order.
  final List<FormaColumn<T>> columns;

  /// Row data.
  final List<T> rows;

  /// Called when a row is tapped or activated with the keyboard.
  final void Function(T row)? onRowTap;

  /// The id of the currently sorted column, if any.
  final String? sortColumnId;

  /// Whether the current sort is ascending.
  final bool sortAscending;

  /// Called with the column id and new direction when a sortable header is
  /// clicked.
  final void Function(String columnId, bool ascending)? onSort;

  /// When true, renders [skeletonRows] shimmering placeholder rows.
  final bool loading;

  /// Widget shown when [rows] is empty and not [loading].
  final Widget? empty;

  /// Height of each data row.
  final double rowHeight;

  /// Extracts a stable key for a row (used for efficient list diffing).
  final Object Function(T row)? rowKey;

  /// Builds a trailing actions cell (fixed 48px) rendered at the end of each
  /// row. The header reserves the same space.
  final Widget Function(BuildContext, T row)? trailingBuilder;

  /// Number of skeleton rows rendered while [loading].
  final int skeletonRows;

  /// When true, the rows area sizes to its content instead of expanding.
  final bool shrinkWrap;

  static const double _trailingWidth = 48;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final shape = context.formaShape;
    final radius = Radius.circular(shape.cardRadius);

    final body = loading
        ? _buildSkeleton(context, ext)
        : rows.isEmpty
        ? _buildEmpty(context, ext)
        : _buildRows(context, ext);

    return Container(
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: BorderRadius.all(radius),
        border: Border.all(color: ext.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: [_buildHeader(context, ext), body],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FormaThemeExtension ext) {
    final typo = context.formaTypography;

    final cells = <Widget>[];
    for (final col in columns) {
      final isSorted = sortColumnId == col.id;
      final content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              col.label,
              overflow: TextOverflow.ellipsis,
              style: typo.caption12Med.copyWith(color: ext.textMuted),
            ),
          ),
          if (col.sortable) ...[
            const SizedBox(width: FormaSpacing.xs),
            Icon(
              isSorted
                  ? (sortAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : Icons.unfold_more,
              size: 14,
              color: isSorted ? ext.textPrimary : ext.textHint,
            ),
          ],
        ],
      );

      Widget cell = Align(alignment: col.alignment, child: content);
      if (col.sortable && onSort != null) {
        cell = MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSort!(col.id, isSorted ? !sortAscending : true),
            child: cell,
          ),
        );
      }
      cells.add(_wrapCell(col, cell));
    }
    if (trailingBuilder != null) {
      cells.add(const SizedBox(width: _trailingWidth));
    }

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
      decoration: BoxDecoration(
        color: ext.appBackground,
        border: Border(bottom: BorderSide(color: ext.border)),
      ),
      child: Row(children: cells),
    );
  }

  Widget _buildRows(BuildContext context, FormaThemeExtension ext) {
    Widget rowAt(int index) {
      final row = rows[index];
      final cells = <Widget>[
        for (final col in columns)
          _wrapCell(
            col,
            Align(
              alignment: col.alignment,
              child: col.cellBuilder(context, row),
            ),
          ),
        if (trailingBuilder != null)
          SizedBox(
            width: _trailingWidth,
            child: Center(child: trailingBuilder!(context, row)),
          ),
      ];

      return _DataRow(
        key: rowKey != null ? ValueKey<Object>(rowKey!(row)) : null,
        height: rowHeight,
        showBottomBorder: index != rows.length - 1,
        onTap: onRowTap == null ? null : () => onRowTap!(row),
        child: Row(children: cells),
      );
    }

    if (shrinkWrap) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [for (var i = 0; i < rows.length; i++) rowAt(i)],
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) => rowAt(index),
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context, FormaThemeExtension ext) {
    Widget skeletonRow(int index) {
      final cells = <Widget>[
        for (final col in columns)
          _wrapCell(
            col,
            Align(
              alignment: col.alignment,
              child: const FormaSkeleton.line(width: 80),
            ),
          ),
        if (trailingBuilder != null)
          const SizedBox(
            width: _trailingWidth,
            child: Center(child: FormaSkeleton.line(width: 20)),
          ),
      ];
      return _DataRow(
        height: rowHeight,
        showBottomBorder: index != skeletonRows - 1,
        onTap: null,
        child: Row(children: cells),
      );
    }

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [for (var i = 0; i < skeletonRows; i++) skeletonRow(i)],
    );
    return shrinkWrap
        ? content
        : Expanded(child: SingleChildScrollView(child: content));
  }

  Widget _buildEmpty(BuildContext context, FormaThemeExtension ext) {
    final typo = context.formaTypography;
    final content =
        empty ??
        Padding(
          padding: const EdgeInsets.all(FormaSpacing.xxl),
          child: Text(
            'Nenhum registro',
            style: typo.body14.copyWith(color: ext.textMuted),
          ),
        );
    final centered = Center(child: content);
    return shrinkWrap ? centered : Expanded(child: centered);
  }

  Widget _wrapCell(FormaColumn<T> col, Widget child) {
    final padded = Padding(
      padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.sm),
      child: child,
    );
    if (col.width != null) {
      return SizedBox(width: col.width, child: padded);
    }
    return Expanded(flex: col.flex, child: padded);
  }
}

/// An interactive data row: hover highlight, click cursor, keyboard focus +
/// Enter activation, and a hairline bottom border.
class _DataRow extends StatefulWidget {
  const _DataRow({
    required this.height,
    required this.child,
    required this.onTap,
    required this.showBottomBorder,
    super.key,
  });

  final double height;
  final Widget child;
  final VoidCallback? onTap;
  final bool showBottomBorder;

  @override
  State<_DataRow> createState() => _DataRowState();
}

class _DataRowState extends State<_DataRow> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final interactive = widget.onTap != null;

    final content = Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
      decoration: BoxDecoration(
        color: _hovered && interactive
            ? ext.primaryColor.withValues(alpha: 0.06)
            : Colors.transparent,
        border: Border(
          bottom: widget.showBottomBorder
              ? BorderSide(color: ext.border)
              : BorderSide.none,
        ),
      ),
      child: DefaultTextStyle.merge(
        style: context.formaTypography.body14.copyWith(color: ext.textPrimary),
        child: widget.child,
      ),
    );

    final focusRing = Container(
      foregroundDecoration: _focused
          ? BoxDecoration(
              border: Border.all(color: ext.primaryColor, width: 1.5),
            )
          : null,
      child: content,
    );

    if (!interactive) return focusRing;

    return Semantics(
      button: true,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (v) => setState(() => _hovered = v),
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onTap!();
              return null;
            },
          ),
        },
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: focusRing,
        ),
      ),
    );
  }
}
