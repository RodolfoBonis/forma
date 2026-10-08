import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaTopBar component — desktop header playground.
GalleryComponent formaTopBarComponent() {
  return GalleryComponent(
    'FormaTopBar',
    docs: const ComponentDocs(
      description:
          'A compact desktop top bar. Implements PreferredSizeWidget so it can '
          'be used as a Scaffold.appBar. Renders a leading widget, a title or '
          'custom center, and trailing actions on a bottom-bordered surface.',
      props: [
        PropDoc('leading', 'Widget?'),
        PropDoc('title', 'String?'),
        PropDoc('center', 'Widget?'),
        PropDoc('actions', 'List<Widget>', defaultValue: 'const []'),
        PropDoc('height', 'double', defaultValue: '60'),
      ],
      codeSnippet: '''
FormaTopBar(
  leading: FormaIconButton(icon: Icon(Icons.menu), onPressed: () {}),
  title: 'Projetos',
  actions: [FormaIconButton(icon: Icon(Icons.settings), onPressed: () {})],
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final title = k.string(label: 'Title', initialValue: 'Projetos');
        return Column(
          children: [
            FormaTopBar(
              leading: FormaIconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              title: title,
              actions: [
                FormaIconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                FormaIconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      }),
    ],
  );
}
