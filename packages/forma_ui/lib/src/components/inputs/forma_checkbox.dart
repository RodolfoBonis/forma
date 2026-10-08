import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact, desktop-styled checkbox with an optional label and description.
///
/// Renders a custom 16px rounded box that animates to [FormaThemeExtension]'s
/// `primaryColor` with a white check when [value] is true. The whole row
/// (box + text) is clickable, focusable and keyboard-operable (Space / Enter),
/// shows a hover highlight, a visible focus ring and a click cursor.
///
/// Pass `null` to [onChanged] to render the control disabled.
class FormaCheckbox extends StatefulWidget {
  /// Creates a [FormaCheckbox].
  const FormaCheckbox({
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
    this.enabled = true,
    super.key,
  });

  /// Whether the checkbox is currently checked.
  final bool value;

  /// Called with the new value when the user toggles the checkbox.
  ///
  /// When `null` the checkbox is disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional primary label shown next to the box.
  final String? label;

  /// Optional secondary description shown beneath the [label].
  final String? description;

  /// Whether the checkbox accepts interaction. Also disabled when [onChanged]
  /// is `null`.
  final bool enabled;

  @override
  State<FormaCheckbox> createState() => _FormaCheckboxState();
}

class _FormaCheckboxState extends State<FormaCheckbox> {
  bool _hovered = false;
  bool _focused = false;

  bool get _enabled => widget.enabled && widget.onChanged != null;

  void _toggle() {
    if (!_enabled) return;
    widget.onChanged!(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final checked = widget.value;
    final boxColor = checked
        ? (_enabled ? ext.primaryColor : ext.textHint)
        : ext.cardBackground;
    final borderColor = checked
        ? (_enabled ? ext.primaryColor : ext.textHint)
        : (_hovered && _enabled ? ext.primaryColor : ext.borderStrong);

    final box = AnimatedContainer(
      duration: FormaDurations.fade,
      curve: Curves.easeOut,
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(FormaRadius.subtle),
        ),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: AnimatedOpacity(
        duration: FormaDurations.fade,
        opacity: checked ? 1 : 0,
        child: const Icon(Icons.check, size: 12, color: Colors.white),
      ),
    );

    final texts = <Widget>[
      if (widget.label != null)
        Text(
          widget.label!,
          style: typo.body14.copyWith(
            color: _enabled ? ext.textPrimary : ext.textHint,
          ),
        ),
      if (widget.description != null)
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            widget.description!,
            style: typo.caption12.copyWith(color: ext.textMuted),
          ),
        ),
    ];

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(top: 1), child: box),
        if (texts.isNotEmpty) ...[
          const SizedBox(width: FormaSpacing.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: texts,
            ),
          ),
        ],
      ],
    );

    return Semantics(
      checked: checked,
      enabled: _enabled,
      label: widget.label,
      container: true,
      child: FocusableActionDetector(
        enabled: _enabled,
        mouseCursor: _enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onShowHoverHighlight: (v) => setState(() => _hovered = v),
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _toggle();
              return null;
            },
          ),
        },
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: Container(
            padding: const EdgeInsets.all(FormaSpacing.xs),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(FormaRadius.subtle),
              ),
              border: Border.all(
                color: _focused ? ext.primaryColor : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: row,
          ),
        ),
      ),
    );
  }
}
