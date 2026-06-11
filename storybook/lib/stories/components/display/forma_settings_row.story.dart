import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaSettingsRow story.
WidgetbookComponent formaSettingsRowComponent() {
  return WidgetbookComponent(
    name: 'FormaSettingsRow',
    useCases: [
      WidgetbookUseCase(
        name: 'Settings list',
        builder: (context) {
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
        },
      ),
    ],
  );
}
