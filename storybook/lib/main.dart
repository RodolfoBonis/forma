import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'themes/all_themes.dart';
import 'stories/tokens/color_palette.story.dart';
import 'stories/tokens/typography.story.dart';
import 'stories/tokens/spacing.story.dart';
import 'stories/tokens/border_radius.story.dart';
import 'stories/tokens/durations.story.dart';
import 'stories/components/buttons/forma_button.story.dart';
import 'stories/components/buttons/forma_icon_button.story.dart';
import 'stories/components/inputs/forma_text_field.story.dart';
import 'stories/components/inputs/forma_time_picker.story.dart';
import 'stories/components/display/forma_avatar.story.dart';
import 'stories/components/display/forma_badge.story.dart';
import 'stories/components/display/forma_card.story.dart';
import 'stories/components/display/forma_mode_toggle.story.dart';
import 'stories/components/display/forma_person_chip.story.dart';
import 'stories/components/display/forma_timeline.story.dart';
import 'stories/components/display/forma_whatsapp_preview.story.dart';
import 'stories/components/navigation/forma_bottom_nav.story.dart';
import 'stories/components/navigation/forma_app_header.story.dart';
import 'stories/components/feedback/forma_alert_banner.story.dart';
import 'stories/components/feedback/forma_loading.story.dart';
import 'stories/components/feedback/forma_push_notification.story.dart';
import 'stories/components/feedback/forma_urgency_header.story.dart';
import 'stories/components/overlay/forma_bottom_sheet.story.dart';
import 'stories/components/overlay/forma_step_indicator.story.dart';

/// Forma Design System — Widgetbook visual documentation.
void main() {
  runApp(const WidgetbookApp());
}

/// Root Widgetbook application.
class WidgetbookApp extends StatelessWidget {
  /// Creates the Widgetbook app.
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(themes: allThemes),
        ViewportAddon([
          IosViewports.iPhone13,
          IosViewports.iPadPro11Inches,
          AndroidViewports.samsungGalaxyS20,
        ]),
        TextScaleAddon(min: 1.0, max: 2.0, divisions: 5),
        AlignmentAddon(),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Tokens',
          children: [
            colorPaletteComponent(),
            typographyComponent(),
            spacingComponent(),
            borderRadiusComponent(),
            durationsComponent(),
          ],
        ),
        WidgetbookCategory(
          name: 'Components',
          children: [
            WidgetbookFolder(
              name: 'Buttons',
              children: [formaButtonComponent(), formaIconButtonComponent()],
            ),
            WidgetbookFolder(
              name: 'Inputs',
              children: [formaTextFieldComponent(), formaTimePickerComponent()],
            ),
            WidgetbookFolder(
              name: 'Display',
              children: [
                formaAvatarComponent(),
                formaBadgeComponent(),
                formaCardComponent(),
                formaModeToggleComponent(),
                formaPersonChipComponent(),
                formaTimelineComponent(),
                formaWhatsAppPreviewComponent(),
              ],
            ),
            WidgetbookFolder(
              name: 'Navigation',
              children: [formaBottomNavComponent(), formaAppHeaderComponent()],
            ),
            WidgetbookFolder(
              name: 'Feedback',
              children: [
                formaAlertBannerComponent(),
                formaLoadingComponent(),
                formaPushNotificationComponent(),
                formaUrgencyHeaderComponent(),
              ],
            ),
            WidgetbookFolder(
              name: 'Overlay',
              children: [
                formaBottomSheetComponent(),
                formaStepIndicatorComponent(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
