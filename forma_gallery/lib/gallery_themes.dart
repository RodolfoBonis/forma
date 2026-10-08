import 'package:forma_gallery/forma_gallery.dart';
import 'package:forma_theme_dominus/forma_theme_dominus.dart';
import 'package:forma_theme_plantao_facil/forma_theme_plantao_facil.dart';
import 'package:forma_theme_spooliq/forma_theme_spooliq.dart';

/// Themes selectable from the gallery toolbar.
final List<GalleryTheme> galleryThemes = [
  GalleryTheme('Plantão Fácil Light', PlantaoFacilTheme.light),
  GalleryTheme('Dominus Dark', DominusTheme.dark),
  GalleryTheme('SpoolIQ Light', SpooliqTheme.light),
  GalleryTheme('SpoolIQ Dark', SpooliqTheme.dark),
];
