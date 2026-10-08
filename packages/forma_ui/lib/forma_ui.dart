/// Forma Design System — brand-agnostic UI primitives.
///
/// Buttons, inputs, cards, navigation, feedback and overlay components that
/// consume tokens and the theme contract from `forma_foundation` and icons
/// from `forma_icons`. No brand colors, no domain logic.
library;

// Foundation — re-exported so a single `forma_ui` import also brings tokens,
// the theme engine and the color/typography contracts that every primitive
// consumes.
export 'package:forma_foundation/forma_foundation.dart';

// Buttons
export 'src/components/buttons/forma_button.dart';
export 'src/components/buttons/forma_icon_button.dart';
export 'src/components/buttons/forma_text_button.dart';

// Inputs
export 'src/components/inputs/forma_select_chip.dart';
export 'src/components/inputs/forma_switch.dart';
export 'src/components/inputs/forma_text_field.dart';
export 'src/components/inputs/forma_time_picker.dart';

// Display
export 'src/components/display/forma_avatar.dart';
export 'src/components/display/forma_badge.dart';
export 'src/components/display/forma_card.dart';
export 'src/components/display/forma_chip.dart';
export 'src/components/display/forma_mode_toggle.dart';
export 'src/components/display/forma_settings_row.dart';
export 'src/components/display/forma_stat_tile.dart';
export 'src/components/display/forma_status_badge.dart';
export 'src/components/display/forma_timeline.dart';

// Navigation
export 'src/components/navigation/forma_app_header.dart';
export 'src/components/navigation/forma_bottom_nav.dart';
export 'src/components/navigation/forma_segmented_control.dart';

// Feedback
export 'src/components/feedback/forma_alert_banner.dart';
export 'src/components/feedback/forma_loading.dart';
export 'src/components/feedback/forma_push_notification.dart';
export 'src/components/feedback/forma_shimmer.dart';
export 'src/components/feedback/forma_skeleton.dart';

// Overlay
export 'src/components/overlay/forma_bottom_sheet.dart';
export 'src/components/overlay/forma_step_indicator.dart';

// Desktop — navigation, overlays & feedback
export 'src/components/display/forma_kbd.dart';
export 'src/components/feedback/forma_empty_state.dart';
export 'src/components/feedback/forma_toast.dart';
export 'src/components/navigation/forma_sidebar.dart';
export 'src/components/navigation/forma_tabs.dart';
export 'src/components/navigation/forma_top_bar.dart';
export 'src/components/overlay/forma_command_palette.dart';
export 'src/components/overlay/forma_dialog.dart';
export 'src/components/overlay/forma_menu_button.dart';
export 'src/components/overlay/forma_side_sheet.dart';

// (end desktop navigation)

// Desktop — data & inputs
export 'src/components/display/forma_data_table.dart';
export 'src/components/display/forma_kanban_board.dart';
export 'src/components/inputs/forma_checkbox.dart';
export 'src/components/inputs/forma_combobox.dart';
export 'src/components/inputs/forma_date_field.dart';
export 'src/components/inputs/forma_number_field.dart';
export 'src/components/inputs/forma_select.dart';
export 'src/components/navigation/forma_pagination.dart';

// (end desktop data)
