import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';

/// A minimal [FormaThemeExtension] for widget tests.
const FormaThemeExtension testExtension = FormaThemeExtension(
  appBackground: Color(0xFF0E0B0F),
  cardBackground: Color(0xFF17131A),
  primaryColor: Color(0xFF9B2242),
  primarySurface: Color(0xFF2A121A),
  primaryBorder: Color(0xFF5A2334),
  secondaryColor: Color(0xFFC77A93),
  secondarySurface: Color(0xFF2A171D),
  accentColor: Color(0xFFC9A66B),
  accentSurface: Color(0xFF2A2417),
  textPrimary: Color(0xFFF5F1F4),
  textMuted: Color(0xFFB6ABB8),
  textHint: Color(0xFF7C7280),
  border: Color(0xFF2A2430),
  borderStrong: Color(0xFF3A3340),
  successColor: Color(0xFF4E9A6B),
  successSurface: Color(0xFF15271C),
  successText: Color(0xFF8FD9AB),
  warningColor: Color(0xFFD89A3F),
  warningSurface: Color(0xFF2A2113),
  warningText: Color(0xFFEEC07A),
  urgencySurface: Color(0xFF2E1413),
  errorColor: Color(0xFFE5484D),
  errorSurface: Color(0xFF2E1517),
  errorText: Color(0xFFF2999B),
  infoSurface: Color(0xFF15203A),
  infoText: Color(0xFFA8C2F7),
  primaryHover: Color(0xFFB12C50),
  primaryPress: Color(0xFF7E1A36),
  primarySubtle: Color(0xFF2A121A),
  onPrimary: Color(0xFFFFFFFF),
  surfaceElevated: Color(0xFF221B28),
);

/// Wraps [child] in a [MaterialApp] carrying [testExtension] so components
/// that read `Theme.of(context).extension<FormaThemeExtension>()` resolve.
Widget wrapForTest(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: const <ThemeExtension<dynamic>>[testExtension],
    ),
    home: Scaffold(body: Center(child: child)),
  );
}
