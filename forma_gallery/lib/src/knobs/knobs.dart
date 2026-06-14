import 'package:flutter/widgets.dart';

import 'knob.dart';
import 'knobs_controller.dart';

/// Ergonomic facade handed to each use-case builder.
///
/// Mirrors the Widgetbook knob surface so existing stories port with a near
/// find-and-replace (`context.knobs.` → `k.`):
///
/// ```dart
/// final label = k.string(label: 'Label', initialValue: 'Confirmar');
/// final variant = k.object.dropdown<FormaButtonVariant>(
///   label: 'Variant',
///   options: FormaButtonVariant.values,
///   labelBuilder: (v) => v.name,
///   initialOption: FormaButtonVariant.primary,
/// );
/// final size = k.double.slider(label: 'Size', initialValue: 24, min: 16, max: 64);
/// ```
class Knobs {
  /// Creates a facade bound to [_controller].
  Knobs(this._controller);

  final KnobsController _controller;

  /// A required text knob; returns the live value.
  String string({required String label, String initialValue = ''}) =>
      _controller.resolve(label, () => StringKnob(label, initialValue)).value;

  /// An optional text knob; an empty field reads back as null.
  String? stringOrNull({required String label, String? initialValue}) =>
      _controller
          .resolve(label, () => NullableStringKnob(label, initialValue))
          .value;

  /// A boolean knob rendered as a switch.
  bool boolean({required String label, bool initialValue = false}) =>
      _controller.resolve(label, () => BoolKnob(label, initialValue)).value;

  /// A color knob rendered as a swatch grid + hex field.
  Color color({
    required String label,
    Color initialValue = const Color(0xFF000000),
  }) => _controller.resolve(label, () => ColorKnob(label, initialValue)).value;

  /// Namespace for object-valued knobs (e.g. enum dropdowns).
  ObjectKnobs get object => ObjectKnobs(_controller);

  /// Namespace for integer knobs.
  IntKnobs get int => IntKnobs(_controller);

  /// Namespace for double knobs.
  DoubleKnobs get double => DoubleKnobs(_controller);
}

/// Object-valued knob namespace (`k.object.dropdown`).
class ObjectKnobs {
  /// Creates an object namespace bound to [_controller].
  ObjectKnobs(this._controller);

  final KnobsController _controller;

  /// A pick-one-of knob. [labelBuilder] defaults to [Object.toString].
  T dropdown<T>({
    required String label,
    required List<T> options,
    required T initialOption,
    String Function(T)? labelBuilder,
  }) {
    final knob = _controller.resolve<OptionsKnob<T>>(
      label,
      () => OptionsKnob<T>(
        label,
        initialOption,
        options: options,
        labelOf: labelBuilder ?? (value) => value.toString(),
      ),
    );
    return knob.value;
  }
}

/// Integer knob namespace (`k.int.slider`).
class IntKnobs {
  /// Creates an int namespace bound to [_controller].
  IntKnobs(this._controller);

  final KnobsController _controller;

  /// An integer slider bounded by [min]/[max].
  int slider({
    required String label,
    int initialValue = 0,
    int min = 0,
    int max = 100,
    int? divisions,
  }) => _controller
      .resolve(
        label,
        () => IntSliderKnob(
          label,
          initialValue,
          min: min,
          max: max,
          divisions: divisions,
        ),
      )
      .value;
}

/// Double knob namespace (`k.double.slider`, `k.double.input`).
class DoubleKnobs {
  /// Creates a double namespace bound to [_controller].
  DoubleKnobs(this._controller);

  final KnobsController _controller;

  /// A continuous double slider bounded by [min]/[max].
  double slider({
    required String label,
    double initialValue = 0,
    double min = 0,
    double max = 1,
    int? divisions,
  }) => _controller
      .resolve(
        label,
        () => DoubleSliderKnob(
          label,
          initialValue,
          min: min,
          max: max,
          divisions: divisions,
        ),
      )
      .value;

  /// A double rendered as a numeric text input.
  double input({required String label, double initialValue = 0}) => _controller
      .resolve(label, () => DoubleInputKnob(label, initialValue))
      .value;
}
