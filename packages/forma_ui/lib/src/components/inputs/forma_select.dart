import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A single option for a [FormaSelect] (and [FormaCombobox]).
class FormaSelectOption<T> {
  /// Creates a [FormaSelectOption].
  const FormaSelectOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.leading,
    this.enabled = true,
  });

  /// The value returned when the option is chosen.
  final T value;

  /// The primary text shown for the option.
  final String label;

  /// Optional secondary text shown beneath the [label].
  final String? subtitle;

  /// Optional leading widget (e.g. an icon or avatar).
  final Widget? leading;

  /// Whether the option can be selected.
  final bool enabled;
}

/// A compact, desktop-styled select (dropdown) field.
///
/// Looks like a [FormaThemeExtension]-driven text field with a chevron. Tapping
/// it opens an anchored overlay listing the [options], with a checkmark on the
/// selected one, hover + keyboard highlighting (↑/↓/Enter/Esc), an optional
/// search box (when [searchable]) and an optional clear button (when
/// [clearable] and a value is set). [errorText] renders below in the error
/// color.
class FormaSelect<T> extends StatefulWidget {
  /// Creates a [FormaSelect].
  const FormaSelect({
    required this.options,
    required this.onChanged,
    this.value,
    this.label,
    this.hint = 'Selecione…',
    this.searchable = false,
    this.enabled = true,
    this.clearable = false,
    this.errorText,
    this.width,
    super.key,
  });

  /// The available options.
  final List<FormaSelectOption<T>> options;

  /// Called with the chosen value, or `null` when cleared.
  final ValueChanged<T?> onChanged;

  /// The currently selected value, if any.
  final T? value;

  /// Optional label shown above the field.
  final String? label;

  /// Placeholder shown when nothing is selected.
  final String hint;

  /// Whether a search box filters the options.
  final bool searchable;

  /// Whether the field accepts interaction.
  final bool enabled;

  /// Whether a clear "x" button is shown when a value is set.
  final bool clearable;

  /// Error message shown below the field in the error color.
  final String? errorText;

  /// Fixed field width. When null the field fills its parent.
  final double? width;

  @override
  State<FormaSelect<T>> createState() => _FormaSelectState<T>();
}

class _FormaSelectState<T> extends State<FormaSelect<T>> {
  final OverlayPortalController _portal = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final GlobalKey _triggerKey = GlobalKey();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _overlayFocus = FocusNode(debugLabel: 'FormaSelect overlay');

  int _highlighted = -1;
  String _query = '';
  double _triggerWidth = 0;

  bool get _isOpen => _portal.isShowing;

