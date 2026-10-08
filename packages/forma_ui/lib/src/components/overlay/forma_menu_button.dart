import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

import '../display/forma_kbd.dart';

/// A single entry in a [FormaMenuButton] menu, or a divider.
class FormaMenuItem {
  /// Creates a selectable menu item.
  const FormaMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.destructive = false,
    this.enabled = true,
    this.shortcut,
  }) : isDivider = false;

  /// Creates a non-interactive divider between groups of items.
  const FormaMenuItem.divider()
    : label = '',
      onTap = _noop,
      icon = null,
      destructive = false,
      enabled = false,
      shortcut = null,
      isDivider = true;

  /// Item label.
  final String label;

  /// Selection callback.
  final VoidCallback onTap;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether the item uses the destructive ([FormaThemeExtension.errorColor])
  /// treatment.
  final bool destructive;

  /// Whether the item can be selected.
  final bool enabled;

  /// Optional trailing shortcut hint (rendered as a [FormaKbd]).
  final String? shortcut;

  /// Whether this item is a divider rather than a selectable row.
  final bool isDivider;

  static void _noop() {}
}

/// A compact dropdown menu triggered by an icon button or a custom [builder].
///
/// Built on Material's [MenuAnchor] for free keyboard traversal and dismissal.
/// Items render at a compact 34px row height, with an optional icon, a shortcut
/// hint, and a destructive style in [FormaThemeExtension.errorColor].
class FormaMenuButton extends StatelessWidget {
  /// Creates a [FormaMenuButton].
  const FormaMenuButton({
    required this.items,
    this.icon = Icons.more_horiz,
    this.tooltip,
    this.builder,
    super.key,
  });

  /// The menu entries (items and dividers).
  final List<FormaMenuItem> items;

  /// Icon for the default trigger button. Ignored when [builder] is provided.
  final IconData icon;

  /// Tooltip for the default trigger button.
  final String? tooltip;

  /// Builds a custom trigger. Receives an `open` callback to toggle the menu.
  final Widget Function(BuildContext context, VoidCallback open)? builder;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(
          ext.resolvedSurfaceElevated,
        ),
        surfaceTintColor: const WidgetStatePropertyAll<Color>(
          Colors.transparent,
        ),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(vertical: FormaSpacing.xs),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(FormaRadius.small),
            ),
            side: BorderSide(color: ext.border),
          ),
        ),
      ),
      menuChildren: [
        for (final item in items)
          if (item.isDivider)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: FormaSpacing.xs),
              child: Divider(height: 1, thickness: 1, color: ext.border),
            )
          else
            _MenuRow(item: item),
      ],
      builder: (context, controller, _) {
        void toggle() {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        }

        if (builder != null) {
          return builder!(context, toggle);
        }

        return Semantics(
          button: true,
          label: tooltip ?? 'Mais opções',
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              icon: Icon(icon, size: 20),
              color: ext.textMuted,
              tooltip: tooltip,
              visualDensity: VisualDensity.compact,
              onPressed: toggle,
            ),
          ),
        );
      },
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item});

  final FormaMenuItem item;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final foreground = !item.enabled
        ? ext.textHint
        : item.destructive
        ? ext.errorColor
        : ext.textPrimary;

    return MenuItemButton(
      onPressed: item.enabled ? item.onTap : null,
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll<Size>(Size(160, 34)),
        fixedSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(34)),
        padding: const WidgetStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: FormaSpacing.md),
        ),
        overlayColor: WidgetStatePropertyAll<Color>(
          (item.destructive ? ext.errorColor : ext.primaryColor).withValues(
            alpha: 0.08,
          ),
        ),
      ),
      // No Expanded/Spacer here: MenuAnchor wraps items in an IntrinsicWidth,
      // which cannot measure flex children. A fixed gap right-pads the shortcut
      // while the row still sizes to its content.
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(item.icon, size: 18, color: foreground),
            const SizedBox(width: FormaSpacing.md),
          ],
          Text(item.label, style: typo.body14.copyWith(color: foreground)),
          if (item.shortcut != null) ...[
            const SizedBox(width: FormaSpacing.xl),
            FormaKbd(item.shortcut!),
          ],
        ],
      ),
    );
  }
}
