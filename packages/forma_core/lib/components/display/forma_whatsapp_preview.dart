import 'package:flutter/material.dart';

import '../../theme/forma_theme_extension.dart';
import '../../tokens/forma_radius.dart';
import '../../tokens/forma_spacing.dart';
import '../../tokens/forma_typography.dart';

/// A WhatsApp message preview widget following Forma Design System specs.
///
/// Shows a mock WhatsApp conversation with a green header and a
/// single message bubble.
class FormaWhatsAppPreview extends StatelessWidget {
  /// Creates a [FormaWhatsAppPreview].
  const FormaWhatsAppPreview({
    super.key,
    required this.message,
  });

  /// The message text to display in the bubble.
  final String message;

  static const Color _whatsAppDark = Color(0xFF128C7E);
  static const Color _bubbleBg = Color(0xFFDCF8C6);

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return Container(
      decoration: BoxDecoration(
        color: ext.cardBackground,
        borderRadius: BorderRadius.circular(FormaRadius.card),
        border: Border.all(color: ext.border, width: 0.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // WhatsApp header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FormaSpacing.md,
              vertical: FormaSpacing.md,
            ),
            color: _whatsAppDark,
            child: Text(
              'WhatsApp',
              style: FormaTypography.title16.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          // Message bubble
          Padding(
            padding: const EdgeInsets.all(FormaSpacing.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 280),
                padding: const EdgeInsets.all(FormaSpacing.md),
                decoration: BoxDecoration(
                  color: _bubbleBg,
                  borderRadius: BorderRadius.circular(FormaRadius.input),
                ),
                child: Text(
                  message,
                  style: FormaTypography.body14.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
