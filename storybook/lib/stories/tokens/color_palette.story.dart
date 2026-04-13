import 'package:flutter/material.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:widgetbook/widgetbook.dart';

/// Color palette story — displays the full PfColors grid.
WidgetbookComponent colorPaletteComponent() {
  return WidgetbookComponent(
    name: 'Color Palette',
    useCases: [
      WidgetbookUseCase(
        name: 'All Colors',
        builder: (context) => const _ColorPaletteGrid(),
      ),
    ],
  );
}

class _ColorPaletteGrid extends StatelessWidget {
  const _ColorPaletteGrid();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Primary — Verde Floresta', const [
            _ColorSwatch('primary900', PfColors.primary900),
            _ColorSwatch('primary700', PfColors.primary700),
            _ColorSwatch('primary500', PfColors.primary500),
            _ColorSwatch('primary200', PfColors.primary200),
            _ColorSwatch('primary50', PfColors.primary50),
          ]),
          _section('Secondary — Indigo', const [
            _ColorSwatch('secondary700', PfColors.secondary700),
            _ColorSwatch('secondary500', PfColors.secondary500),
            _ColorSwatch('secondary200', PfColors.secondary200),
            _ColorSwatch('secondary50', PfColors.secondary50),
          ]),
          _section('Accent — Terracota', const [
            _ColorSwatch('accent700', PfColors.accent700),
            _ColorSwatch('accent500', PfColors.accent500),
            _ColorSwatch('accent200', PfColors.accent200),
            _ColorSwatch('accent50', PfColors.accent50),
          ]),
          _section('Neutrals', const [
            _ColorSwatch('neutral900', PfColors.neutral900),
            _ColorSwatch('neutral600', PfColors.neutral600),
            _ColorSwatch('neutral400', PfColors.neutral400),
            _ColorSwatch('neutral200', PfColors.neutral200),
            _ColorSwatch('neutral100', PfColors.neutral100),
            _ColorSwatch('neutral50', PfColors.neutral50),
            _ColorSwatch('white', PfColors.white),
          ]),
          _section('Semantic', const [
            _ColorSwatch('success', PfColors.success),
            _ColorSwatch('successSurface', PfColors.successSurface),
            _ColorSwatch('warning', PfColors.warning),
            _ColorSwatch('warningSurface', PfColors.warningSurface),
            _ColorSwatch('error', PfColors.error),
            _ColorSwatch('errorSurface', PfColors.errorSurface),
            _ColorSwatch('infoSurface', PfColors.infoSurface),
            _ColorSwatch('urgencySurface', PfColors.urgencySurface),
          ]),
          _section('Brand', const [
            _ColorSwatch('whatsApp', PfColors.whatsApp),
            _ColorSwatch('whatsAppDark', PfColors.whatsAppDark),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> swatches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: swatches),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final luminance = color.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black : Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: Text(
            '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(color: textColor, fontSize: 10),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
