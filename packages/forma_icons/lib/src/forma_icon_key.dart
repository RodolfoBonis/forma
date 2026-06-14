/// Semantic icon identities used across Forma components.
///
/// Components reference icons by intent (e.g. [FormaIconKey.confirm]) rather
/// than by a concrete glyph, so a brand can swap the rendering for any key —
/// Material default or its own SVG — without touching component code.
enum FormaIconKey {
  /// Home / dashboard destination.
  home,

  /// Calendar / schedule destination.
  calendar,

  /// Settings / preferences.
  settings,

  /// Generic person / profile.
  person,

  /// Search.
  search,

  /// Notification bell.
  notification,

  /// Affirmative / confirm / done.
  confirm,

  /// Dismiss / close.
  close,

  /// Navigate back.
  back,

  /// Navigate forward.
  forward,

  /// Expand / chevron down.
  chevronDown,

  /// Collapse / chevron up.
  chevronUp,

  /// Add / create.
  add,

  /// Edit / modify.
  edit,

  /// Delete / remove.
  delete,

  /// Overflow / more actions.
  more,

  /// Time / clock.
  time,

  /// Show content (visibility on).
  visibility,

  /// Hide content (visibility off).
  visibilityOff,

  /// Success state.
  success,

  /// Warning state.
  warning,

  /// Error state.
  error,

  /// Informational state.
  info,
}
