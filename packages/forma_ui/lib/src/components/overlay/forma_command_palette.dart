import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

import '../display/forma_kbd.dart';
import '../inputs/forma_text_field.dart';

/// Scrim opacity (black 45%) shared by Forma overlays.
const Color _kScrim = Color(0x73000000);

/// A single command / action in a [FormaCommandPalette].
class FormaCommandItem {
  /// Creates a [FormaCommandItem].
  const FormaCommandItem({
    required this.id,
    required this.label,
    required this.onSelected,
    this.icon,
    this.group,
    this.subtitle,
    this.shortcut,
    this.keywords = const [],
  });

  /// Stable identifier (used as the key during filtering).
  final String id;

  /// Primary label shown in the result row.
  final String label;

  /// Invoked after the palette closes when this item is chosen.
  final VoidCallback onSelected;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional group header this item is listed under.
  final String? group;

  /// Optional muted secondary line.
  final String? subtitle;

  /// Optional trailing shortcut hint (rendered as a [FormaKbd]).
  final String? shortcut;

  /// Extra terms matched by the filter in addition to [label]/[subtitle].
  final List<String> keywords;
}

/// A centered command palette (⌘K style) for fast keyboard-driven actions.
///
/// [FormaCommandPalette.show] opens a 640-wide panel near the top of the
/// screen with an autofocused search field. Static [items] are filtered with a
/// case- and diacritics-insensitive contains match over the label, subtitle and
/// keywords, and grouped under their [FormaCommandItem.group] headers. When
/// [onSearch] is provided its results are fetched (debounced 250ms, with a
/// loading indicator) and shown in their own groups below the static matches.
///
/// Keyboard: ↑/↓ move the highlight, `Enter` selects, `Esc` closes; the mouse
/// highlights on hover.
class FormaCommandPalette {
  const FormaCommandPalette._();

