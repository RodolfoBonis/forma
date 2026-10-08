import 'package:flutter/material.dart';
import 'package:forma_ui/forma_ui.dart';

import '../test_theme.dart';

/// Wraps [child] like [wrapForTest] but also registers
/// [FormaShapeExtension.desktop] so compact (pointer-first) sizing is exercised.
Widget wrapForDesktopTest(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: <ThemeExtension<dynamic>>[
        testExtension,
        FormaTypographyExtension.fromFont('Inter'),
        FormaShapeExtension.desktop,
      ],
    ),
    home: Scaffold(body: child),
  );
}

/// A desktop-sized wrapper that also exposes an element through which overlays
/// (dialogs, toasts, sheets) can be launched. The returned [child] is centered
/// inside a generous viewport.
Widget wrapForDesktopOverlayTest(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: <ThemeExtension<dynamic>>[
        testExtension,
        FormaTypographyExtension.fromFont('Inter'),
        FormaShapeExtension.desktop,
      ],
    ),
    home: Scaffold(body: Center(child: child)),
  );
}
