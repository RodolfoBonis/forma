import 'package:flutter/material.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:widgetbook/widgetbook.dart';

/// All available theme configurations for the Widgetbook.
final List<WidgetbookTheme<ThemeData>> allThemes = [
  WidgetbookTheme(name: 'Plantao Facil Light', data: PlantaoFacilTheme.light),
  WidgetbookTheme(name: 'Dominus Dark', data: DominusTheme.dark),
];
