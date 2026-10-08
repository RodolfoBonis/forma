import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

const _people = <String>[
  'Ana Silva',
  'Bruno Costa',
  'Carla Dias',
  'Diego Melo',
  'Eduarda Nunes',
  'Felipe Rocha',
];

Future<List<FormaSelectOption<String>>> _search(String query) async {
  await Future<void>.delayed(const Duration(milliseconds: 400));
  final q = query.toLowerCase();
  return _people
      .where((p) => q.isEmpty || p.toLowerCase().contains(q))
      .map((p) => FormaSelectOption(value: p, label: p))
      .toList();
}

/// FormaCombobox component — async type-ahead select with debounce.
GalleryComponent formaComboboxComponent() {
  return GalleryComponent(
    'FormaCombobox',
    docs: const ComponentDocs(
      description:
          'Async combobox: focuses a search box on open, debounces queries, '
          'shows a spinner while loading and surfaces "Erro ao buscar" on '
          'failures. Keyboard navigable; cancels timers on dispose.',
      props: [
        PropDoc(
          'search',
          'Future<List<FormaSelectOption<T>>> Function(String)',
          required: true,
        ),
        PropDoc(
          'onChanged',
          'ValueChanged<FormaSelectOption<T>?>',
          required: true,
        ),
        PropDoc('value', 'FormaSelectOption<T>?'),
        PropDoc('debounce', 'Duration', defaultValue: '250ms'),
      ],
      codeSnippet: '''
FormaCombobox<String>(
  label: 'Responsável',
  search: (q) => api.searchUsers(q),
  value: selected,
  onChanged: (o) => setState(() => selected = o),
)''',
    ),
    useCases: [UseCase('Playground', (context, k) => const _ComboboxDemo())],
  );
}

class _ComboboxDemo extends StatefulWidget {
  const _ComboboxDemo();

  @override
  State<_ComboboxDemo> createState() => _ComboboxDemoState();
}

class _ComboboxDemoState extends State<_ComboboxDemo> {
  FormaSelectOption<String>? _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 280,
          child: FormaCombobox<String>(
            label: 'Responsável',
            search: _search,
            value: _value,
            onChanged: (o) => setState(() => _value = o),
          ),
        ),
      ),
    );
  }
}
