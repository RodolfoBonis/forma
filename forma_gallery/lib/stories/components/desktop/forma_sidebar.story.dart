import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSidebar component — collapsible desktop navigation playground.
GalleryComponent formaSidebarComponent() {
  return GalleryComponent(
    'FormaSidebar',
    docs: const ComponentDocs(
      description:
          'A collapsible desktop navigation sidebar. Renders sections of items '
          'between an optional header and footer, animates between expanded and '
          'collapsed widths (icons only with tooltips), and highlights the '
          'selected item with a primary pill.',
      props: [
        PropDoc('sections', 'List<FormaSidebarSection>', required: true),
        PropDoc('header', 'Widget?'),
        PropDoc('footer', 'Widget?'),
        PropDoc('collapsed', 'bool', defaultValue: 'false'),
        PropDoc('onToggleCollapsed', 'VoidCallback?'),
        PropDoc('expandedWidth', 'double', defaultValue: '248'),
        PropDoc('collapsedWidth', 'double', defaultValue: '68'),
      ],
      codeSnippet: '''
FormaSidebar(
  collapsed: collapsed,
  onToggleCollapsed: () => setState(() => collapsed = !collapsed),
  sections: const [
    FormaSidebarSection(
      title: 'Geral',
      items: [
        FormaSidebarItem(icon: Icons.home, label: 'Início', selected: true),
        FormaSidebarItem(icon: Icons.folder, label: 'Projetos'),
      ],
    ),
  ],
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        return _SidebarDemo();
      }),
    ],
  );
}

class _SidebarDemo extends StatefulWidget {
  @override
  State<_SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<_SidebarDemo> {
  bool _collapsed = false;
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    FormaSidebarItem item(int i, IconData icon, String label, {String? badge}) {
      return FormaSidebarItem(
        icon: icon,
        label: label,
        selected: _selected == i,
        onTap: () => setState(() => _selected = i),
        badge: badge,
        badgeVariant: FormaSidebarBadgeVariant.primary,
      );
    }

    return SizedBox(
      height: 560,
      child: FormaSidebar(
        collapsed: _collapsed,
        onToggleCollapsed: () => setState(() => _collapsed = !_collapsed),
        header: Row(
          children: [
            Icon(Icons.bolt, color: ext.primaryColor),
            if (!_collapsed) ...[
              const SizedBox(width: 8),
              Text('Forma', style: context.formaTypography.title16),
            ],
          ],
        ),
        footer: Row(
          mainAxisAlignment: _collapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 14, child: Text('R')),
            if (!_collapsed) ...[
              const SizedBox(width: 8),
              Text('Rodolfo', style: context.formaTypography.body14),
            ],
          ],
        ),
        sections: [
          FormaSidebarSection(
            title: 'Geral',
            items: [
              item(0, Icons.home_outlined, 'Início'),
              item(1, Icons.folder_outlined, 'Projetos'),
              item(2, Icons.notifications_outlined, 'Alertas', badge: '5'),
            ],
          ),
          FormaSidebarSection(
            title: 'Conta',
            items: [item(3, Icons.settings_outlined, 'Configurações')],
          ),
        ],
      ),
    );
  }
}
