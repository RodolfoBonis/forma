import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Color treatment for a [FormaSidebarItem] badge.
enum FormaSidebarBadgeVariant {
  /// Neutral / informational badge (muted surface).
  neutral,

  /// Primary-tinted badge.
  primary,

  /// Warning-tinted badge.
  warning,

  /// Error / destructive badge.
  error,
}

/// A single navigation entry inside a [FormaSidebarSection].
class FormaSidebarItem {
  /// Creates a [FormaSidebarItem].
  const FormaSidebarItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
    this.badge,
    this.badgeVariant = FormaSidebarBadgeVariant.neutral,
  });

  /// Leading glyph.
  final IconData icon;

  /// Entry label. Hidden (icon-only) when the sidebar is collapsed.
  final String label;

  /// Whether this entry is the active destination.
  final bool selected;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Optional trailing badge text (e.g. a count). Hidden when collapsed.
  final String? badge;

  /// Color treatment for [badge].
  final FormaSidebarBadgeVariant badgeVariant;
}

/// A titled group of [FormaSidebarItem]s.
class FormaSidebarSection {
  /// Creates a [FormaSidebarSection].
  const FormaSidebarSection({required this.items, this.title});

  /// Optional section heading, rendered as a small muted caption. Hidden when
  /// the sidebar is collapsed.
  final String? title;

  /// The entries in this section.
  final List<FormaSidebarItem> items;
}

/// A collapsible desktop navigation sidebar.
///
/// Renders [sections] of [FormaSidebarItem]s between an optional [header] and
/// [footer]. Animates between [expandedWidth] and [collapsedWidth]; when
/// collapsed it shows icons only, each wrapped in a [Tooltip] carrying its
/// label. The selected item gets a [FormaThemeExtension.primarySurface] pill
/// with [FormaThemeExtension.primaryColor] icon and text. Painted on
/// [FormaThemeExtension.cardBackground] with a right [FormaThemeExtension.border]
/// and a bottom chevron toggle when [onToggleCollapsed] is provided.
class FormaSidebar extends StatelessWidget {
  /// Creates a [FormaSidebar].
  const FormaSidebar({
    required this.sections,
    this.header,
    this.footer,
    this.collapsed = false,
    this.onToggleCollapsed,
    this.expandedWidth = 248,
    this.collapsedWidth = 68,
    super.key,
  });

  /// The navigation sections, top to bottom.
  final List<FormaSidebarSection> sections;

  /// Optional header slot (e.g. a brand mark). Rendered above the items.
  final Widget? header;

  /// Optional footer slot (e.g. a user chip). Rendered below the items, above
  /// the collapse toggle.
  final Widget? footer;

  /// Whether the sidebar is collapsed to icons only.
  final bool collapsed;

  /// Called when the bottom chevron toggle is activated. When null, no toggle
  /// is shown.
  final VoidCallback? onToggleCollapsed;

  /// Width when expanded.
  final double expandedWidth;

  /// Width when collapsed.
  final double collapsedWidth;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final targetWidth = collapsed ? collapsedWidth : expandedWidth;

    // O modo (recolhida/expandida) muda na hora, mas a largura anima. O
    // conteúdo é sempre diagramado na largura final e recortado durante a
    // transição — sem overflow em nenhum quadro da animação.
    return AnimatedContainer(
      duration: FormaDurations.fade,
      curve: Curves.easeInOut,
      width: targetWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ext.cardBackground,
        border: Border(right: BorderSide(color: ext.border)),
      ),
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minWidth: targetWidth - 1,
        maxWidth: targetWidth - 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null)
              Padding(
                padding: const EdgeInsets.all(FormaSpacing.md),
                child: header,
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: FormaSpacing.sm,
                  vertical: FormaSpacing.xs,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final section in sections)
                      _SidebarSection(section: section, collapsed: collapsed),
                  ],
                ),
              ),
            ),
            if (footer != null)
              Padding(
                padding: const EdgeInsets.all(FormaSpacing.sm),
                child: footer,
              ),
            if (onToggleCollapsed != null)
              _CollapseToggle(
                collapsed: collapsed,
                onToggle: onToggleCollapsed!,
              ),
          ],
        ),
      ),
    );
  }
}

class _SidebarSection extends StatelessWidget {
  const _SidebarSection({required this.section, required this.collapsed});

  final FormaSidebarSection section;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (section.title != null && !collapsed)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              FormaSpacing.md,
              FormaSpacing.md,
              FormaSpacing.md,
              FormaSpacing.xs,
            ),
            child: Text(
              section.title!.toUpperCase(),
              style: typo.overline10.copyWith(color: ext.textHint),
            ),
          )
        else
          const SizedBox(height: FormaSpacing.xs),
        for (final item in section.items)
          _SidebarItemTile(item: item, collapsed: collapsed),
      ],
    );
  }
}

class _SidebarItemTile extends StatelessWidget {
  const _SidebarItemTile({required this.item, required this.collapsed});

  final FormaSidebarItem item;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final foreground = item.selected ? ext.primaryColor : ext.textMuted;

    final row = Row(
      mainAxisAlignment: collapsed
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Icon(item.icon, size: 20, color: foreground),
        if (!collapsed) ...[
          const SizedBox(width: FormaSpacing.md),
          Expanded(
            child: Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              style: (item.selected ? typo.body14Medium : typo.body14).copyWith(
                color: foreground,
              ),
            ),
          ),
          if (item.badge != null) ...[
            const SizedBox(width: FormaSpacing.sm),
            _SidebarBadge(text: item.badge!, variant: item.badgeVariant),
          ],
        ],
      ],
    );

    Widget tile = Semantics(
      button: true,
      selected: item.selected,
      label: item.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: item.onTap,
            borderRadius: const BorderRadius.all(
              Radius.circular(FormaRadius.input),
            ),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.md),
              decoration: BoxDecoration(
                color: item.selected ? ext.primarySurface : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(FormaRadius.input),
                ),
              ),
              child: row,
            ),
          ),
        ),
      ),
    );

    if (collapsed) {
      tile = Tooltip(message: item.label, child: tile);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: tile,
    );
  }
}

class _SidebarBadge extends StatelessWidget {
  const _SidebarBadge({required this.text, required this.variant});

  final String text;
  final FormaSidebarBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final (bg, fg) = switch (variant) {
      FormaSidebarBadgeVariant.neutral => (ext.appBackground, ext.textMuted),
      FormaSidebarBadgeVariant.primary => (
        ext.primarySurface,
        ext.primaryColor,
      ),
      FormaSidebarBadgeVariant.warning => (ext.warningSurface, ext.warningText),
      FormaSidebarBadgeVariant.error => (ext.errorSurface, ext.errorText),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      constraints: const BoxConstraints(minWidth: 18),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.all(Radius.circular(FormaRadius.chip)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: typo.caption12Med.copyWith(color: fg, height: 1.3),
      ),
    );
  }
}

class _CollapseToggle extends StatelessWidget {
  const _CollapseToggle({required this.collapsed, required this.onToggle});

  final bool collapsed;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: ext.border)),
      ),
      child: Semantics(
        button: true,
        label: collapsed ? 'Expandir menu' : 'Recolher menu',
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onToggle,
              child: SizedBox(
                height: 44,
                child: Icon(
                  collapsed ? Icons.chevron_right : Icons.chevron_left,
                  size: 20,
                  color: ext.textMuted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
