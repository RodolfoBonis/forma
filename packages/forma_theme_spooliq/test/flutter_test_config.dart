import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Auto-loaded before every test file in this package.
///
/// Disables Google Fonts runtime fetching so tests never make network calls
/// (which fail in CI). With fetching off, `GoogleFonts.getFont` throws and the
/// typography factory falls back to a plain `TextStyle`, which is the path we
/// want to exercise deterministically.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  await testMain();
}
