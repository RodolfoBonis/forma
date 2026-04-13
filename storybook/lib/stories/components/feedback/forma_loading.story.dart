import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaLoading story — adaptive loading indicator.
WidgetbookComponent formaLoadingComponent() {
  return WidgetbookComponent(
    name: 'FormaLoading',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final size = context.knobs.double.slider(
            label: 'Size',
            initialValue: 24,
            min: 16,
            max: 64,
          );
          final strokeWidth = context.knobs.double.slider(
            label: 'Stroke Width',
            initialValue: 2.5,
            min: 1,
            max: 6,
          );

          return FormaLoading(size: size, strokeWidth: strokeWidth);
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes',
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (final size in [16.0, 24.0, 36.0, 48.0])
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormaLoading(size: size),
                      const SizedBox(height: 8),
                      Text(
                        '${size.toInt()}px',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
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
