import 'package:flutter/material.dart';

import '../model/gallery_node.dart';
import '../state/gallery_state.dart';

/// The left navigation tree: folders expand to children; components expand to
/// their use cases; selecting a use case drives the preview.
class SidebarNav extends StatelessWidget {
  /// Creates the sidebar over [nodes].
  const SidebarNav({required this.nodes, this.onSelected, super.key});

  /// Root nodes of the gallery tree.
  final List<GalleryNode> nodes;

  /// Called after a use case is selected (e.g. to close a drawer).
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF111317),
      child: SafeArea(
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Text(
                'Forma Gallery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0x14FFFFFF)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final node in nodes)
                    _NodeTile(node: node, depth: 0, onSelected: onSelected),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NodeTile extends StatelessWidget {
  const _NodeTile({required this.node, required this.depth, this.onSelected});

  final GalleryNode node;
  final int depth;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final node = this.node;
    switch (node) {
      case GalleryFolder():
        return _FolderTile(folder: node, depth: depth, onSelected: onSelected);
      case GalleryComponent():
        return _ComponentTile(
          component: node,
          depth: depth,
          onSelected: onSelected,
        );
    }
  }
}

class _FolderTile extends StatelessWidget {
  const _FolderTile({
    required this.folder,
    required this.depth,
    this.onSelected,
  });

  final GalleryFolder folder;
  final int depth;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: depth == 0,
        tilePadding: EdgeInsets.only(left: 16.0 + depth * 12, right: 12),
        title: Text(
          folder.name,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        iconColor: Colors.white70,
        collapsedIconColor: Colors.white54,
        childrenPadding: EdgeInsets.zero,
        children: [
          for (final child in folder.children)
            _NodeTile(node: child, depth: depth + 1, onSelected: onSelected),
        ],
      ),
    );
  }
}

class _ComponentTile extends StatelessWidget {
  const _ComponentTile({
    required this.component,
    required this.depth,
    this.onSelected,
  });

  final GalleryComponent component;
  final int depth;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final state = GalleryScope.of(context);
    // Single use case → render the component itself as a selectable leaf.
    if (component.useCases.length == 1) {
      final useCase = component.useCases.first;
      return _LeafTile(
        label: component.name,
        depth: depth,
        selected: state.useCase == useCase,
        onTap: () {
          state.select(component, useCase);
          onSelected?.call();
        },
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.only(left: 16.0 + depth * 12, right: 12),
        title: Text(
          component.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: Colors.white70,
        collapsedIconColor: Colors.white38,
        childrenPadding: EdgeInsets.zero,
        children: [
          for (final useCase in component.useCases)
            _LeafTile(
              label: useCase.name,
              depth: depth + 1,
              selected: state.useCase == useCase,
              onTap: () {
                state.select(component, useCase);
                onSelected?.call();
              },
            ),
        ],
      ),
    );
  }
}

class _LeafTile extends StatelessWidget {
  const _LeafTile({
    required this.label,
    required this.depth,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final int depth;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? const Color(0x1F4F9BFF) : null,
        padding: EdgeInsets.only(
          left: 16.0 + depth * 12,
          right: 12,
          top: 9,
          bottom: 9,
        ),
        child: Row(
          children: [
            if (selected)
              Container(
                width: 3,
                height: 16,
                margin: const EdgeInsets.only(right: 8),
                color: const Color(0xFF4F9BFF),
              ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white60,
                  fontSize: 12.5,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
