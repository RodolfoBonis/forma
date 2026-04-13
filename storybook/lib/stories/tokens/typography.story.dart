import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// Typography story — displays the full FormaTypography scale.
WidgetbookComponent typographyComponent() {
  return WidgetbookComponent(
    name: 'Typography',
    useCases: [
      WidgetbookUseCase(
        name: 'Type Scale',
        builder: (context) => const _TypographyScale(),
      ),
    ],
  );
}

class _TypographyScale extends StatelessWidget {
  const _TypographyScale();

  @override
  Widget build(BuildContext context) {
    final samples = <(String, TextStyle)>[
      ('displayHero (52px)', FormaTypography.displayHero),
      ('h1 (34px)', FormaTypography.h1),
      ('h2 (26px)', FormaTypography.h2),
      ('h3 (22px)', FormaTypography.h3),
      ('h4 (20px)', FormaTypography.h4),
      ('title18', FormaTypography.title18),
      ('title16', FormaTypography.title16),
      ('title15', FormaTypography.title15),
      ('body16', FormaTypography.body16),
      ('body14', FormaTypography.body14),
      ('body14Medium', FormaTypography.body14Medium),
      ('body13', FormaTypography.body13),
      ('body13Bold', FormaTypography.body13Bold),
      ('caption12', FormaTypography.caption12),
      ('caption12Med', FormaTypography.caption12Med),
      ('overline10', FormaTypography.overline10),
      ('nav10', FormaTypography.nav10),
      ('nav10Bold', FormaTypography.nav10Bold),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, style) in samples) ...[
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 2),
            Text('The quick brown fox jumps over the lazy dog', style: style),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
