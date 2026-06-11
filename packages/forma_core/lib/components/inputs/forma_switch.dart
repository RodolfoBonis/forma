import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_durations.dart';

/// A themed on/off switch.
///
/// The track uses [FormaThemeExtension.primaryColor] when on and a muted
/// surface when off; the thumb slides between the two states.
class FormaSwitch extends StatelessWidget {
  /// Creates a [FormaSwitch].
  const FormaSwitch({
    required this.value,
    required this.onChanged,
    this.semanticLabel,
    super.key,
  });

  /// Whether the switch is on.
  final bool value;

  /// Called with the new value when toggled. When null, the switch is
  /// disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional accessibility label.
  final String? semanticLabel;

  static const double _width = 52;
  static const double _height = 30;
  static const double _thumbSize = 24;
  static const double _padding = 3;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final enabled = onChanged != null;
    final trackColor = value ? ext.primaryColor : ext.borderStrong;

    return Semantics(
      toggled: value,
      label: semanticLabel,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: enabled ? () => onChanged!(!value) : null,
          child: AnimatedContainer(
            duration: FormaDurations.fade,
            width: _width,
            height: _height,
            padding: const EdgeInsets.all(_padding),
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(_height / 2),
              ),
            ),
            child: AnimatedAlign(
              duration: FormaDurations.fade,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: _thumbSize,
                height: _thumbSize,
                decoration: BoxDecoration(
                  color: value ? ext.resolvedOnPrimary : ext.textMuted,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
