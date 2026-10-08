import 'package:forma_gallery/forma_gallery.dart';

import 'stories/components/buttons/forma_button.story.dart';
import 'stories/components/buttons/forma_icon_button.story.dart';
import 'stories/components/buttons/forma_text_button.story.dart';
import 'stories/components/desktop/forma_checkbox.story.dart';
import 'stories/components/desktop/forma_combobox.story.dart';
import 'stories/components/desktop/forma_command_palette.story.dart';
import 'stories/components/desktop/forma_data_table.story.dart';
import 'stories/components/desktop/forma_date_field.story.dart';
import 'stories/components/desktop/forma_dialog.story.dart';
import 'stories/components/desktop/forma_empty_state.story.dart';
import 'stories/components/desktop/forma_kanban_board.story.dart';
import 'stories/components/desktop/forma_kbd.story.dart';
import 'stories/components/desktop/forma_menu_button.story.dart';
import 'stories/components/desktop/forma_number_field.story.dart';
import 'stories/components/desktop/forma_pagination.story.dart';
import 'stories/components/desktop/forma_select.story.dart';
import 'stories/components/desktop/forma_side_sheet.story.dart';
import 'stories/components/desktop/forma_sidebar.story.dart';
import 'stories/components/desktop/forma_tabs.story.dart';
import 'stories/components/desktop/forma_toast.story.dart';
import 'stories/components/desktop/forma_top_bar.story.dart';
import 'stories/components/display/forma_avatar.story.dart';
import 'stories/components/display/forma_badge.story.dart';
import 'stories/components/display/forma_card.story.dart';
import 'stories/components/display/forma_chip.story.dart';
import 'stories/components/display/forma_mode_toggle.story.dart';
import 'stories/components/display/forma_settings_row.story.dart';
import 'stories/components/display/forma_stat_tile.story.dart';
import 'stories/components/display/forma_status_badge.story.dart';
import 'stories/components/display/forma_timeline.story.dart';
import 'stories/components/feedback/forma_alert_banner.story.dart';
import 'stories/components/feedback/forma_loading.story.dart';
import 'stories/components/feedback/forma_push_notification.story.dart';
import 'stories/components/inputs/forma_select_chip.story.dart';
import 'stories/components/inputs/forma_switch.story.dart';
import 'stories/components/inputs/forma_text_field.story.dart';
import 'stories/components/inputs/forma_time_picker.story.dart';
import 'stories/components/navigation/forma_app_header.story.dart';
import 'stories/components/navigation/forma_bottom_nav.story.dart';
import 'stories/components/navigation/forma_segmented_control.story.dart';
import 'stories/components/overlay/forma_bottom_sheet.story.dart';
import 'stories/components/overlay/forma_step_indicator.story.dart';
import 'stories/tokens/border_radius.story.dart';
import 'stories/tokens/color_palette.story.dart';
import 'stories/tokens/durations.story.dart';
import 'stories/tokens/spacing.story.dart';
import 'stories/tokens/typography.story.dart';

/// The gallery navigation tree. Mirrors the previous Widgetbook directories.
final List<GalleryNode> galleryRoot = [
  GalleryFolder(
    'Tokens',
    children: [
      colorPaletteComponent(),
      typographyComponent(),
      spacingComponent(),
      borderRadiusComponent(),
      durationsComponent(),
    ],
  ),
  GalleryFolder(
    'Components',
    children: [
      GalleryFolder(
        'Buttons',
        children: [
          formaButtonComponent(),
          formaIconButtonComponent(),
          formaTextButtonComponent(),
        ],
      ),
      GalleryFolder(
        'Inputs',
        children: [
          formaTextFieldComponent(),
          formaTimePickerComponent(),
          formaSelectChipComponent(),
          formaSwitchComponent(),
        ],
      ),
      GalleryFolder(
        'Display',
        children: [
          formaAvatarComponent(),
          formaBadgeComponent(),
          formaCardComponent(),
          formaModeToggleComponent(),
          formaTimelineComponent(),
          formaStatTileComponent(),
          formaSettingsRowComponent(),
          formaChipComponent(),
          formaStatusBadgeComponent(),
        ],
      ),
      GalleryFolder(
        'Navigation',
        children: [
          formaBottomNavComponent(),
          formaAppHeaderComponent(),
          formaSegmentedControlComponent(),
        ],
      ),
      GalleryFolder(
        'Feedback',
        children: [
          formaAlertBannerComponent(),
          formaLoadingComponent(),
          formaPushNotificationComponent(),
        ],
      ),
      GalleryFolder(
        'Overlay',
        children: [formaBottomSheetComponent(), formaStepIndicatorComponent()],
      ),
    ],
  ),
  GalleryFolder(
    'Desktop',
    children: [
      GalleryFolder(
        'Navigation & Overlays',
        children: [
          formaSidebarComponent(),
          formaTopBarComponent(),
          formaTabsComponent(),
          formaDialogComponent(),
          formaSideSheetComponent(),
          formaCommandPaletteComponent(),
          formaMenuButtonComponent(),
          formaToastComponent(),
          formaEmptyStateComponent(),
          formaKbdComponent(),
          // (desktop navigation stories)
        ],
      ),
      GalleryFolder(
        'Data & Inputs',
        children: [
          formaDataTableComponent(),
          formaKanbanBoardComponent(),
          formaSelectComponent(),
          formaComboboxComponent(),
          formaCheckboxComponent(),
          formaDateFieldComponent(),
          formaNumberFieldComponent(),
          formaPaginationComponent(),
          // (desktop data stories)
        ],
      ),
    ],
  ),
];
