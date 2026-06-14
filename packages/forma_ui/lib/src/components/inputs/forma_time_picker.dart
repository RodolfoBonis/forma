import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A styled time picker field that opens [showTimePicker] on tap.
///
/// Displays the selected [value] formatted as HH:mm, or a placeholder
/// when no time is selected.
class FormaTimePicker extends StatelessWidget {
  /// Creates a [FormaTimePicker].
  const FormaTimePicker({this.label, this.value, this.onChanged, super.key});

  /// Overline label displayed above the field.
  final String? label;

  /// Currently selected time.
  final TimeOfDay? value;

  /// Called when the user picks a new time.
  final ValueChanged<TimeOfDay>? onChanged;

  static const double _minHeight = 56;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    final typo = context.formaTypography;
    final displayText = value != null ? value!.format(context) : '--:--';

    final field = Semantics(
      button: true,
      label: label ?? 'Time picker',
      child: GestureDetector(
        onTap: () => _pickTime(context),
        child: Container(
          constraints: const BoxConstraints(minHeight: _minHeight),
          padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.base),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(FormaRadius.input),
            ),
            border: Border.all(color: ext.border, width: 0.5),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  displayText,
                  style: typo.body16.copyWith(
                    color: value != null ? ext.textPrimary : ext.textHint,
                  ),
                ),
              ),
              Icon(Icons.access_time, color: ext.textMuted, size: 20),
            ],
          ),
        ),
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!.toUpperCase(),
          style: typo.overline10.copyWith(color: ext.textMuted),
        ),
        const SizedBox(height: FormaSpacing.xs),
        field,
      ],
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      onChanged?.call(picked);
    }
  }
}
