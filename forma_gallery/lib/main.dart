import 'package:flutter/material.dart';
import 'package:forma_gallery/forma_gallery.dart';

import 'gallery_catalog.dart';
import 'gallery_themes.dart';

/// Forma Design System — custom gallery & docs showcase.
void main() {
  runApp(GalleryApp(root: galleryRoot, themes: galleryThemes));
}
