import 'package:flutter/material.dart';

import '../knobs/knob.dart';
import '../knobs/knobs_controller.dart';
import 'editors/color_editor.dart';

/// Right-panel "Controls" tab: renders one editor per registered knob and
/// writes edits back through the [controller], which rebuilds the preview.
class ControlsPanel extends StatelessWidget {
  /// Creates a controls panel bound to [controller].
  const ControlsPanel({required this.controller, super.key});

  /// The knob controller whose knobs are edited here.
  final KnobsController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final knobs = controller.knobs;
        if (knobs.isEmpty) {
          return const _EmptyControls();
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: knobs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, i) =>
              _KnobField(knob: knobs[i], controller: controller),
        );
      },
    );
  }
}

class _EmptyControls extends StatelessWidget {
  const _EmptyControls();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No controls for this use case.',
          style: TextStyle(color: Color(0xFF8A8F98), fontSize: 13),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Renders the label + the type-appropriate editor for a single knob.
class _KnobField extends StatelessWidget {
  const _KnobField({required this.knob, required this.controller});

  final Knob<Object?> knob;
  final KnobsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          knob.label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        _editorFor(knob),
      ],
    );
  }

  Widget _editorFor(Knob<Object?> knob) {
    switch (knob) {
      case StringKnob():
        return _TextEditor(
          initial: knob.value,
          onChanged: (v) => controller.setValue(knob, v),
        );
      case NullableStringKnob():
        return _TextEditor(
          initial: knob.value ?? '',
          onChanged: (v) => controller.setValue(knob, v.isEmpty ? null : v),
        );
      case BoolKnob():
        return _BoolEditor(
          value: knob.value,
          onChanged: (v) => controller.setValue(knob, v),
        );
      case IntSliderKnob():
        return _SliderEditor(
          value: knob.value.toDouble(),
          min: knob.min.toDouble(),
          max: knob.max.toDouble(),
          divisions: knob.divisions ?? (knob.max - knob.min),
          format: (v) => v.round().toString(),
          onChanged: (v) => controller.setValue(knob, v.round()),
        );
      case DoubleSliderKnob():
        return _SliderEditor(
          value: knob.value,
          min: knob.min,
          max: knob.max,
          divisions: knob.divisions,
          format: (v) => v.toStringAsFixed(1),
          onChanged: (v) => controller.setValue(knob, v),
        );
      case DoubleInputKnob():
        return _TextEditor(
          initial: knob.value.toString(),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (v) =>
              controller.setValue(knob, double.tryParse(v) ?? knob.value),
        );
      case ColorKnob():
        return ColorEditor(
          value: knob.value,
          onChanged: (v) => controller.setValue(knob, v),
        );
      case OptionsKnob():
        return _OptionsEditor(
          knob: knob,
          onChanged: (v) => controller.setValue(knob, v),
        );
    }
  }
}

class _TextEditor extends StatefulWidget {
  const _TextEditor({
    required this.initial,
    required this.onChanged,
    this.keyboardType,
  });

  final String initial;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;

  @override
  State<_TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<_TextEditor> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}

class _BoolEditor extends StatelessWidget {
  const _BoolEditor({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Switch(value: value, onChanged: onChanged),
    );
  }
}

class _SliderEditor extends StatelessWidget {
  const _SliderEditor({
    required this.value,
    required this.min,
    required this.max,
    required this.format,
    required this.onChanged,
    this.divisions,
  });

  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String Function(double) format;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(min, max);
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: clamped,
            min: min,
            max: max,
            divisions: (divisions != null && divisions! > 0) ? divisions : null,
            label: format(clamped),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            format(clamped),
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 12,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionsEditor extends StatelessWidget {
  const _OptionsEditor({required this.knob, required this.onChanged});

  final OptionsKnob<Object?> knob;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Object?>(
      initialValue: knob.value,
      isExpanded: true,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
      ),
      items: [
        for (final option in knob.options)
          DropdownMenuItem<Object?>(
            value: option,
            child: Text(knob.labelOf(option), overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
