import 'package:flutter/widgets.dart';

/// A single interactive control declared by a use-case builder.
///
/// Knobs are identified by their [label] within a use case. A builder both
/// *declares* a knob (first time it is seen during a build pass) and *reads*
/// its current [value]; the controls panel renders an editor that mutates the
/// same instance. See [KnobsController] for the register-on-build mechanism.
sealed class Knob<T> {
  /// Creates a knob with a [label] identity and an initial [value].
  Knob(this.label, this.value);

  /// Unique label within the current use case; doubles as the field title.
  final String label;

  /// Current value, edited live by the controls panel.
  T value;

  /// Marked on every build pass; knobs left unseen are pruned afterwards.
  bool seen = true;
}

/// A free-form text knob.
final class StringKnob extends Knob<String> {
  /// Creates a [StringKnob].
  StringKnob(super.label, super.value);
}

/// A text knob whose value may be null (empty field → null).
final class NullableStringKnob extends Knob<String?> {
  /// Creates a [NullableStringKnob].
  NullableStringKnob(super.label, super.value);
}

/// An on/off knob rendered as a switch.
final class BoolKnob extends Knob<bool> {
  /// Creates a [BoolKnob].
  BoolKnob(super.label, super.value);
}

/// An integer knob rendered as a discrete slider.
final class IntSliderKnob extends Knob<int> {
  /// Creates an [IntSliderKnob] bounded by [min]/[max].
  IntSliderKnob(
    super.label,
    super.value, {
    required this.min,
    required this.max,
    this.divisions,
  });

  /// Lowest selectable value.
  final int min;

  /// Highest selectable value.
  final int max;

  /// Optional number of discrete steps.
  final int? divisions;
}

/// A double knob rendered as a continuous slider.
final class DoubleSliderKnob extends Knob<double> {
  /// Creates a [DoubleSliderKnob] bounded by [min]/[max].
  DoubleSliderKnob(
    super.label,
    super.value, {
    required this.min,
    required this.max,
    this.divisions,
  });

  /// Lowest selectable value.
  final double min;

  /// Highest selectable value.
  final double max;

  /// Optional number of discrete steps.
  final int? divisions;
}

/// A double knob rendered as a numeric text input.
final class DoubleInputKnob extends Knob<double> {
  /// Creates a [DoubleInputKnob].
  DoubleInputKnob(super.label, super.value);
}

/// A color knob rendered as a swatch grid + hex field.
final class ColorKnob extends Knob<Color> {
  /// Creates a [ColorKnob].
  ColorKnob(super.label, super.value);
}

/// A pick-one-of knob rendered as a dropdown.
final class OptionsKnob<T> extends Knob<T> {
  /// Creates an [OptionsKnob] over [options], labelled via [labelOf].
  OptionsKnob(
    super.label,
    super.value, {
    required this.options,
    required this.labelOf,
  });

  /// The selectable options, in display order.
  final List<T> options;

  /// Maps an option to its human-readable label.
  final String Function(T) labelOf;
}
