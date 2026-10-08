import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact, desktop-styled date field.
///
/// Renders a read-only field (matching [FormaThemeExtension]-driven text-field
/// styling) that opens the platform [showDatePicker] when tapped. The selected
/// date is formatted as `dd/MM/yyyy`. A calendar icon is shown as the trailing
/// affordance; when [clearable] is true and a [value] is set, a clear "x"
/// button lets the user reset the field.
///
/// The picker is themed by the ambient [Theme], so it inherits the app's
/// colors automatically.
class FormaDateField extends StatelessWidget {
  /// Creates a [FormaDateField].
  const FormaDateField({
    required this.onChanged,
    this.value,
    this.label,
    this.hint = 'dd/mm/aaaa',
    this.firstDate,
    this.lastDate,
    this.enabled = true,
    this.clearable = true,
    this.errorText,
    super.key,
  });

  /// The currently selected date, if any.
  final DateTime? value;

  /// Called with the newly selected date, or `null` when cleared.
  final ValueChanged<DateTime?> onChanged;

  /// Optional label shown above the field.
  final String? label;

  /// Placeholder shown when no date is selected.
  final String hint;

  /// Earliest selectable date. Defaults to 100 years before today.
  final DateTime? firstDate;

  /// Latest selectable date. Defaults to 100 years after today.
  final DateTime? lastDate;

  /// Whether the field accepts interaction.
  final bool enabled;

  /// Whether a clear "x" button is shown when a [value] is set.
  final bool clearable;

  /// Error message shown below the field in the error color.
  final String? errorText;

  /// Formats [date] as `dd/MM/yyyy`.
  static String formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 100),
      lastDate: lastDate ?? DateTime(now.year + 100),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final compact = !shape.expandButtons;
    final hasError = errorText != null;
    final hasValue = value != null;

    final textStyle = compact ? typo.body14 : typo.body16;

    final field = _FieldBox(
      enabled: enabled,
      hasError: hasError,
      onTap: enabled ? () => _pick(context) : null,
      child: Row(
        children: [
          Expanded(
            child: Text(
              hasValue ? formatDate(value!) : hint,
              style: textStyle.copyWith(
                color: !enabled
                    ? ext.textHint
                    : hasValue
                    ? ext.textPrimary
                    : ext.textHint,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (clearable && hasValue && enabled)
            _IconAction(
              icon: Icons.close,
              tooltip: 'Limpar',
              onTap: () => onChanged(null),
            )
          else
            Icon(Icons.calendar_today_outlined, size: 16, color: ext.textMuted),
        ],
      ),
    );

    return Column(
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
        Semantics(
          button: true,
          enabled: enabled,
          label: label,
          value: hasValue ? formatDate(value!) : null,
          child: field,
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: FormaSpacing.xs),
            child: Text(
              errorText!,
              style: typo.caption12.copyWith(color: ext.errorColor),
            ),
          ),
      ],
    );
  }
}

/// Shared read-only field-box look used by desktop picker-style inputs.
class _FieldBox extends StatefulWidget {
  const _FieldBox({
    required this.child,
    required this.onTap,
    required this.enabled,
    required this.hasError,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final bool hasError;

  @override
  State<_FieldBox> createState() => _FieldBoxState();
}

class _FieldBoxState extends State<_FieldBox> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final shape = context.formaShape;

    Color borderColor;
    double borderWidth = 1;
    if (widget.hasError) {
      borderColor = ext.errorColor;
      borderWidth = 1.5;
    } else if (_focused) {
      borderColor = ext.primaryColor;
      borderWidth = 1.5;
    } else if (_hovered && widget.enabled) {
      borderColor = ext.borderStrong;
    } else {
      borderColor = ext.border;
    }

    return FocusableActionDetector(
      enabled: widget.enabled,
      mouseCursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onShowHoverHighlight: (v) => setState(() => _hovered = v),
      onShowFocusHighlight: (v) => setState(() => _focused = v),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
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

/// A small trailing icon button used inside field boxes (clear, etc.).
class _IconAction extends StatelessWidget {
  const _IconAction({
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
            padding: const EdgeInsets.only(left: FormaSpacing.xs),
            child: Icon(icon, size: 16, color: ext.textMuted),
          ),
        ),
      ),
    );
  }
}
