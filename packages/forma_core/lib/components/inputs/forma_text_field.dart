import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_radius.dart';
import '../../tokens/forma_spacing.dart';
import '../../tokens/forma_typography.dart';

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

  static const double _minHeight = 56;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    final decoration = InputDecoration(
      hintText: hint,
      hintStyle: FormaTypography.body16.copyWith(color: ext.textHint),
      prefixIcon: prefix,
      suffixIcon: suffix,
      enabled: enabled,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: FormaSpacing.base,
        vertical: FormaSpacing.md,
      ),
      constraints: const BoxConstraints(minHeight: _minHeight),
      border: _buildBorder(ext.border, 0.5),
      enabledBorder: _buildBorder(ext.border, 0.5),
      focusedBorder: _buildBorder(ext.primaryColor, 2),
      errorBorder: _buildBorder(ext.errorColor, 2),
      focusedErrorBorder: _buildBorder(ext.errorColor, 2),
      disabledBorder: _buildBorder(ext.border, 0.5),
      errorStyle: FormaTypography.caption12.copyWith(color: ext.errorColor),
    );

    final field = TextFormField(
      controller: controller,
      validator: validator,
      decoration: decoration,
      style: FormaTypography.body16.copyWith(color: ext.textPrimary),
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      enabled: enabled,
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label!.toUpperCase(),
          style: FormaTypography.overline10.copyWith(color: ext.textMuted),
        ),
        const SizedBox(height: FormaSpacing.xs),
        field,
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(FormaRadius.input)),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