  /// Shows the command palette.
  static Future<void> show(
    BuildContext context, {
    required List<FormaCommandItem> items,
    Future<List<FormaCommandItem>> Function(String query)? onSearch,
    String hint = 'Buscar ou executar um comando…',
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: _kScrim,
      transitionDuration: FormaDurations.fade,
      pageBuilder: (context, _, _) {
        return _CommandPaletteDialog(
          items: items,
          onSearch: onSearch,
          hint: hint,
        );
      },
      transitionBuilder: (context, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.03),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}

/// Normalizes [input] for case- and diacritics-insensitive matching.
String _normalize(String input) {
  final lower = input.toLowerCase();
  const from = 'áàâãäéèêëíìîïóòôõöúùûüçñ';
  const to = 'aaaaaeeeeiiiiooooouuuucn';
  final buffer = StringBuffer();
  for (final rune in lower.runes) {
    final char = String.fromCharCode(rune);
    final index = from.indexOf(char);
    buffer.write(index >= 0 ? to[index] : char);
  }
  return buffer.toString();
}

class _CommandPaletteDialog extends StatefulWidget {
  const _CommandPaletteDialog({
    required this.items,
    required this.onSearch,
    required this.hint,
  });

  final List<FormaCommandItem> items;
  final Future<List<FormaCommandItem>> Function(String query)? onSearch;
  final String hint;

  @override
  State<_CommandPaletteDialog> createState() => _CommandPaletteDialogState();
}

class _CommandPaletteDialogState extends State<_CommandPaletteDialog> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _itemKeys = {};

  Timer? _debounce;
  String _query = '';
  List<FormaCommandItem> _asyncResults = const [];
  bool _loading = false;

  List<FormaCommandItem> get _localMatches {
    if (_query.isEmpty) return widget.items;
    final q = _normalize(_query);
    return widget.items.where((item) {
      final haystack = _normalize(
        '${item.label} ${item.subtitle ?? ''} ${item.keywords.join(' ')}',
      );
      return haystack.contains(q);
    }).toList();
  }

  List<FormaCommandItem> get _flat => [..._localMatches, ..._asyncResults];

  int _highlighted = 0;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    setState(() {
      _query = value;
      _highlighted = 0;
    });
    _debounce?.cancel();
    final search = widget.onSearch;
    if (search == null) return;
    if (value.isEmpty) {
      setState(() {
        _asyncResults = const [];
        _loading = false;
      });
      return;
    }
    setState(() => _loading = true);
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      final results = await search(value);
      if (!mounted || value != _query) return;
      setState(() {
        _asyncResults = results;
        _loading = false;
      });
    });
  }

  void _move(int delta) {
    final flat = _flat;
    if (flat.isEmpty) return;
    setState(() {
      _highlighted = (_highlighted + delta).clamp(0, flat.length - 1);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureVisible());
  }

  void _ensureVisible() {
    final flat = _flat;
    if (_highlighted < 0 || _highlighted >= flat.length) return;
    final key = _itemKeys[flat[_highlighted].id];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        alignment: 0.1,
        duration: const Duration(milliseconds: 120),
      );
    }
  }

  void _select(FormaCommandItem item) {
    Navigator.of(context).pop();
    item.onSelected();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowDown) {
      _move(1);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowUp) {
      _move(-1);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      final flat = _flat;
      if (flat.isNotEmpty) _select(flat[_highlighted]);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape) {
      Navigator.of(context).maybePop();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final shape = context.formaShape;
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.15,
        left: FormaSpacing.base,
        right: FormaSpacing.base,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          // Non-focusable ancestor: it never steals focus from the search
          // field (which autofocuses), but still receives key events bubbling
          // up from the focused field so ↑/↓/Enter/Esc are handled here.
          child: Focus(
            canRequestFocus: false,
            onKeyEvent: _onKey,
            child: Material(
              color: ext.resolvedSurfaceElevated,
              borderRadius: BorderRadius.all(
                Radius.circular(shape.dialogRadius),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(shape.dialogRadius),
                  ),
                  border: Border.all(color: ext.border),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSearchField(ext),
                    Divider(height: 1, thickness: 1, color: ext.border),
                    Flexible(child: _buildResults(ext)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(FormaThemeExtension ext) {
    return Padding(
      padding: const EdgeInsets.all(FormaSpacing.md),
      child: Row(
        children: [
          Icon(Icons.search, size: 20, color: ext.textMuted),
          const SizedBox(width: FormaSpacing.md),
          Expanded(
            child: FormaTextField(
              controller: _controller,
              hint: widget.hint,
              autofocus: true,
              onChanged: _onQueryChanged,
              onSubmitted: (_) {
                final flat = _flat;
                if (flat.isNotEmpty) _select(flat[_highlighted]);
              },
            ),
          ),
          if (_loading) ...[
            const SizedBox(width: FormaSpacing.md),
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(ext.primaryColor),
              ),
            ),
          ],
          const SizedBox(width: FormaSpacing.sm),
          const FormaKbd('Esc'),
        ],
      ),
    );
  }

  Widget _buildResults(FormaThemeExtension ext) {
    final flat = _flat;
    if (flat.isEmpty && !_loading) {
      return _EmptyResults();
    }

    final children = <Widget>[];
    var flatIndex = 0;

    void addGroups(List<FormaCommandItem> items) {
      String? currentGroup;
      var firstGroup = true;
      for (final item in items) {
        if (item.group != currentGroup || firstGroup) {
          currentGroup = item.group;
          firstGroup = false;
          if (item.group != null) {
            children.add(_GroupHeader(title: item.group!));
          }
        }
        final index = flatIndex;
        final key = _itemKeys.putIfAbsent(item.id, GlobalKey.new);
        children.add(
          _CommandRow(
            key: key,
            item: item,
            highlighted: index == _highlighted,
            onHover: () => setState(() => _highlighted = index),
            onTap: () => _select(item),
          ),
        );
        flatIndex++;
      }
    }

    addGroups(_localMatches);
    addGroups(_asyncResults);

    return SingleChildScrollView(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: FormaSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.base,
        FormaSpacing.md,
        FormaSpacing.base,
        FormaSpacing.xs,
      ),
      child: Text(
        title.toUpperCase(),
        style: typo.overline10.copyWith(color: ext.textHint),
      ),
    );
  }
}

class _CommandRow extends StatelessWidget {
  const _CommandRow({
    required this.item,
    required this.highlighted,
    required this.onHover,
    required this.onTap,
    super.key,
  });

  final FormaCommandItem item;
  final bool highlighted;
  final VoidCallback onHover;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.sm),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => onHover(),
        child: Semantics(
          button: true,
          selected: highlighted,
          label: item.label,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: FormaSpacing.md,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: highlighted ? ext.primarySurface : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(FormaRadius.input),
                ),
              ),
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(
                      item.icon,
                      size: 18,
                      color: highlighted ? ext.primaryColor : ext.textMuted,
                    ),
                    const SizedBox(width: FormaSpacing.md),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.label,
                          style: typo.body14Medium.copyWith(
                            color: ext.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (item.subtitle != null)
                          Text(
                            item.subtitle!,
                            style: typo.body13.copyWith(color: ext.textMuted),
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  if (item.shortcut != null) ...[
                    const SizedBox(width: FormaSpacing.md),
                    FormaKbd(item.shortcut!),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: FormaSpacing.xxl),
      child: Center(
        child: Text(
          'Nenhum resultado',
          style: typo.body14.copyWith(color: ext.textMuted),
        ),
      ),
    );
  }
}
