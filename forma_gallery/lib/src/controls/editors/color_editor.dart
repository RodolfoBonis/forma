import 'package:flutter/material.dart';

/// A compact color editor: a preset swatch grid plus a hex text field.
///
/// Deliberately dependency-free — no external color-picker package. Sufficient
/// for design-system knobs, where colors are usually picked from a palette.
class ColorEditor extends StatelessWidget {
  /// Creates a color editor for [value].
  const ColorEditor({required this.value, required this.onChanged, super.key});

  /// Current color.
  final Color value;

  /// Called with the newly picked color.
  final ValueChanged<Color> onChanged;

  static const List<Color> _swatches = [
    Color(0xFF000000),
    Color(0xFFFFFFFF),
    Color(0xFF9B2242),
    Color(0xFFC9A66B),
    Color(0xFF2E7D32),
    Color(0xFF1565C0),
    Color(0xFFE65100),
    Color(0xFFB71C1C),
    Color(0xFF6A1B9A),
    Color(0xFF00838F),
    Color(0xFF424242),
    Color(0xFF9E9E9E),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final swatch in _swatches)
              _Swatch(
                color: swatch,
                selected: swatch.toARGB32() == value.toARGB32(),
                onTap: () => onChanged(swatch),
              ),
          ],
        ),
        const SizedBox(height: 8),
        _HexField(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: selected ? const Color(0xFF1565C0) : const Color(0x33000000),
            width: selected ? 2 : 1,
          ),
        ),
      ),
    );
  }
}

class _HexField extends StatefulWidget {
  const _HexField({required this.value, required this.onChanged});

  final Color value;
  final ValueChanged<Color> onChanged;

  @override
  State<_HexField> createState() => _HexFieldState();
}

class _HexFieldState extends State<_HexField> {
  late final TextEditingController _controller = TextEditingController(
    text: _hex(widget.value),
  );

  static String _hex(Color color) =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

  @override
  void didUpdateWidget(_HexField old) {
    super.didUpdateWidget(old);
    final next = _hex(widget.value);
    if (next != _controller.text) _controller.text = next;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit(String raw) {
    var hex = raw.replaceAll('#', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    final parsed = int.tryParse(hex, radix: 16);
    if (parsed != null) widget.onChanged(Color(parsed));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        isDense: true,
        prefixText: '',
        border: OutlineInputBorder(),
        hintText: '#AARRGGBB',
      ),
      onSubmitted: _submit,
    );
  }
}
