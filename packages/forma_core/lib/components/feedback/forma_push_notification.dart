import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_radius.dart';
import '../../tokens/forma_spacing.dart';
import '../../tokens/forma_typography.dart';

/// A push notification preview banner following Forma Design System specs.
///
/// Resembles an iOS/Android system push notification with app icon,
/// app name, timestamp, and message body.
class FormaPushNotification extends StatelessWidget {
  /// Creates a [FormaPushNotification].
  const FormaPushNotification({
    super.key,
    required this.appName,
    required this.body,
    this.appIcon,
    this.timestamp = 'agora',
  });

  /// The name of the app displayed in the header.
  final String appName;

  /// The notification message body.
  final String body;

  /// Optional app icon widget. Defaults to a colored circle with the
  /// first letter of [appName].
  final Widget? appIcon;

  /// Timestamp label displayed next to the app name.
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.all(FormaSpacing.md),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: BorderRadius.circular(FormaRadius.cardLg),
        border: Border.all(color: ext.border, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildAppIcon(ext),
              const SizedBox(width: FormaSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appName,
                      style: FormaTypography.body14Medium.copyWith(
                        color: ext.textPrimary,
                      ),
                    ),
                    Text(
                      timestamp,
                      style: FormaTypography.caption12.copyWith(
                        color: ext.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: FormaSpacing.sm),
          Text(
            body,
            style: FormaTypography.body13.copyWith(color: ext.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildAppIcon(FormaThemeExtension ext) {
    if (appIcon != null) return SizedBox(width: 44, height: 44, child: appIcon);

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: ext.primaryColor,
        borderRadius: BorderRadius.circular(FormaRadius.small),
      ),
      alignment: Alignment.center,
      child: Text(
        appName.isNotEmpty ? appName[0].toUpperCase() : '',
        style: FormaTypography.title18.copyWith(color: Colors.white),
      ),
    );
  }
}
