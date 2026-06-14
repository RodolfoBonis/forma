/// Forma Design System — compatibility facade.
///
/// Re-exports the layered packages so existing imports of `forma_core` keep
/// working. New code should depend on the specific layers directly:
/// `forma_foundation` (tokens + theme), `forma_ui` (primitives) and
/// `forma_icons`.
library forma_core;

// Foundation — tokens, theme engine, color & typography contracts, utils.
export 'package:forma_foundation/forma_foundation.dart';

// UI primitives — buttons, inputs, cards, navigation, feedback, overlays.
export 'package:forma_ui/forma_ui.dart';
