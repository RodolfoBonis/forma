import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaBottomNav story — with navigation items.
WidgetbookComponent formaBottomNavComponent() {
  return WidgetbookComponent(
    name: 'FormaBottomNav',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final activeIndex = context.knobs.object.dropdown<int>(
            label: 'Active Index',
            options: [0, 1, 2, 3],
            labelBuilder: (i) => i.toString(),
            initialOption: 0,
          );

          return Align(
            alignment: Alignment.bottomCenter,
            child: FormaBottomNav(
              activeIndex: activeIndex,
              onTap: (_) {},
              items: const [
                FormaNavItem(label: 'Inicio', icon: Icons.home_outlined),
                FormaNavItem(label: 'Agenda', icon: Icons.calendar_today_outlined),
                FormaNavItem(label: 'Plantoes', icon: Icons.work_outline),
                FormaNavItem(label: 'Perfil', icon: Icons.person_outline),
              ],
            ),
          );
        },
      ),
    ],
  );
}
