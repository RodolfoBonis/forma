import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaSegmentedControl story.
WidgetbookComponent formaSegmentedControlComponent() {
  return WidgetbookComponent(
    name: 'FormaSegmentedControl',
    useCases: [
      WidgetbookUseCase(
        name: 'Two segments',
        builder: (context) {
          var selected = 0;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return FormaSegmentedControl(
                    selectedIndex: selected,
                    onChanged: (i) => setState(() => selected = i),
                    segments: const [
                      FormaSegment(label: 'Criar relação'),
                      FormaSegment(label: 'Tenho um convite'),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Three segments with icons',
        builder: (context) {
          var selected = 1;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: StatefulBuilder(
                builder: (context, setState) {
                  return FormaSegmentedControl(
                    selectedIndex: selected,
                    onChanged: (i) => setState(() => selected = i),
                    segments: const [
                      FormaSegment(label: 'Foto', icon: Icons.photo_camera),
                      FormaSegment(label: 'Texto', icon: Icons.notes),
                      FormaSegment(label: 'Check', icon: Icons.check),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    ],
  );
}
