import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact, desktop-styled numeric input with pt-BR formatting.
///
/// Accepts digits and a comma decimal separator (Brazilian convention),
/// optionally clamps to [min]/[max] when focus leaves, and can show
/// [prefixText] (e.g. `R$`) / [suffixText] (e.g. `%`, `g`, `min`). When [step]
/// is non-null, up/down stepper chevrons are rendered.
///
/// The widget keeps its own [TextEditingController] in sync with external
/// [value] changes without clobbering the caret while the field is focused.
class FormaNumberField extends StatefulWidget {
  /// Creates a [FormaNumberField].
  const FormaNumberField({
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.decimals = 0,
    this.min,
    this.max,
    this.prefixText,
    this.suffixText,
    this.step,
    this.enabled = true,
    this.errorText,
    this.helperText,
    super.key,
  });

  /// The current numeric value, or null when empty.
  final num? value;

  /// Called with the parsed value on every edit, and with the clamped value
  /// when focus leaves.
  final ValueChanged<num?> onChanged;

  /// Optional label shown above the field.
  final String? label;

  /// Placeholder shown when empty.
  final String? hint;

  /// Number of decimal places accepted / displayed.
  final int decimals;

  /// Minimum allowed value (clamped on blur).
  final num? min;

  /// Maximum allowed value (clamped on blur).
  final num? max;

  /// Text shown before the number (e.g. `R$`).
  final String? prefixText;

  /// Text shown after the number (e.g. `%`, `g`, `min`).
  final String? suffixText;

  /// Increment applied by the stepper chevrons. When null, no stepper is shown.
  final num? step;

  /// Whether the field accepts input.
  final bool enabled;

  /// Error message shown below the field in the error color.
  final String? errorText;

  /// Helper message shown below the field when there is no [errorText].
  final String? helperText;

  @override
  State<FormaNumberField> createState() => _FormaNumberFieldState();
}

class _FormaNumberFieldState extends State<FormaNumberField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(FormaNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync external value changes only while unfocused, to avoid moving the
    // caret or fighting the user's in-progress edit.
    if (!_focusNode.hasFocus && widget.value != _parse(_controller.text)) {
      final text = _format(widget.value);
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) return;
    // On blur: clamp and reformat.
    final parsed = _parse(_controller.text);
    final clamped = _clamp(parsed);
    _controller.text = _format(clamped);
    if (clamped != parsed) widget.onChanged(clamped);
    setState(() {});
  }

  String _format(num? value) {
    if (value == null) return '';
    if (widget.decimals > 0) {
      return value.toStringAsFixed(widget.decimals).replaceAll('.', ',');
    }
    return value.round().toString();
  }

  num? _parse(String text) {
    if (text.trim().isEmpty) return null;
    // pt-BR: '.' is a thousands separator, ',' is the decimal separator.
    final normalized = text.replaceAll('.', '').replaceAll(',', '.');
    return num.tryParse(normalized);
  }

  num? _clamp(num? value) {
    if (value == null) return null;
    var result = value;
    final min = widget.min;
    final max = widget.max;
    if (min != null && result < min) result = min;
    if (max != null && result > max) result = max;
    return result;
  }

  void _onTextChanged(String text) => widget.onChanged(_parse(text));

  void _bump(num delta) {
    final current = _parse(_controller.text) ?? 0;
    final next = _clamp(current + delta);
    final text = _format(next);
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    widget.onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final compact = !shape.expandButtons;
    final hasError = widget.errorText != null;
    final textStyle = (compact ? typo.body14 : typo.body16).copyWith(
      color: widget.enabled ? ext.textPrimary : ext.textHint,
    );

    final allowNegative = (widget.min ?? 0) < 0;
    final pattern = allowNegative ? r'[0-9.,-]' : r'[0-9.,]';

    final field = TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(pattern))],
      style: textStyle,
      cursorColor: ext.primaryColor,
      onChanged: _onTextChanged,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: widget.enabled ? ext.cardBackground : ext.appBackground,
        hintText: widget.hint,
        hintStyle: textStyle.copyWith(color: ext.textHint),
        prefixText: widget.prefixText,
        prefixStyle: textStyle.copyWith(color: ext.textMuted),
        suffixText: widget.suffixText,
        suffixStyle: textStyle.copyWith(color: ext.textMuted),
        suffixIcon: widget.step != null ? _buildStepper(ext) : null,
        suffixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: FormaSpacing.md,
          vertical: 10,
        ),
        constraints: BoxConstraints(minHeight: shape.inputHeight),
        border: _border(ext.border, 1, shape.inputRadius),
        enabledBorder: _border(ext.border, 1, shape.inputRadius),
        focusedBorder: _border(ext.primaryColor, 1.5, shape.inputRadius),
        disabledBorder: _border(ext.border, 1, shape.inputRadius),
        errorBorder: _border(ext.errorColor, 1.5, shape.inputRadius),
        focusedErrorBorder: _border(ext.errorColor, 1.5, shape.inputRadius),
        errorText: hasError ? widget.errorText : null,
        errorStyle: typo.caption12.copyWith(color: ext.errorColor),
        helperText: hasError ? null : widget.helperText,
        helperStyle: typo.caption12.copyWith(color: ext.textMuted),
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
        field,
      ],
    );
  }

  Widget _buildStepper(FormaThemeExtension ext) {
    final step = widget.step!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepButton(
          icon: Icons.keyboard_arrow_up,
          onTap: widget.enabled ? () => _bump(step) : null,
          color: ext.textMuted,
        ),
        _StepButton(
          icon: Icons.keyboard_arrow_down,
          onTap: widget.enabled ? () => _bump(-step) : null,
          color: ext.textMuted,
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color, double width, double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

/// A single stepper chevron button.
class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 24,
          height: 16,
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}
