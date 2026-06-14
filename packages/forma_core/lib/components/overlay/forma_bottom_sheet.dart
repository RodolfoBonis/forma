import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A draggable bottom sheet following Forma Design System specs.
///
/// Use the static [FormaBottomSheet.show] method to present it modally.
class FormaBottomSheet extends StatelessWidget {
  /// Creates a [FormaBottomSheet].
  const FormaBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.minChildSize = 0.3,
    this.maxChildSize = 0.9,
    this.isDismissible = true,
  });

  /// The sheet's body content.
  final Widget child;

  /// Optional title displayed below the drag handle.
  final String? title;

  /// Minimum fraction of screen height for the sheet.
  final double minChildSize;

  /// Maximum fraction of screen height for the sheet.
  final double maxChildSize;

  /// Whether the sheet can be dismissed by tapping outside.
  final bool isDismissible;

  /// Presents the bottom sheet modally.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    double minChildSize = 0.3,
    double maxChildSize = 0.9,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FormaBottomSheet(
        title: title,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        isDismissible: isDismissible,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;

    return DraggableScrollableSheet(
      initialChildSize: minChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: ext.cardBackground,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(FormaRadius.sheet),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Center(
                  child: Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: ext.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              // Title
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    title!,
                    style: FormaTypography.title18.copyWith(
                      color: ext.textPrimary,
                    ),
                  ),
                ),
              // Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
