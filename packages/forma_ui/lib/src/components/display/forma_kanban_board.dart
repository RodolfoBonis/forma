import 'dart:async';

import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

import '../feedback/forma_skeleton.dart';

/// Describes a single column of a [FormaKanbanBoard].
///
/// Holds the column's [items] plus presentation / pagination metadata. The
/// board never mutates these lists — on a drop it calls
/// [FormaKanbanBoard.onMove] and the parent updates its own state.
class FormaKanbanColumn<T> {
  /// Creates a [FormaKanbanColumn].
  const FormaKanbanColumn({
    required this.id,
    required this.title,
    required this.items,
    this.color,
    this.totalCount,
    this.hasMore = false,
    this.loadingMore = false,
    this.onLoadMore,
    this.collapsed = false,
    this.onToggleCollapsed,
    this.emptyText = 'Nenhum item',
    this.headerTrailing,
  });

  /// Stable identifier used in move callbacks.
  final String id;

  /// Column title shown in the header.
  final String title;

  /// The items currently loaded in this column.
  final List<T> items;

  /// Optional accent color shown as a dot in the header.
  final Color? color;

  /// Total number of items (across all pages). Falls back to `items.length`.
  final int? totalCount;

  /// Whether more items can be loaded (drives infinite scroll).
  final bool hasMore;

  /// Whether a "load more" request is currently in flight.
  final bool loadingMore;

  /// Called when the list nears its end and [hasMore] is true.
  final VoidCallback? onLoadMore;

  /// Whether the column is rendered as a narrow collapsed strip.
  final bool collapsed;

  /// Called when the collapse chevron is tapped. When null, no chevron shows.
  final VoidCallback? onToggleCollapsed;

  /// Message shown when the column has no items.
  final String emptyText;

  /// Optional trailing widget in the header (e.g. an actions menu).
  final Widget? headerTrailing;
}

/// Internal payload carried by a dragged card.
class _KanbanDrag<T> {
  const _KanbanDrag(this.item, this.fromColumnId);

  final T item;
  final String fromColumnId;
}

/// A compact, desktop-styled Kanban board with mouse drag & drop.
///
/// Renders a horizontally scrollable row of columns (with a visible scrollbar;
/// shift+wheel / trackpad scrolls horizontally). Cards are dragged with the
/// mouse (a short movement starts the drag). While dragging, columns that
/// accept the card (per [canMove]) show a dashed primary highlight, disallowed
/// columns dim and reject the drop, and the source column stays neutral. On a
/// valid drop the board calls [onMove] — it never mutates the lists itself.
///
/// Each column supports infinite scroll ([FormaKanbanColumn.onLoadMore]) and a
/// collapsed strip state. When [loading] is true, skeleton cards fill every
/// column.
///
/// Accessibility: cards are focusable and carry [Semantics] hints. Because drag
/// & drop is pointer-only, apps should also expose a non-drag "Mover para…"
/// action (e.g. via [FormaKanbanColumn.headerTrailing] or a card menu).
class FormaKanbanBoard<T extends Object> extends StatefulWidget {
  /// Creates a [FormaKanbanBoard].
  const FormaKanbanBoard({
    required this.columns,
    required this.itemKey,
    required this.cardBuilder,
    required this.onMove,
    this.canMove,
    this.columnWidth = 300,
    this.collapsedWidth = 52,
    this.loading = false,
    super.key,
  });

  /// The columns, in display order.
  final List<FormaKanbanColumn<T>> columns;

  /// Extracts a stable identity for an item (used for keys and drag payloads).
  final Object Function(T item) itemKey;

  /// Builds the card body for an item.
  final Widget Function(BuildContext context, T item) cardBuilder;

  /// Whether [item] may move from `fromColumnId` to `toColumnId`. When null,
  /// all moves between different columns are allowed.
  final bool Function(T item, String fromColumnId, String toColumnId)? canMove;

  /// Called on a valid drop. The board does not mutate any list.
  final void Function(T item, String fromColumnId, String toColumnId) onMove;

  /// Width of an expanded column.
  final double columnWidth;

  /// Width of a collapsed column strip.
  final double collapsedWidth;

  /// When true, renders skeleton cards in every column.
  final bool loading;

  @override
  State<FormaKanbanBoard<T>> createState() => _FormaKanbanBoardState<T>();
}

