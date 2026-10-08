import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

import 'forma_select.dart';

/// A compact, desktop-styled async combobox (type-ahead select).
///
/// Shares the select trigger look, but resolves its options asynchronously
/// through [search]. Opening the field focuses an inline search box and calls
/// `search('')` to seed results. Keystrokes are debounced by [debounce], a
/// spinner is shown while awaiting results, and search errors are caught and
/// surfaced as "Erro ao buscar" rather than thrown. Keyboard navigation
/// (↑/↓/Enter/Esc) is supported. Pending timers and requests are cancelled on
/// dispose.
class FormaCombobox<T> extends StatefulWidget {
  /// Creates a [FormaCombobox].
  const FormaCombobox({
    required this.search,
    required this.onChanged,
    this.value,
    this.label,
    this.hint = 'Buscar…',
    this.emptyText = 'Nenhum resultado',
    this.enabled = true,
    this.errorText,
    this.debounce = const Duration(milliseconds: 250),
    super.key,
  });

  /// Resolves the options for a given [query]. May throw; errors are caught.
  final Future<List<FormaSelectOption<T>>> Function(String query) search;

  /// The currently selected option, if any.
  final FormaSelectOption<T>? value;

  /// Called with the chosen option, or `null` when cleared.
  final ValueChanged<FormaSelectOption<T>?> onChanged;

  /// Optional label shown above the field.
  final String? label;

  /// Placeholder shown when nothing is selected.
  final String hint;

  /// Message shown when the search returns no results.
  final String emptyText;

  /// Whether the field accepts interaction.
  final bool enabled;

  /// Error message shown below the field in the error color.
  final String? errorText;

  /// Debounce applied between a keystroke and firing [search].
  final Duration debounce;

  @override
  State<FormaCombobox<T>> createState() => _FormaComboboxState<T>();
}

class _FormaComboboxState<T> extends State<FormaCombobox<T>> {
  final OverlayPortalController _portal = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _overlayFocus = FocusNode(
    debugLabel: 'FormaCombobox overlay',
  );

  Timer? _debounceTimer;
  int _requestId = 0;
  List<FormaSelectOption<T>> _results = const [];
  bool _loading = false;
  bool _hasError = false;
  int _highlighted = -1;
  double _triggerWidth = 0;

  bool get _isOpen => _portal.isShowing;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _requestId++; // invalidate any in-flight response
    _searchController.dispose();
    _overlayFocus.dispose();
    super.dispose();
  }

  void _open() {
    if (!widget.enabled || _isOpen) return;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    _triggerWidth = box?.size.width ?? 0;
    _searchController.clear();
    _results = const [];
    _highlighted = -1;
    _portal.show();
    // The search field autofocuses; the overlay Focus still handles arrow /
    // escape keys because they bubble up from the focused field.
    _runSearch('', immediate: true);
    setState(() {});
  }

  void _close() {
    if (!_isOpen) return;
    _debounceTimer?.cancel();
    _portal.hide();
    setState(() {});
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounce, () => _runSearch(query));
  }

  Future<void> _runSearch(String query, {bool immediate = false}) async {
    final requestId = ++_requestId;
    setState(() {
      _loading = true;
      _hasError = false;
    });
    try {
      final results = await widget.search(query);
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _results = results;
        _loading = false;
        _highlighted = results.isEmpty ? -1 : 0;
      });
    } on Object {
      if (!mounted || requestId != _requestId) return;
      setState(() {
        _results = const [];
        _loading = false;
        _hasError = true;
        _highlighted = -1;
      });
    }
  }

  void _select(FormaSelectOption<T> option) {
    if (!option.enabled) return;
    widget.onChanged(option);
    _close();
  }

  void _moveHighlight(int direction) {
    if (_results.isEmpty) return;
    var index = _highlighted;
    for (var i = 0; i < _results.length; i++) {
      index = (index + direction) % _results.length;
      if (index < 0) index += _results.length;
      if (_results[index].enabled) break;
    }
    setState(() => _highlighted = index);
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowDown:
        _moveHighlight(1);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowUp:
        _moveHighlight(-1);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.enter:
      case LogicalKeyboardKey.numpadEnter:
        if (_highlighted >= 0 && _highlighted < _results.length) {
          _select(_results[_highlighted]);
        }
        return KeyEventResult.handled;
      case LogicalKeyboardKey.escape:
        _close();
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final compact = !shape.expandButtons;
    final hasError = widget.errorText != null;

    final trigger = CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _portal,
        overlayChildBuilder: _buildOverlay,
        child: _ComboTriggerBox(
          key: _triggerKey,
          enabled: widget.enabled,
          hasError: hasError,
          open: _isOpen,
          onTap: _open,
          child: Row(
            children: [
              if (widget.value?.leading != null) ...[
                widget.value!.leading!,
                const SizedBox(width: FormaSpacing.sm),
              ],
              Expanded(
                child: Text(
                  widget.value?.label ?? widget.hint,
                  overflow: TextOverflow.ellipsis,
                  style: (compact ? typo.body14 : typo.body16).copyWith(
                    color: widget.value == null
                        ? ext.textHint
                        : ext.textPrimary,
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: 18, color: ext.textMuted),
            ],
          ),
        ),
      ),
    );

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) ...[
            if (compact)
              Text(
                widget.label!,
                style: typo.caption12Med.copyWith(color: ext.textPrimary),
              )
            else
              Text(
                widget.label!.toUpperCase(),
                style: typo.overline10.copyWith(color: ext.textMuted),
              ),
            SizedBox(height: compact ? 6 : FormaSpacing.xs),
          ],
          Semantics(
            button: true,
            enabled: widget.enabled,
            label: widget.label,
            value: widget.value?.label,
            child: trigger,
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: FormaSpacing.xs),
              child: Text(
                widget.errorText!,
                style: typo.caption12.copyWith(color: ext.errorColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _close,
          ),
        ),
        CompositedTransformFollower(
          link: _link,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, FormaSpacing.xs),
          showWhenUnlinked: false,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: _triggerWidth,
              child: Focus(
                focusNode: _overlayFocus,
                onKeyEvent: _handleKey,
                child: Material(
                  color: ext.resolvedSurfaceElevated,
                  elevation: 8,
                  shadowColor: Colors.black.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(shape.dialogRadius),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(FormaSpacing.sm),
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          onChanged: _onQueryChanged,
                          style: typo.body14.copyWith(color: ext.textPrimary),
                          cursorColor: ext.primaryColor,
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 16,
                              color: ext.textMuted,
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 0,
                            ),
                            suffixIcon: _loading
                                ? const Padding(
                                    padding: EdgeInsets.all(FormaSpacing.sm),
                                    child: SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : null,
                            suffixIconConstraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 0,
                            ),
                            hintText: widget.hint,
                            hintStyle: typo.body14.copyWith(
                              color: ext.textHint,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: FormaSpacing.sm,
                            ),
                            filled: true,
                            fillColor: ext.appBackground,
                            border: _searchBorder(ext.border, 1),
                            enabledBorder: _searchBorder(ext.border, 1),
                            focusedBorder: _searchBorder(ext.primaryColor, 1.5),
                          ),
                        ),
                      ),
                      Flexible(child: _buildResults(context, ext, typo)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(
    BuildContext context,
    FormaThemeExtension ext,
    FormaTypographyExtension typo,
  ) {
    if (_hasError) {
      return Padding(
        padding: const EdgeInsets.all(FormaSpacing.base),
        child: Row(
          children: [
            Icon(Icons.error_outline, size: 16, color: ext.errorColor),
            const SizedBox(width: FormaSpacing.sm),
            Text(
              'Erro ao buscar',
              style: typo.caption12.copyWith(color: ext.errorColor),
            ),
          ],
        ),
      );
    }
    if (_loading && _results.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(FormaSpacing.base),
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    if (_results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(FormaSpacing.base),
        child: Text(
          widget.emptyText,
          style: typo.caption12.copyWith(color: ext.textMuted),
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 320),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: FormaSpacing.xs),
        shrinkWrap: true,
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final option = _results[index];
          return _ComboOptionTile(
            option: option,
            selected: option.value == widget.value?.value,
            highlighted: index == _highlighted,
            onHover: () => setState(() => _highlighted = index),
            onTap: () => _select(option),
          );
        },
      ),
    );
  }

  OutlineInputBorder _searchBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

