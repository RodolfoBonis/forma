import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaNumberField component — pt-BR numeric input with optional stepper.
GalleryComponent formaNumberFieldComponent() {
  return GalleryComponent(
    'FormaNumberField',
    docs: const ComponentDocs(
      description:
          'Numeric input accepting a comma decimal separator (pt-BR), clamping '
          'to min/max on blur, with optional prefix/suffix text and stepper '
          'chevrons.',
      props: [
        PropDoc('value', 'num?'),
        PropDoc('onChanged', 'ValueChanged<num?>', required: true),
        PropDoc('decimals', 'int', defaultValue: '0'),
        PropDoc('min', 'num?'),
        PropDoc('max', 'num?'),
        PropDoc(
          'step',
          'num?',
          description: 'Shows stepper chevrons when set.',
        ),
      ],
      codeSnippet: '''
FormaNumberField(
  label: 'Preço',
  prefixText: r'R\$',
  decimals: 2,
  value: price,
  onChanged: (v) => setState(() => price = v),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final decimals = k.int.slider(
          label: 'Decimals',
          initialValue: 2,
          max: 3,
        );
        final withStepper = k.boolean(label: 'Stepper', initialValue: false);
        return _NumberDemo(decimals: decimals, withStepper: withStepper);
      }),
    ],
  );
}

class _NumberDemo extends StatefulWidget {
  const _NumberDemo({required this.decimals, required this.withStepper});

  final int decimals;
  final bool withStepper;

  @override
  State<_NumberDemo> createState() => _NumberDemoState();
}

class _NumberDemoState extends State<_NumberDemo> {
  num? _value = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: 240,
          child: FormaNumberField(
            label: 'Preço',
            prefixText: r'R$',
            decimals: widget.decimals,
            min: 0,
            max: 1000,
            step: widget.withStepper ? 1 : null,
            value: _value,
            helperText: 'Valor atual: ${_value ?? '-'}',
            onChanged: (v) => setState(() => _value = v),
          ),
        ),
      ),
    );
  }
}
