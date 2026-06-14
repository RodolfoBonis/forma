import 'package:flutter/material.dart';

import '../knobs/knobs.dart';
import '../knobs/knobs_controller.dart';
import '../model/use_case.dart';

/// Runs a [UseCase] builder against a [KnobsController], rebuilding whenever a
/// knob value changes.
///
/// The begin/end build calls bracket the synchronous builder invocation so the
/// controller can register newly-seen knobs and prune stale ones. This is the
/// one place that mutates the controller during build; it is safe because no
/// listener notification happens here (only [KnobsController.setValue] does).
class UseCaseHost extends StatelessWidget {
  /// Creates a host for [useCase] driven by [controller].
  const UseCaseHost({
    required this.useCase,
    required this.controller,
    super.key,
  });

  /// The use case to render.
  final UseCase useCase;

  /// The knob controller owning this use case's live values.
  final KnobsController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        controller.beginBuild();
        final child = useCase.builder(context, Knobs(controller));
        controller.endBuild();
        return child;
      },
    );
  }
}
