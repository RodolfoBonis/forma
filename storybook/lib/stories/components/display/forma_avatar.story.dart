import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaAvatar story — all sizes with knobs.
WidgetbookComponent formaAvatarComponent() {
  return WidgetbookComponent(
    name: 'FormaAvatar',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final initial = context.knobs.string(
            label: 'Initial',
            initialValue: 'A',
          );
          final size = context.knobs.object.dropdown<FormaAvatarSize>(
            label: 'Size',
            options: FormaAvatarSize.values,
            labelBuilder: (s) => s.name,
            initialOption: FormaAvatarSize.medium,
          );

          return Center(
            child: FormaAvatar(
              initial: initial,
              color: PfColors.primary700,
              size: size,
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All Sizes',
        builder: (context) {
          return Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final size in FormaAvatarSize.values) ...[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormaAvatar(
                        initial: 'A',
                        color: PfColors.primary700,
                        size: size,
                      ),
                      const SizedBox(height: 8),
                      Text(size.name, style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ],
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Role rings (Dom / Sub)',
        builder: (context) {
          return const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormaAvatar(
                  initial: 'R',
                  color: Color(0xFF7E1A36),
                  size: FormaAvatarSize.large,
                  ringColor: DominusColors.roleDom,
                ),
                SizedBox(width: 24),
                FormaAvatar(
                  initial: 'M',
                  color: Color(0xFF7E1A36),
                  size: FormaAvatarSize.large,
                  ringColor: DominusColors.roleSub,
                ),
              ],
            ),
          );
        },
      ),
    ],
  );
}