/// The clickable trigger box for the combobox.
class _ComboTriggerBox extends StatefulWidget {
  const _ComboTriggerBox({
    required this.child,
    required this.onTap,
    required this.enabled,
    required this.hasError,
    required this.open,
    super.key,
  });

  final Widget child;
  final VoidCallback onTap;
  final bool enabled;
  final bool hasError;
  final bool open;

  @override
  State<_ComboTriggerBox> createState() => _ComboTriggerBoxState();
}

class _ComboTriggerBoxState extends State<_ComboTriggerBox> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final shape = context.formaShape;

    Color borderColor;
    double borderWidth = 1;
    if (widget.hasError) {
      borderColor = ext.errorColor;
      borderWidth = 1.5;
    } else if (widget.open) {
      borderColor = ext.primaryColor;
      borderWidth = 1.5;
    } else if (_hovered && widget.enabled) {
      borderColor = ext.borderStrong;
    } else {
      borderColor = ext.border;
    }

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: FormaDurations.fade,
          height: shape.inputHeight,
          padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
          decoration: BoxDecoration(
            color: widget.enabled ? ext.cardBackground : ext.appBackground,
            borderRadius: BorderRadius.all(Radius.circular(shape.inputRadius)),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// A single result row inside the combobox overlay.
class _ComboOptionTile<T> extends StatelessWidget {
  const _ComboOptionTile({
    required this.option,
    required this.selected,
    required this.highlighted,
    required this.onTap,
    required this.onHover,
  });

  final FormaSelectOption<T> option;
  final bool selected;
  final bool highlighted;
  final VoidCallback onTap;
  final VoidCallback onHover;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final enabled = option.enabled;

    final bg = highlighted && enabled ? ext.primarySurface : Colors.transparent;
    final labelColor = !enabled
        ? ext.textHint
        : (selected ? ext.primaryColor : ext.textPrimary);

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        if (enabled) onHover();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? onTap : null,
        child: Container(
          color: bg,
          padding: const EdgeInsets.symmetric(
            horizontal: FormaSpacing.md,
            vertical: FormaSpacing.sm,
          ),
          child: Row(
            children: [
              if (option.leading != null) ...[
                option.leading!,
                const SizedBox(width: FormaSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      option.label,
                      overflow: TextOverflow.ellipsis,
                      style: typo.body14.copyWith(color: labelColor),
                    ),
                    if (option.subtitle != null)
                      Text(
                        option.subtitle!,
                        overflow: TextOverflow.ellipsis,
                        style: typo.caption12.copyWith(color: ext.textMuted),
                      ),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check, size: 16, color: ext.primaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