  List<FormaSelectOption<T>> get _filtered {
    if (!widget.searchable || _query.isEmpty) return widget.options;
    final q = _query.toLowerCase();
    return widget.options
        .where((o) => o.label.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _overlayFocus.dispose();
    super.dispose();
  }

  void _open() {
    if (!widget.enabled || _isOpen) return;
    final box = _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    _triggerWidth = box?.size.width ?? 0;
    _query = '';
    _searchController.clear();
    _highlighted = widget.options.indexWhere((o) => o.value == widget.value);
    _portal.show();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // When searchable, the search field autofocuses; grabbing overlay focus
      // here would steal it. Only focus the overlay for keyboard-only lists.
      if (!widget.searchable) _overlayFocus.requestFocus();
    });
    setState(() {});
  }

  void _close() {
    if (!_isOpen) return;
    _portal.hide();
    setState(() {});
  }

  void _select(FormaSelectOption<T> option) {
    if (!option.enabled) return;
    widget.onChanged(option.value);
    _close();
  }

  void _moveHighlight(int direction) {
    final options = _filtered;
    if (options.isEmpty) return;
    var index = _highlighted;
    for (var i = 0; i < options.length; i++) {
      index = (index + direction) % options.length;
      if (index < 0) index += options.length;
      if (options[index].enabled) break;
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
        final options = _filtered;
        if (_highlighted >= 0 && _highlighted < options.length) {
          _select(options[_highlighted]);
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

    final selected = widget.options
        .where((o) => o.value == widget.value)
        .cast<FormaSelectOption<T>?>()
        .firstWhere((o) => true, orElse: () => null);

    final field = CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _portal,
        overlayChildBuilder: _buildOverlay,
        child: _TriggerBox(
          key: _triggerKey,
          enabled: widget.enabled,
          hasError: hasError,
          open: _isOpen,
          onTap: _open,
          child: Row(
            children: [
              if (selected?.leading != null) ...[
                selected!.leading!,
                const SizedBox(width: FormaSpacing.sm),
              ],
              Expanded(
                child: Text(
                  selected?.label ?? widget.hint,
                  overflow: TextOverflow.ellipsis,
                  style: (compact ? typo.body14 : typo.body16).copyWith(
                    color: selected == null ? ext.textHint : ext.textPrimary,
                  ),
                ),
              ),
              if (widget.clearable &&
                  widget.value != null &&
                  widget.enabled) ...[
                _IconTap(
                  icon: Icons.close,
                  tooltip: 'Limpar',
                  onTap: () => widget.onChanged(null),
                ),
                const SizedBox(width: FormaSpacing.xs),
              ],
              AnimatedRotation(
                turns: _isOpen ? 0.5 : 0,
                duration: FormaDurations.fade,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: ext.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return _LabeledField(
      label: widget.label,
      errorText: widget.errorText,
      width: widget.width,
      child: Semantics(
        button: true,
        enabled: widget.enabled,
        label: widget.label,
        value: selected?.label,
        child: field,
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final options = _filtered;

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
                      if (widget.searchable)
                        _OverlaySearchField(
                          controller: _searchController,
                          onChanged: (v) => setState(() {
                            _query = v;
                            _highlighted = _filtered.isEmpty ? -1 : 0;
                          }),
                          onSubmitted: () {
                            final opts = _filtered;
                            if (_highlighted >= 0 &&
                                _highlighted < opts.length) {
                              _select(opts[_highlighted]);
                            }
                          },
                        ),
                      Flexible(
                        child: options.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(
                                  FormaSpacing.base,
                                ),
                                child: Text(
                                  'Nenhum resultado',
                                  style: typo.caption12.copyWith(
                                    color: ext.textMuted,
                                  ),
                                ),
                              )
                            : ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 320,
                                ),
                                child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: FormaSpacing.xs,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final option = options[index];
                                    return _OptionTile(
                                      label: option.label,
                                      subtitle: option.subtitle,
                                      leading: option.leading,
                                      selected: option.value == widget.value,
                                      highlighted: index == _highlighted,
                                      enabled: option.enabled,
                                      onHover: () =>
                                          setState(() => _highlighted = index),
                                      onTap: () => _select(option),
                                    );
                                  },
                                ),
                              ),
                      ),
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
}

/// The clickable field box shared by select-style triggers.
class _TriggerBox extends StatefulWidget {
  const _TriggerBox({
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
  State<_TriggerBox> createState() => _TriggerBoxState();
}

class _TriggerBoxState extends State<_TriggerBox> {
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

/// A single option row inside the overlay list.
class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.highlighted,
    required this.enabled,
    required this.onTap,
    required this.onHover,
    this.subtitle,
    this.leading,
  });

  final String label;
  final String? subtitle;
  final Widget? leading;
  final bool selected;
  final bool highlighted;
  final bool enabled;
  final VoidCallback onTap;
  final VoidCallback onHover;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

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
              if (leading != null) ...[
                leading!,
                const SizedBox(width: FormaSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: typo.body14.copyWith(color: labelColor),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
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

/// The search box shown at the top of a searchable overlay.
class _OverlaySearchField extends StatelessWidget {
  const _OverlaySearchField({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Padding(
      padding: const EdgeInsets.all(FormaSpacing.sm),
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: onChanged,
        onSubmitted: (_) => onSubmitted(),
        style: typo.body14.copyWith(color: ext.textPrimary),
        cursorColor: ext.primaryColor,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(Icons.search, size: 16, color: ext.textMuted),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 32,
            minHeight: 0,
          ),
          hintText: 'Buscar…',
          hintStyle: typo.body14.copyWith(color: ext.textHint),
          contentPadding: const EdgeInsets.symmetric(vertical: FormaSpacing.sm),
          filled: true,
          fillColor: ext.appBackground,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: ext.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: ext.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: ext.primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}

/// Wraps a field with an optional label above and error text below.
class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.child,
    required this.label,
    required this.errorText,
    required this.width,
  });

  final Widget child;
  final String? label;
  final String? errorText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final compact = !context.formaShape.expandButtons;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            if (compact)
              Text(
                label!,
                style: typo.caption12Med.copyWith(color: ext.textPrimary),
              )
            else
              Text(
                label!.toUpperCase(),
                style: typo.overline10.copyWith(color: ext.textMuted),
              ),
            SizedBox(height: compact ? 6 : FormaSpacing.xs),
          ],
          child,
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: FormaSpacing.xs),
              child: Text(
                errorText!,
                style: typo.caption12.copyWith(color: ext.errorColor),
              ),
            ),
        ],
      ),
    );
  }
}

/// A small inline icon action (e.g. the clear button).
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
          child: Icon(icon, size: 16, color: ext.textMuted),
        ),
      ),
    );
  }
}
