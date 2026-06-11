import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaSwitch story.
WidgetbookComponent formaSwitchComponent() {
  return WidgetbookComponent(
    name: 'FormaSwitch',
    useCases: [
      WidgetbookUseCase(
        name: 'Interactive',
        builder: (context) {
          var value = true;
          return Center(
            child: StatefulBuilder(
              builder: (context, setState) {
                return FormaSwitch(
                  value: value,
                  onChanged: (v) => setState(() => value = v),
                );
              },
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'States',
        builder: (context) {
          return const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormaSwitch(value: true, onChanged: _noop),
                SizedBox(width: 24),
                FormaSwitch(value: false, onChanged: _noop),
                SizedBox(width: 24),
                FormaSwitch(value: true, onChanged: null),
              ],
            ),
          );
        },
      ),
    ],
  );
}

void _noop(bool _) {}
