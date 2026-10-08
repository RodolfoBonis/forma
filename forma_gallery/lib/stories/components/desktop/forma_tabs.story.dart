import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTabs component — underline tab strip playground.
GalleryComponent formaTabsComponent() {
  return GalleryComponent(
    'FormaTabs',
    docs: const ComponentDocs(
      description:
          'An underline-style, animated tab strip for desktop. A controlled '
          'widget: the caller owns the selected index and updates it in '
          'onChanged. The active tab is tinted with primaryColor and marked '
          'by an animated underline.',
      props: [
        PropDoc('tabs', 'List<FormaTab>', required: true),
        PropDoc('index', 'int', required: true),
        PropDoc('onChanged', 'ValueChanged<int>', required: true),
      ],
      codeSnippet: '''
FormaTabs(
  index: index,
  onChanged: (i) => setState(() => index = i),
  tabs: const [
    FormaTab(label: 'Abertos', count: 12),
    FormaTab(label: 'Fechados'),
  ],
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        return _TabsDemo();
      }),
    ],
  );
}

class _TabsDemo extends StatefulWidget {
  @override
  State<_TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<_TabsDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: FormaTabs(
          index: _index,
          onChanged: (i) => setState(() => _index = i),
          tabs: const [
            FormaTab(label: 'Abertos', count: 12, icon: Icons.inbox_outlined),
            FormaTab(label: 'Em progresso', count: 4),
            FormaTab(label: 'Fechados'),
          ],
        ),
      ),
    );
  }
}
