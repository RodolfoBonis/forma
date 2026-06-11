import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// FormaProofIcon story.
WidgetbookComponent formaProofIconComponent() {
  return WidgetbookComponent(
    name: 'FormaProofIcon',
    useCases: [
      WidgetbookUseCase(
        name: 'All types',
        builder: (context) {
          return const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormaProofIcon(type: FormaProofType.foto),
                SizedBox(width: 12),
                FormaProofIcon(type: FormaProofType.texto),
                SizedBox(width: 12),
                FormaProofIcon(type: FormaProofType.check),
              ],
            ),
          );
        },
      ),
    ],
  );
}
