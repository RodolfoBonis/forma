/// Forma Gallery — a custom, dependency-free component gallery & docs
/// framework for the Forma design system (replaces Widgetbook).
///
/// Authoring a story:
///
/// ```dart
/// GalleryComponent formaButtonComponent() => GalleryComponent(
///   'FormaButton',
///   docs: const ComponentDocs(description: '...'),
///   useCases: [
///     UseCase('Playground', (context, k) {
///       final label = k.string(label: 'Label', initialValue: 'Confirmar');
///       return FormaButton(label: label, onPressed: () {});
///     }),
///   ],
/// );
/// ```
library;

// Public model
export 'src/model/component_docs.dart';
export 'src/model/gallery_node.dart';
export 'src/model/gallery_theme.dart';
export 'src/model/use_case.dart';

// Knob authoring facade (the controller stays internal)
export 'src/knobs/knobs.dart' show Knobs;

// App entry point
export 'src/shell/gallery_app.dart' show GalleryApp;
