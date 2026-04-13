import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_typography.dart';

/// A single navigation item for [FormaBottomNav].
class FormaNavItem {
  /// Creates a navigation item with the given [label] and [icon].
  const FormaNavItem({
    required this.label,
    required this.icon,
  });

  /// Display label shown below the icon.
  final String label;

  /// Icon displayed for this navigation item.
  final IconData icon;
}

/// A bottom navigation bar following Forma Design System specs.
///
/// Displays a row of [FormaNavItem]s with an active indicator dot
/// above the selected item's icon.
class FormaBottomNav extends StatelessWidget {
  /// Creates a [FormaBottomNav].
  const FormaBottomNav({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required this.items,
  });

  /// The index of the currently active item.
  final int activeIndex;

  /// Called when an item is tapped with the item's index.
  final void Function(int) onTap;

  /// Navigation items to display.
  final List<FormaNavItem> items;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: ext.cardBackground,
        border: Border(
          top: BorderSide(color: ext.border, width: 0.5),
        ),
      ),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == activeIndex;

          return Expanded(
            child: Semantics(
              label: item.label,
              selected: isActive,
              button: true,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Active indicator dot
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: isActive ? ext.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Icon(
                      item.icon,
                      color: isActive ? ext.primaryColor : ext.textMuted,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: (isActive
                              ? FormaTypography.nav10Bold
                              : FormaTypography.nav10)
                          .copyWith(
                        color: isActive ? ext.primaryColor : ext.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
