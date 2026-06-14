/// Forma Design System — shared Flutter components, tokens, and theme
/// architecture for multi-app consistency.
library forma_core;

// Foundation — re-exported for backward compatibility.
//
// Tokens, the theme engine, the FormaThemeExtension / FormaTypographyExtension
// contracts, and utils now live in the `forma_foundation` package. Prefer
// importing `package:forma_foundation/forma_foundation.dart` directly in new
// code.
export 'package:forma_foundation/forma_foundation.dart';

// UI primitives — re-exported for backward compatibility.
//
// Buttons, inputs, cards, navigation, feedback and overlay primitives now
// live in the `forma_ui` package. Prefer importing
// `package:forma_ui/forma_ui.dart` directly in new code.
export 'package:forma_ui/forma_ui.dart';

// Domain components (transitional).
//
// These are app-specific widgets pending extraction to their owning app
// repositories. They will be removed in a future major; do not build new
// dependencies on them here.
export 'components/display/forma_order_card.dart';
export 'components/display/forma_person_chip.dart';
export 'components/display/forma_proof_icon.dart';
export 'components/display/forma_role_badge.dart';
export 'components/display/forma_whatsapp_preview.dart';
export 'components/feedback/forma_urgency_header.dart';
