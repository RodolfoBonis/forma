import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaModeToggle story — segmented toggle with two options.
WidgetbookComponent formaModeToggleComponent() {
  return WidgetbookComponent(
    name: 'FormaModeToggle',
    useCases: [
      WidgetbookUseCase(
        name: 'Playground',
        builder: (context) {
          final optionA = context.knobs.string(
            label: 'Option A',
            initialValue: 'Com aprovacao',
          );
          final optionB = context.knobs.string(
            label: 'Option B',
            initialValue: 'Acordo direto',
          );
          final selectedIndex = context.knobs.int.slider(
            label: 'Selected Index',
            initialValue: 0,
            min: 0,
            max: 1,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: FormaModeToggle(
              options: [optionA, optionB],
              selectedIndex: selectedIndex,
              onChanged: (_) {},
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Interactive',
        builder: (context) => const _InteractiveModeToggle(),
      ),
    ],
  );
}

class _InteractiveModeToggle extends StatefulWidget {
  const _InteractiveModeToggle();

  @override
  State<_InteractiveModeToggle> createState() => _InteractiveModeToggleState();
}

class _InteractiveModeToggleState extends State<_InteractiveModeToggle> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormaModeToggle(
            options: const ['Com aprovacao', 'Acordo direto'],
            selectedIndex: _selected,
            onChanged: (index) => setState(() => _selected = index),
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: ${_selected == 0 ? "Com aprovacao" : "Acordo direto"}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
