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

// Components — Buttons
export 'components/buttons/forma_button.dart';
export 'components/buttons/forma_icon_button.dart';

// Components — Inputs
export 'components/inputs/forma_text_field.dart';
export 'components/inputs/forma_time_picker.dart';
export 'components/inputs/forma_select_chip.dart';
export 'components/inputs/forma_switch.dart';

// Components — Display
export 'components/display/forma_avatar.dart';
export 'components/display/forma_badge.dart';
export 'components/display/forma_card.dart';
export 'components/display/forma_mode_toggle.dart';
export 'components/display/forma_person_chip.dart';
export 'components/display/forma_timeline.dart';
export 'components/display/forma_whatsapp_preview.dart';
export 'components/display/forma_stat_tile.dart';
export 'components/display/forma_settings_row.dart';
export 'components/display/forma_role_badge.dart';
export 'components/display/forma_order_card.dart';
export 'components/display/forma_proof_icon.dart';
export 'components/display/forma_chip.dart';
export 'components/display/forma_status_badge.dart';

// Components — Navigation
export 'components/navigation/forma_bottom_nav.dart';
export 'components/navigation/forma_app_header.dart';
export 'components/navigation/forma_segmented_control.dart';

// Components — Feedback
export 'components/feedback/forma_alert_banner.dart';
export 'components/feedback/forma_loading.dart';
export 'components/feedback/forma_shimmer.dart';
export 'components/feedback/forma_skeleton.dart';
export 'components/feedback/forma_push_notification.dart';
export 'components/feedback/forma_urgency_header.dart';

// Components — Overlay
export 'components/overlay/forma_bottom_sheet.dart';
export 'components/overlay/forma_step_indicator.dart';
