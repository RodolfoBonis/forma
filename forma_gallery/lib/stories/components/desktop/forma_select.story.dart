import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

const _options = <FormaSelectOption<String>>[
  FormaSelectOption(value: 'br', label: 'Brasil'),
  FormaSelectOption(value: 'pt', label: 'Portugal'),
  FormaSelectOption(value: 'ar', label: 'Argentina'),
  FormaSelectOption(value: 'cl', label: 'Chile'),
  FormaSelectOption(value: 'uy', label: 'Uruguai', enabled: false),
];

/// FormaSelect component — compact desktop dropdown with optional search.
GalleryComponent formaSelectComponent() {
  return GalleryComponent(
    'FormaSelect',
    docs: const ComponentDocs(
      description:
          'Text-field-styled select that opens an anchored overlay with a '
          'checkmark on the selected option, hover + keyboard highlighting, an '
          'optional search box and an optional clear button.',
      props: [
        PropDoc('options', 'List<FormaSelectOption<T>>', required: true),
        PropDoc('onChanged', 'ValueChanged<T?>', required: true),
        PropDoc('value', 'T?'),
        PropDoc('searchable', 'bool', defaultValue: 'false'),
        PropDoc('clearable', 'bool', defaultValue: 'false'),
      ],
      codeSnippet: '''
FormaSelect<String>(
  label: 'País',
  options: options,
  value: country,
  searchable: true,
  onChanged: (v) => setState(() => country = v),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final searchable = k.boolean(label: 'Searchable', initialValue: false);
        final clearable = k.boolean(label: 'Clearable', initialValue: true);
        final enabled = k.boolean(label: 'Enabled', initialValue: true);
        return _SelectDemo(
          searchable: searchable,
          clearable: clearable,
          enabled: enabled,
        );
      }),
    ],
  );
}

class _SelectDemo extends StatefulWidget {
  const _SelectDemo({
    required this.searchable,
    required this.clearable,
    required this.enabled,
  });

  final bool searchable;
  final bool clearable;
  final bool enabled;

  @override
  State<_SelectDemo> createState() => _SelectDemoState();
}

class _SelectDemoState extends State<_SelectDemo> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 280,
          child: FormaSelect<String>(
            label: 'País',
            options: _options,
            value: _value,
            searchable: widget.searchable,
            clearable: widget.clearable,
            enabled: widget.enabled,
            onChanged: (v) => setState(() => _value = v),
          ),
        ),
      ),
    );
  }
}
