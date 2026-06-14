import 'package:flutter/foundation.dart';

import 'knob.dart';

/// Owns the live knob state for a single use case and notifies listeners
/// (the preview + controls panel) when a value changes.
///
/// The hard part of a storybook is that a use-case `builder` *declares* and
/// *reads* its knobs in the same synchronous build pass. This controller
/// resolves that with a register-on-build protocol:
///
/// 1. [beginBuild] marks every known knob as unseen.
/// 2. During build, each `Knobs` facade call routes to [resolve], which either
///    returns the existing knob (preserving the user-edited [Knob.value]) or
///    creates it from the supplied initial value. Either way it is marked seen.
/// 3. [endBuild] prunes knobs not seen this pass (handles conditional knobs and
///    use-case switches).
///
/// [notifyListeners] is only ever called from [setValue] (a user gesture),
/// never during a build pass, so we never mutate state mid-build in a way that
/// would re-enter the builder.
class KnobsController extends ChangeNotifier {
  final Map<String, Knob<Object?>> _knobs = <String, Knob<Object?>>{};

  /// Registered knobs in first-seen order, for the controls panel.
  List<Knob<Object?>> get knobs => _knobs.values.toList(growable: false);

  /// Begins a build pass; call before invoking the use-case builder.
  void beginBuild() {
    for (final knob in _knobs.values) {
      knob.seen = false;
    }
  }

  /// Ends a build pass; prunes knobs the builder did not touch.
  void endBuild() {
    _knobs.removeWhere((_, knob) => !knob.seen);
  }

  /// Returns the existing knob for [label] (marking it seen) or registers a
  /// freshly [create]d one. Only reuses when the existing knob is the same
  /// type [K]; otherwise it is replaced (e.g. a label reused with a new type).
  K resolve<K extends Knob<Object?>>(String label, K Function() create) {
    final existing = _knobs[label];
    if (existing is K) {
      existing.seen = true;
      return existing;
    }
    final created = create()..seen = true;
    _knobs[label] = created;
    return created;
  }

  /// Updates a knob's value from the controls panel and rebuilds the preview.
  void setValue<T>(Knob<T> knob, T value) {
    knob.value = value;
    notifyListeners();
  }
}