class _FormaKanbanBoardState<T extends Object>
    extends State<FormaKanbanBoard<T>> {
  final ScrollController _hScroll = ScrollController();
  final GlobalKey _boardKey = GlobalKey();

  T? _draggingItem;
  String? _fromColumnId;
  Timer? _autoScrollTimer;

  static const double _edgeZone = 60;
  static const double _autoScrollStep = 24;

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _hScroll.dispose();
    super.dispose();
  }

  bool _allowsDrop(FormaKanbanColumn<T> column) {
    if (_draggingItem == null || _fromColumnId == null) return false;
    if (column.id == _fromColumnId) return false;
    return widget.canMove?.call(_draggingItem!, _fromColumnId!, column.id) ??
        true;
  }

  void _startDrag(T item, String fromColumnId) {
    setState(() {
      _draggingItem = item;
      _fromColumnId = fromColumnId;
    });
  }

  void _endDrag() {
    _stopAutoScroll();
    setState(() {
      _draggingItem = null;
      _fromColumnId = null;
    });
  }

  void _onDragUpdate(Offset globalPosition) {
    final box = _boardKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !_hScroll.hasClients) return;
    final local = box.globalToLocal(globalPosition);
    final width = box.size.width;
    if (local.dx < _edgeZone) {
      _startAutoScroll(-1);
    } else if (local.dx > width - _edgeZone) {
      _startAutoScroll(1);
    } else {
      _stopAutoScroll();
    }
  }

  void _startAutoScroll(int direction) {
    _autoScrollTimer ??= Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_hScroll.hasClients) return;
      final position = _hScroll.position;
      final next = (_hScroll.offset + direction * _autoScrollStep).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );
      _hScroll.jumpTo(next);
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 600.0;
        return Scrollbar(
          controller: _hScroll,
          thumbVisibility: true,
          child: SingleChildScrollView(
            key: _boardKey,
            controller: _hScroll,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final column in widget.columns)
                    Padding(
                      padding: const EdgeInsets.only(right: FormaSpacing.md),
                      child: _buildColumn(context, column),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColumn(BuildContext context, FormaKanbanColumn<T> column) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return DragTarget<_KanbanDrag<T>>(
      onWillAcceptWithDetails: (_) => _allowsDrop(column),
      onAcceptWithDetails: (details) {
        widget.onMove(details.data.item, details.data.fromColumnId, column.id);
      },
      builder: (context, candidate, rejected) {
        final isTarget = _allowsDrop(column);
        final isDisallowed =
            _draggingItem != null && column.id != _fromColumnId && !isTarget;

        Widget content = column.collapsed
            ? _buildCollapsed(context, column, ext, highlight: isTarget)
            : _buildExpanded(context, column, ext, highlight: isTarget);

        if (isDisallowed) {
          content = Opacity(opacity: 0.45, child: content);
        }
        return content;
      },
    );
  }

  Widget _buildExpanded(
    BuildContext context,
    FormaKanbanColumn<T> column,
    FormaThemeExtension ext, {
    required bool highlight,
  }) {
    final decoration = BoxDecoration(
      color: ext.appBackground,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: highlight ? null : Border.all(color: ext.border),
    );

    final body = widget.loading
        ? _buildSkeletonList(ext)
        : column.items.isEmpty
        ? _buildEmpty(context, column, ext)
        : _buildCardList(context, column);

    final inner = Container(
      width: widget.columnWidth,
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, column, ext),
          Expanded(child: body),
        ],
      ),
    );

    if (!highlight) return inner;
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: ext.primaryColor,
        radius: 12,
      ),
      child: Container(
        width: widget.columnWidth,
        decoration: BoxDecoration(
          color: ext.primarySurface.withValues(alpha: 0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, column, ext),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    FormaKanbanColumn<T> column,
    FormaThemeExtension ext,
  ) {
    final typo = context.formaTypography;
    final count = column.totalCount ?? column.items.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.md,
        FormaSpacing.md,
        FormaSpacing.sm,
        FormaSpacing.sm,
      ),
      child: Row(
        children: [
          if (column.color != null) ...[
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: column.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: FormaSpacing.sm),
          ],
          Flexible(
            child: Text(
              column.title,
              overflow: TextOverflow.ellipsis,
              style: typo.body13Bold.copyWith(color: ext.textPrimary),
            ),
          ),
          const SizedBox(width: FormaSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: ext.cardBackground,
              borderRadius: const BorderRadius.all(Radius.circular(999)),
              border: Border.all(color: ext.border),
            ),
            child: Text(
              '$count',
              style: typo.caption12Med.copyWith(color: ext.textMuted),
            ),
          ),
          const Spacer(),
          if (column.headerTrailing != null) column.headerTrailing!,
          if (column.onToggleCollapsed != null)
            _IconTap(
              icon: Icons.chevron_left,
              tooltip: 'Recolher',
              onTap: column.onToggleCollapsed!,
            ),
        ],
      ),
    );
  }

  Widget _buildCardList(BuildContext context, FormaKanbanColumn<T> column) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.axis != Axis.vertical) return false;
        final pixels = notification.metrics.pixels;
        final max = notification.metrics.maxScrollExtent;
        if (pixels >= max - 240 &&
            column.hasMore &&
            !column.loadingMore &&
            column.onLoadMore != null) {
          column.onLoadMore!();
        }
        return false;
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          FormaSpacing.sm,
          0,
          FormaSpacing.sm,
          FormaSpacing.sm,
        ),
        children: [
          for (final item in column.items)
            Padding(
              padding: const EdgeInsets.only(bottom: FormaSpacing.sm),
              child: _buildCard(context, column, item),
            ),
          if (column.loadingMore)
            const Padding(
              padding: EdgeInsets.all(FormaSpacing.sm),
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, FormaKanbanColumn<T> column, T item) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final card = widget.cardBuilder(context, item);
    final cardWidth = widget.columnWidth - (FormaSpacing.sm * 2);

    return Draggable<_KanbanDrag<T>>(
      data: _KanbanDrag<T>(item, column.id),
      dragAnchorStrategy: pointerDragAnchorStrategy,
      onDragStarted: () => _startDrag(item, column.id),
      onDragUpdate: (details) => _onDragUpdate(details.globalPosition),
      onDragEnd: (_) => _endDrag(),
      onDraggableCanceled: (_, __) => _endDrag(),
      feedback: Transform.rotate(
        angle: 0.035,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: card,
          ),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.4, child: card),
      child: Focus(
        child: Semantics(
          button: true,
          label: 'Cartão em ${column.title}. Arraste para mover entre colunas.',
          child: MouseRegion(
            cursor: SystemMouseCursors.grab,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: ext.border),
              ),
              child: card,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonList(FormaThemeExtension ext) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.sm,
        0,
        FormaSpacing.sm,
        FormaSpacing.sm,
      ),
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: FormaSpacing.sm),
          child: FormaSkeleton.box(height: 72),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: FormaSpacing.sm),
          child: FormaSkeleton.box(height: 72),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: FormaSpacing.sm),
          child: FormaSkeleton.box(height: 72),
        ),
      ],
    );
  }

  Widget _buildEmpty(
    BuildContext context,
    FormaKanbanColumn<T> column,
    FormaThemeExtension ext,
  ) {
    final typo = context.formaTypography;
    return Padding(
      padding: const EdgeInsets.all(FormaSpacing.sm),
      child: CustomPaint(
        painter: _DashedBorderPainter(color: ext.border, radius: 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(FormaSpacing.base),
            child: Text(
              column.emptyText,
              textAlign: TextAlign.center,
              style: typo.caption12.copyWith(color: ext.textMuted),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCollapsed(
    BuildContext context,
    FormaKanbanColumn<T> column,
    FormaThemeExtension ext, {
    required bool highlight,
  }) {
    final typo = context.formaTypography;
    final count = column.totalCount ?? column.items.length;

    return Container(
      width: widget.collapsedWidth,
      decoration: BoxDecoration(
        color: highlight
            ? ext.primarySurface.withValues(alpha: 0.4)
            : ext.appBackground,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: highlight ? ext.primaryColor : ext.border),
      ),
      child: Column(
        children: [
          const SizedBox(height: FormaSpacing.sm),
          if (column.onToggleCollapsed != null)
            _IconTap(
              icon: Icons.chevron_right,
              tooltip: 'Expandir',
              onTap: column.onToggleCollapsed!,
            ),
          const SizedBox(height: FormaSpacing.sm),
          if (column.color != null)
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: column.color,
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(height: FormaSpacing.sm),
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      column.title,
                      overflow: TextOverflow.ellipsis,
                      style: typo.body13Bold.copyWith(color: ext.textPrimary),
                    ),
                    const SizedBox(width: FormaSpacing.sm),
                    Text(
                      '$count',
                      style: typo.caption12Med.copyWith(color: ext.textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a rounded dashed border (drop target highlight, empty-column box).
class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    const dashWidth = 6.0;
    const dashGap = 4.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

/// A small inline icon action used in column headers and strips.
class _IconTap extends StatelessWidget {
  const _IconTap({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    return Semantics(
      button: true,
      label: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Icon(icon, size: 18, color: ext.textMuted),
          ),
        ),
      ),
    );
  }
}
