import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A two-option segmented toggle following Forma Design System specs.
///
/// Exactly two [options] must be provided.
class FormaModeToggle extends StatelessWidget {
  /// Creates a [FormaModeToggle].
  const FormaModeToggle({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
  }) : assert(
         options.length == 2,
         'FormaModeToggle requires exactly 2 options',
       );

  /// The two option labels.
  final List<String> options;

  /// Index of the currently selected option (0 or 1).
  final int selectedIndex;

  /// Called when the selection changes.
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    final typo = context.formaTypography;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: ext.appBackground,
        border: Border.all(color: ext.border),
        borderRadius: BorderRadius.circular(FormaRadius.large),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;

          return Expanded(
            child: Semantics(
              label: options[index],
              selected: isSelected,
              button: true,
              child: GestureDetector(
                onTap: () => onChanged(index),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? ext.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    options[index],
                    style: (isSelected ? typo.body14Medium : typo.body14)
                        .copyWith(
                          color: isSelected ? Colors.white : ext.textMuted,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                        ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
