import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A themed text field for the Forma Design System.
///
/// Renders an optional overline [label] above the input field (not a floating
/// label). Supports [validator], [prefix]/[suffix] widgets, and
/// [obscureText] for password entry.
class FormaTextField extends StatelessWidget {
  /// Creates a [FormaTextField].
  const FormaTextField({
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.prefix,
    this.suffix,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.textInputAction,
    this.autofillHints,
    this.helperText,
    this.minLines,
    super.key,
  });

  /// Overline label displayed above the input.
  final String? label;

  /// Placeholder text shown when the field is empty.
  final String? hint;

  /// Text editing controller.
  final TextEditingController? controller;

  /// Validation function returning an error string or null.
  final String? Function(String?)? validator;

  /// Widget displayed before the input text.
  final Widget? prefix;

  /// Widget displayed after the input text.
  final Widget? suffix;

  /// Whether the field accepts input.
  final bool enabled;

  /// Keyboard type for the input.
  final TextInputType keyboardType;

  /// Whether to obscure the text (e.g. for passwords).
  final bool obscureText;

  /// Maximum number of visible lines.
  final int? maxLines;

  /// Text capitalization behavior.
  final TextCapitalization textCapitalization;

  /// Called on every edit.
  final ValueChanged<String>? onChanged;

  /// Called when the user submits (e.g. presses Enter).
  final ValueChanged<String>? onSubmitted;

  /// Optional focus node.
  final FocusNode? focusNode;

  /// Whether the field grabs focus when first built.
  final bool autofocus;

  /// Whether the text can be edited (the field stays focusable).
  final bool readOnly;

  /// Called when the field is tapped.
  final VoidCallback? onTap;

  /// Input formatters (masks, digit filters…).
  final List<TextInputFormatter>? inputFormatters;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Autofill hints (email, password…).
  final Iterable<String>? autofillHints;

  /// Helper text displayed below the input.
  final String? helperText;

  /// Minimum number of visible lines.
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;
    final compact = !shape.expandButtons;
    final textStyle = compact ? typo.body14 : typo.body16;

    final decoration = InputDecoration(
      hintText: hint,
      hintStyle: textStyle.copyWith(color: ext.textHint),
      prefixIcon: prefix,
      suffixIcon: suffix,
      enabled: enabled,
      isDense: compact,
      filled: compact,
      fillColor: ext.cardBackground,
      contentPadding: EdgeInsets.symmetric(
        horizontal: compact ? FormaSpacing.md : FormaSpacing.base,
        vertical: compact ? 10 : FormaSpacing.md,
      ),
      constraints: BoxConstraints(minHeight: shape.inputHeight),
      border: _buildBorder(ext.border, compact ? 1 : 0.5, shape.inputRadius),
      enabledBorder: _buildBorder(
        ext.border,
        compact ? 1 : 0.5,
        shape.inputRadius,
      ),
      focusedBorder: _buildBorder(
        ext.primaryColor,
        compact ? 1.5 : 2,
        shape.inputRadius,
      ),
      errorBorder: _buildBorder(
        ext.errorColor,
        compact ? 1.5 : 2,
        shape.inputRadius,
      ),
      focusedErrorBorder: _buildBorder(
        ext.errorColor,
        compact ? 1.5 : 2,
        shape.inputRadius,
      ),
      disabledBorder: _buildBorder(ext.border, 0.5, shape.inputRadius),
      errorStyle: typo.caption12.copyWith(color: ext.errorColor),
      helperText: helperText,
      helperStyle: typo.caption12.copyWith(color: ext.textMuted),
    );

    final field = TextFormField(
      controller: controller,
      validator: validator,
      decoration: decoration,
      style: textStyle.copyWith(color: ext.textPrimary),
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      minLines: minLines,
      cursorColor: ext.primaryColor,
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
        field,
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width, double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
