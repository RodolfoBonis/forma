import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaIconButton story — icon button with touch target.
WidgetbookComponent formaIconButtonComponent() {
  return WidgetbookComponent(
    name: 'FormaIconButton',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final icon = context.knobs.object.dropdown<IconData>(
            label: 'Icon',
            options: _iconOptions.values.toList(),
            labelBuilder: (v) =>
                _iconOptions.entries.firstWhere((e) => e.value == v).key,
            initialOption: Icons.arrow_back,
          );
          final size = context.knobs.double.slider(
            label: 'Size',
            initialValue: 24,
            min: 16,
            max: 48,
          );

          return Center(
            child: FormaIconButton(
              icon: Icon(icon),
              size: size,
              onPressed: () {},
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Gallery',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final entry in _iconOptions.entries)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormaIconButton(
                        icon: Icon(entry.value),
                        onPressed: () {},
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.key,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    ],
  );
}

const _iconOptions = <String, IconData>{
  'arrow_back': Icons.arrow_back,
  'close': Icons.close,
  'more_vert': Icons.more_vert,
  'settings': Icons.settings,
  'edit': Icons.edit,
  'delete': Icons.delete_outline,
  'share': Icons.share,
  'notifications': Icons.notifications_outlined,
};
