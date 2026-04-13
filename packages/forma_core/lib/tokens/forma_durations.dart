/// Animation duration tokens for the Forma Design System.
///
/// Provides consistent timing values for transitions and animations.
abstract class FormaDurations {
  /// 220ms — quick fade / opacity transitions.
  static const Duration fade = Duration(milliseconds: 220);

  /// 280ms — standard smart animation for most UI transitions.
  static const Duration smart = Duration(milliseconds: 280);

  /// 400ms — slow, deliberate transitions (e.g. page changes).
  static const Duration slow = Duration(milliseconds: 400);
}
