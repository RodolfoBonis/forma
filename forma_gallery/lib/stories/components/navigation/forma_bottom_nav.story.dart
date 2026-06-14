import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';

/// FormaBottomNav story — with navigation items.
GalleryComponent formaBottomNavComponent() {
  return GalleryComponent(
    'FormaBottomNav',
    docs: const ComponentDocs(
      description:
          'Bottom navigation bar displaying a row of items with an active '
          'indicator dot above the selected icon. The active tint can be '
          'overridden per role.',
      props: [
        PropDoc(
          'activeIndex',
          'int',
          required: true,
          description: 'Index of the currently active item.',
        ),
        PropDoc(
          'onTap',
          'void Function(int)',
          required: true,
          description: 'Called with the tapped item index.',
        ),
        PropDoc(
          'items',
          'List<FormaNavItem>',
          required: true,
          description: 'Navigation items to display.',
        ),
        PropDoc(
          'activeColor',
          'Color?',
          description: 'Tint for the active dot, icon, and label.',
        ),
      ],
      codeSnippet: '''
FormaBottomNav(
  activeIndex: 0,
  onTap: (index) {},
  items: const [
    FormaNavItem(label: 'Inicio', icon: Icons.home_outlined),
    FormaNavItem(label: 'Perfil', icon: Icons.person_outline),
  ],
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final activeIndex = k.object.dropdown<int>(
          label: 'Active Index',
          options: [0, 1, 2, 3],
          labelBuilder: (i) => i.toString(),
          initialOption: 0,
        );
        final role = k.object.dropdown<String>(
          label: 'Role',
          options: ['Default', 'Dom', 'Sub'],
          initialOption: 'Default',
        );
        final activeColor = switch (role) {
          'Dom' => DominusColors.roleDom,
          'Sub' => DominusColors.roleSub,
          _ => null,
        };

        return Align(
          alignment: Alignment.bottomCenter,
          child: FormaBottomNav(
            activeIndex: activeIndex,
            activeColor: activeColor,
            onTap: (_) {},
            items: const [
              FormaNavItem(label: 'Inicio', icon: Icons.home_outlined),
              FormaNavItem(
                label: 'Agenda',
                icon: Icons.calendar_today_outlined,
              ),
              FormaNavItem(label: 'Plantoes', icon: Icons.work_outline),
              FormaNavItem(label: 'Perfil', icon: Icons.person_outline),
            ],
          ),
        );
      }),
    ],
  );
}
