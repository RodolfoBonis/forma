/// Usage documentation attached to a component in the gallery.
///
/// Rendered in the "Docs" tab: a description, an API/props table, and a
/// copyable code snippet showing how to use the component.
class ComponentDocs {
  /// Creates docs for a component.
  const ComponentDocs({
    required this.description,
    this.props = const [],
    this.codeSnippet,
    this.importPath = "import 'package:forma_core/forma_core.dart';",
  });

  /// Plain-text description of what the component is for.
  final String description;

  /// API rows describing the component's parameters.
  final List<PropDoc> props;

  /// A copyable "how to use" snippet (without the import line).
  final String? codeSnippet;

  /// The import statement shown above the snippet.
  final String importPath;
}

/// A single row in a component's API/props table.
class PropDoc {
  /// Creates a prop description.
  const PropDoc(
    this.name,
    this.type, {
    this.required = false,
    this.defaultValue,
    this.description = '',
  });

  /// Parameter name.
  final String name;

  /// Parameter type (e.g. `String`, `FormaButtonVariant`).
  final String type;

  /// Whether the parameter is required.
  final bool required;

  /// Default value as source text, when optional.
  final String? defaultValue;

  /// Short explanation of the parameter.
  final String description;
}
