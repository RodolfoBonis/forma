import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// Color palette token — the active theme's semantic palette, read live from
/// its [FormaThemeExtension] so it reflects the selected theme (Plantão Fácil
/// or Dominus), not hard-coded brand constants.
GalleryComponent colorPaletteComponent() {
  return GalleryComponent(
    'Color Palette',
    docs: const ComponentDocs(
      description:
          'The semantic color palette of the currently selected theme, read '
          'from FormaThemeExtension. Switch themes in the toolbar to compare. '
          'In app code, always read colors from the extension rather than from '
          'raw brand constants so your UI adapts across themes.',
      codeSnippet: '''
final colors = Theme.of(context).extension<FormaThemeExtension>()!;
final primary = colors.primaryColor;
final surface = colors.cardBackground;''',
    ),
    useCases: [UseCase('Semantic', (context, k) => const _SemanticPalette())],
  );
}

class _SemanticPalette extends StatelessWidget {
  const _SemanticPalette();

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _section('Backgrounds', [
            _Swatch('appBackground', ext.appBackground),
            _Swatch('cardBackground', ext.cardBackground),
            _Swatch('surfaceElevated', ext.resolvedSurfaceElevated),
          ]),
          _section('Primary', [
            _Swatch('primaryColor', ext.primaryColor),
            _Swatch('primarySurface', ext.primarySurface),
            _Swatch('primaryBorder', ext.primaryBorder),
            _Swatch('primaryHover', ext.resolvedPrimaryHover),
            _Swatch('primaryPress', ext.resolvedPrimaryPress),
            _Swatch('primarySubtle', ext.resolvedPrimarySubtle),
            _Swatch('onPrimary', ext.resolvedOnPrimary),
          ]),
          _section('Secondary', [
            _Swatch('secondaryColor', ext.secondaryColor),
            _Swatch('secondarySurface', ext.secondarySurface),
          ]),
          _section('Accent', [
            _Swatch('accentColor', ext.accentColor),
            _Swatch('accentSurface', ext.accentSurface),
          ]),
          _section('Text', [
            _Swatch('textPrimary', ext.textPrimary),
            _Swatch('textMuted', ext.textMuted),
            _Swatch('textHint', ext.textHint),
          ]),
          _section('Borders', [
            _Swatch('border', ext.border),
            _Swatch('borderStrong', ext.borderStrong),
          ]),
          _section('Semantic', [
            _Swatch('successColor', ext.successColor),
            _Swatch('successSurface', ext.successSurface),
            _Swatch('successText', ext.successText),
            _Swatch('warningColor', ext.warningColor),
            _Swatch('warningSurface', ext.warningSurface),
            _Swatch('warningText', ext.warningText),
            _Swatch('errorColor', ext.errorColor),
            _Swatch('errorSurface', ext.errorSurface),
            _Swatch('errorText', ext.errorText),
            _Swatch('infoSurface', ext.infoSurface),
            _Swatch('infoText', ext.infoText),
            _Swatch('urgencySurface', ext.urgencySurface),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> swatches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: swatches),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textColor = color.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88,
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
          width: 88,
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
