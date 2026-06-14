import 'package:flutter/widgets.dart';

import '../knobs/knobs.dart';
import 'component_docs.dart';

/// Builds the preview for a use case, reading live values from [k].
typedef UseCaseBuilder = Widget Function(BuildContext context, Knobs k);

/// A single named scenario of a component (e.g. "Playground", "All Variants").
class UseCase {
  /// Creates a use case with a [name] and [builder].
  const UseCase(this.name, this.builder, {this.docs});

  /// Display name in the navigation tree.
  final String name;

  /// Builds the preview widget; declares and reads knobs via [Knobs].
  final UseCaseBuilder builder;

  /// Optional per-use-case docs override (falls back to the component's docs).
  final ComponentDocs? docs;
}
