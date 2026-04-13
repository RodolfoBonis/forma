import 'package:flutter/painting.dart';

/// Placeholder color tokens for a new Forma theme variant.
///
/// Replace these Material-default grays with your brand palette.
abstract class TemplateColors {
  // ---------------------------------------------------------------------------
  // Primary
  // ---------------------------------------------------------------------------

  /// Deep primary.
  static const Color primary900 = Color(0xFF1565C0);

  /// Main primary.
  static const Color primary700 = Color(0xFF1976D2);

  /// Medium primary.
  static const Color primary500 = Color(0xFF2196F3);

  /// Light primary tint.
  static const Color primary200 = Color(0xFF90CAF9);

  /// Very light primary surface.
  static const Color primary50 = Color(0xFFE3F2FD);

  // ---------------------------------------------------------------------------
  // Secondary
  // ---------------------------------------------------------------------------

  /// Deep secondary.
  static const Color secondary700 = Color(0xFF7B1FA2);

  /// Main secondary.
  static const Color secondary500 = Color(0xFF9C27B0);

  /// Light secondary tint.
  static const Color secondary200 = Color(0xFFCE93D8);

  /// Very light secondary surface.
  static const Color secondary50 = Color(0xFFF3E5F5);

  // ---------------------------------------------------------------------------
  // Accent
  // ---------------------------------------------------------------------------

  /// Deep accent.
  static const Color accent700 = Color(0xFFF57C00);

  /// Main accent.
  static const Color accent500 = Color(0xFFFF9800);

  /// Light accent tint.
  static const Color accent200 = Color(0xFFFFCC80);

  /// Very light accent surface.
  static const Color accent50 = Color(0xFFFFF3E0);

  // ---------------------------------------------------------------------------
  // Neutrals
  // ---------------------------------------------------------------------------

  /// Near-black text.
  static const Color neutral900 = Color(0xFF212121);

  /// Dark gray — secondary text.
  static const Color neutral600 = Color(0xFF757575);

  /// Medium gray — hints.
  static const Color neutral400 = Color(0xFFBDBDBD);

  /// Light gray — borders.
  static const Color neutral200 = Color(0xFFEEEEEE);

  /// Off-white — card backgrounds.
  static const Color neutral100 = Color(0xFFF5F5F5);

  /// App background.
  static const Color neutral50 = Color(0xFFFAFAFA);

  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);

  // ---------------------------------------------------------------------------
  // Semantic — Success
  // ---------------------------------------------------------------------------

  /// Success indicator.
  static const Color success = Color(0xFF388E3C);

  /// Success surface.
  static const Color successSurface = Color(0xFFC8E6C9);

  /// Success text.
  static const Color successText = Color(0xFF2E7D32);

  // ---------------------------------------------------------------------------
  // Semantic — Warning
  // ---------------------------------------------------------------------------

  /// Warning indicator.
  static const Color warning = Color(0xFFFFA000);

  /// Warning surface.
  static const Color warningSurface = Color(0xFFFFF8E1);

  /// Warning text.
  static const Color warningText = Color(0xFFE65100);

  /// Urgency surface.
  static const Color urgencySurface = Color(0xFFFFF3E0);

  // ---------------------------------------------------------------------------
  // Semantic — Error
  // ---------------------------------------------------------------------------

  /// Error indicator.
  static const Color error = Color(0xFFD32F2F);

  /// Error surface.
  static const Color errorSurface = Color(0xFFFFCDD2);

  /// Error text.
  static const Color errorText = Color(0xFFC62828);

  // ---------------------------------------------------------------------------
  // Semantic — Info
  // ---------------------------------------------------------------------------

  /// Info surface.
  static const Color infoSurface = Color(0xFFE3F2FD);

  /// Info text.
  static const Color infoText = Color(0xFF1565C0);
}
