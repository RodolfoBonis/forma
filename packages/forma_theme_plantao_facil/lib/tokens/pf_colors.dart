import 'package:flutter/painting.dart';

/// Plantao Facil color palette tokens.
///
/// Verde Floresta primary, Indigo secondary, Terracota accent —
/// plus neutrals, semantic states, and brand colors.
abstract class PfColors {
  // ---------------------------------------------------------------------------
  // Primary — Verde Floresta
  // ---------------------------------------------------------------------------

  /// Deep forest green.
  static const Color primary900 = Color(0xFF0D5238);

  /// Main primary green.
  static const Color primary700 = Color(0xFF1A6B4A);

  /// Medium primary green.
  static const Color primary500 = Color(0xFF2D8A64);

  /// Light primary tint.
  static const Color primary200 = Color(0xFFB8E0CD);

  /// Very light primary surface.
  static const Color primary50 = Color(0xFFDCF0E7);

  // ---------------------------------------------------------------------------
  // Secondary — Indigo
  // ---------------------------------------------------------------------------

  /// Deep indigo.
  static const Color secondary700 = Color(0xFF3D3399);

  /// Main secondary indigo.
  static const Color secondary500 = Color(0xFF5549C8);

  /// Light indigo tint.
  static const Color secondary200 = Color(0xFFC9C5EF);

  /// Very light indigo surface.
  static const Color secondary50 = Color(0xFFECEAF9);

  // ---------------------------------------------------------------------------
  // Accent — Terracota
  // ---------------------------------------------------------------------------

  /// Deep terracotta.
  static const Color accent700 = Color(0xFF9E3E18);

  /// Main accent terracotta.
  static const Color accent500 = Color(0xFFC45422);

  /// Light terracotta tint.
  static const Color accent200 = Color(0xFFF3CEAD);

  /// Very light terracotta surface.
  static const Color accent50 = Color(0xFFFAEADE);

  // ---------------------------------------------------------------------------
  // Neutrals
  // ---------------------------------------------------------------------------

  /// Near-black text.
  static const Color neutral900 = Color(0xFF0F0F0F);

  /// Dark gray — secondary text.
  static const Color neutral600 = Color(0xFF6B6560);

  /// Medium gray — hints.
  static const Color neutral400 = Color(0xFF9B9693);

  /// Light gray — borders.
  static const Color neutral200 = Color(0xFFE8E4DC);

  /// Off-white — card backgrounds.
  static const Color neutral100 = Color(0xFFF5F3EF);

  /// Warm off-white — app background.
  static const Color neutral50 = Color(0xFFF0ECE4);

  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Semantic — Success
  // ---------------------------------------------------------------------------

  /// Success indicator color.
  static const Color success = Color(0xFF1A6B4A);

  /// Success surface background.
  static const Color successSurface = Color(0xFFD4EDDA);

  /// Success foreground text.
  static const Color successText = Color(0xFF1A6B30);

  // ---------------------------------------------------------------------------
  // Semantic — Warning
  // ---------------------------------------------------------------------------

  /// Warning indicator color.
  static const Color warning = Color(0xFFE8B84B);

  /// Warning surface background.
  static const Color warningSurface = Color(0xFFFFF3CC);

  /// Warning foreground text.
  static const Color warningText = Color(0xFF92600A);

  /// Urgency surface background (high-priority items).
  static const Color urgencySurface = Color(0xFFFFF8E8);

  // ---------------------------------------------------------------------------
  // Semantic — Error
  // ---------------------------------------------------------------------------

  /// Error / destructive indicator color.
  static const Color error = Color(0xFFC0392B);

  /// Error surface background.
  static const Color errorSurface = Color(0xFFFDDEDE);

  /// Error foreground text.
  static const Color errorText = Color(0xFF922B21);

  // ---------------------------------------------------------------------------
  // Semantic — Info
  // ---------------------------------------------------------------------------

  /// Informational surface background.
  static const Color infoSurface = Color(0xFFECEAF9);

  /// Informational foreground text.
  static const Color infoText = Color(0xFF3D3399);

  // ---------------------------------------------------------------------------
  // Brand
  // ---------------------------------------------------------------------------

  /// WhatsApp brand green.
  static const Color whatsApp = Color(0xFF25D366);

  /// WhatsApp dark brand green.
  static const Color whatsAppDark = Color(0xFF128C7E);
}
