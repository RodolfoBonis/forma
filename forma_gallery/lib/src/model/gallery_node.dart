import 'component_docs.dart';
import 'use_case.dart';

/// A node in the gallery navigation tree.
///
/// Sealed so the sidebar can switch exhaustively over [GalleryFolder] (a
/// branch) and [GalleryComponent] (a leaf with use cases).
sealed class GalleryNode {
  /// Creates a node with a display [name].
  const GalleryNode(this.name);

  /// Display name in the navigation tree.
  final String name;
}

/// A branch grouping child nodes (e.g. "Components", "Buttons").
class GalleryFolder extends GalleryNode {
  /// Creates a folder named [name] holding [children].
  const GalleryFolder(super.name, {required this.children});

  /// Child nodes (folders or components), in display order.
  final List<GalleryNode> children;
}

/// A leaf representing one component, with one or more [useCases].
class GalleryComponent extends GalleryNode {
  /// Creates a component named [name] with [useCases] and optional [docs].
  const GalleryComponent(super.name, {required this.useCases, this.docs});

  /// The component's scenarios.
  final List<UseCase> useCases;

  /// Usage documentation shown in the "Docs" tab.
  final ComponentDocs? docs;
}
