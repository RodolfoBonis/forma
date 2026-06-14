import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaSettingsRow story.
GalleryComponent formaSettingsRowComponent() {
  return GalleryComponent(
    'FormaSettingsRow',
    docs: const ComponentDocs(
      description:
          'A tappable settings list row: leading icon, title, optional '
          'subtitle, and a trailing widget (a chevron by default). Colors are '
          'drawn from the active theme.',
      props: [
        PropDoc(
          'icon',
          'IconData',
          required: true,
          description: 'Leading icon.',
        ),
        PropDoc(
          'title',
          'String',
          required: true,
          description: 'Primary label.',
        ),
        PropDoc(
          'subtitle',
          'String?',
          description: 'Optional secondary label beneath the title.',
        ),
        PropDoc(
          'trailing',
          'Widget?',
          description: 'Trailing widget. Defaults to a chevron.',
        ),
        PropDoc(
          'onTap',
          'VoidCallback?',
          description: 'Tap callback for the whole row.',
        ),
      ],
      codeSnippet: '''
FormaSettingsRow(
  icon: Icons.favorite_border,
  title: 'Relação',
  subtitle: 'Gerencie seu contrato',
)''',
    ),
    useCases: [
      UseCase('Settings list', (context, k) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormaSettingsRow(
                icon: Icons.favorite_border,
                title: 'Relação',
                subtitle: 'Gerencie seu contrato',
              ),
              FormaSettingsRow(
                icon: Icons.vpn_key_outlined,
                title: 'Chaves',
                subtitle: 'Acesso e permissões',
              ),
              FormaSettingsRow(
                icon: Icons.lock_outline,
                title: 'Segurança',
                subtitle: 'PIN e biometria',
              ),
              FormaSettingsRow(
                icon: Icons.notifications_none,
                title: 'Notificações',
                subtitle: 'Alertas e lembretes',
              ),
            ],
          ),
        );
      }),
    ],
  );
}
