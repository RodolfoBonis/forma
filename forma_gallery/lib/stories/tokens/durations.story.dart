import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// Durations story — demonstrates FormaDurations animation timing.
GalleryComponent durationsComponent() {
  return GalleryComponent(
    'Durations',
    docs: const ComponentDocs(
      description:
          'The FormaDurations timing scale (fade 220ms, smart 280ms, slow '
          '400ms) for consistent animation and transition durations. Pass '
          'tokens like FormaDurations.smart to AnimatedContainer and similar '
          'animated widgets.',
      importPath: "import 'package:forma_core/forma_core.dart';",
      codeSnippet: '''
AnimatedContainer(
  duration: FormaDurations.smart,
  curve: Curves.easeInOut,
);''',
    ),
    useCases: [
      UseCase('Animation Demo', (context, k) => const _DurationsDemo()),
    ],
  );
}

class _DurationsDemo extends StatefulWidget {
  const _DurationsDemo();

  @override
  State<_DurationsDemo> createState() => _DurationsDemoState();
}

class _DurationsDemoState extends State<_DurationsDemo> {
  bool _animating = false;

  void _toggle() => setState(() => _animating = !_animating);

  @override
  Widget build(BuildContext context) {
    const items = <(String, Duration, String)>[
      ('fade', FormaDurations.fade, '220ms'),
      ('smart', FormaDurations.smart, '280ms'),
      ('slow', FormaDurations.slow, '400ms'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilledButton(
            onPressed: _toggle,
            child: Text(_animating ? 'Reset' : 'Animate'),
          ),
          const SizedBox(height: 24),
          for (final (label, duration, display) in items) ...[
            Text(
              '$label ($display)',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: duration,
              curve: Curves.easeInOut,
              width: _animating ? 280 : 80,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                display,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }
}
