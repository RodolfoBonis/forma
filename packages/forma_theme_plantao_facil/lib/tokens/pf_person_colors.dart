import 'package:flutter/painting.dart';

/// Person-specific color assignments for Plantao Facil.
///
/// Each person gets a distinct hue with a matching light surface variant
/// for avatar backgrounds, chips, and inline highlights.
abstract class PfPersonColors {
  /// Ana — primary green.
  static const Color ana = Color(0xFF1A6B4A);

  /// Ana light surface.
  static const Color anaSurface = Color(0xFFDCF0E7);

  /// Diogenes — secondary indigo.
  static const Color diogenes = Color(0xFF5549C8);

  /// Diogenes light surface.
  static const Color diogenesSurface = Color(0xFFECEAF9);

  /// Augusto — accent terracotta.
  static const Color augusto = Color(0xFFC45422);

  /// Augusto light surface.
  static const Color augustoSurface = Color(0xFFFAEADE);
}
