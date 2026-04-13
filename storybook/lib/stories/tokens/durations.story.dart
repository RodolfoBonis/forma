import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:widgetbook/widgetbook.dart';

/// Durations story — demonstrates FormaDurations animation timing.
WidgetbookComponent durationsComponent() {
  return WidgetbookComponent(
    name: 'Durations',
    useCases: [
      WidgetbookUseCase(
        name: 'Animation Demo',
        builder: (context) => const _DurationsDemo(),
      ),
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
