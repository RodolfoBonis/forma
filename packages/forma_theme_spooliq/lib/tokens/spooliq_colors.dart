import 'package:flutter/painting.dart';

/// SpoolIQ brand palette, mirrored from the spooliq-web Tailwind config.
///
/// Coral primary, teal accent and a warm neutral scale. Light and dark
/// surfaces are split into [SpooliqColors] (raw scale) and the semantic
/// mapping done in `SpooliqTheme`.
abstract final class SpooliqColors {
  // Primary — coral.
  static const Color primary50 = Color(0xFFFFF5F5);
  static const Color primary100 = Color(0xFFFFE3E3);
  static const Color primary200 = Color(0xFFFFC9C9);
  static const Color primary300 = Color(0xFFFFA8A8);
  static const Color primary400 = Color(0xFFFF8787);
  static const Color primary500 = Color(0xFFFF6B6B);
  static const Color primary600 = Color(0xFFE85D5D);
  static const Color primary700 = Color(0xFFC94F4F);
  static const Color primary800 = Color(0xFFA84141);
  static const Color primary900 = Color(0xFF873434);

  // Accent — teal.
  static const Color accent50 = Color(0xFFE6F7F7);
  static const Color accent100 = Color(0xFFC2EDED);
  static const Color accent300 = Color(0xFF74D9D9);
  static const Color accent500 = Color(0xFF26C5C5);
  static const Color accent600 = Color(0xFF20A5A5);
  static const Color accent700 = Color(0xFF1A8585);
  static const Color accent900 = Color(0xFF0E4545);

  // Neutral.
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF7F7F7);
  static const Color neutral100 = Color(0xFFE9E9E9);
  static const Color neutral150 = Color(0xFFE8E8E8);
  static const Color neutral200 = Color(0xFFD9D9D9);
  static const Color neutral300 = Color(0xFFC4C4C4);
  static const Color neutral400 = Color(0xFF9D9D9D);
  static const Color neutral500 = Color(0xFF7B7B7B);
  static const Color neutral600 = Color(0xFF555555);
  static const Color neutral700 = Color(0xFF434343);
  static const Color neutral800 = Color(0xFF2E2E2E);
  static const Color neutral850 = Color(0xFF262626);
  static const Color neutral900 = Color(0xFF222222);
  static const Color neutral950 = Color(0xFF1A1A1A);
  static const Color neutral1000 = Color(0xFF141414);

  // Semantic.
  static const Color success = Color(0xFF00A699);
  static const Color successLight = Color(0xFFD4EDDA);
  static const Color successDark = Color(0xFF008489);
  static const Color warning = Color(0xFFF4A261);
  static const Color warningLight = Color(0xFFFFF3CD);
  static const Color warningDark = Color(0xFFB4532A);
  static const Color error = Color(0xFFD93025);
  static const Color errorLight = Color(0xFFF8D7DA);
  static const Color errorDark = Color(0xFFB71C1C);
  static const Color info = Color(0xFF0288D1);
  static const Color infoLight = Color(0xFFD1ECF1);
  static const Color infoDark = Color(0xFF01579B);
}
