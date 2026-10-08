import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// A compact desktop top bar / application header.
///
/// Implements [PreferredSizeWidget] so it can be used as a `Scaffold.appBar`.
/// Renders an optional [leading] widget, a [title] (styled with
/// [FormaTypographyExtension.title16]) or a custom [center] widget, and a
/// trailing row of [actions]. Painted on [FormaThemeExtension.cardBackground]
/// with a 1px bottom [FormaThemeExtension.border].
class FormaTopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [FormaTopBar].
  const FormaTopBar({
    this.leading,
    this.title,
    this.center,
    this.actions = const [],
    this.height = 60,
    super.key,
  });

  /// Leading widget (e.g. a logo, menu toggle or back button).
  final Widget? leading;

  /// Title text rendered with [FormaTypographyExtension.title16]. Ignored when
  /// [center] is provided.
  final String? title;

  /// Custom centered widget (e.g. a search field). Takes precedence over
  /// [title] for the leading/start slot.
  final Widget? center;

  /// Trailing action widgets, laid out horizontally at the end.
  final List<Widget> actions;

  /// Bar height in logical pixels.
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Semantics(
      header: true,
      container: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: ext.cardBackground,
          border: Border(bottom: BorderSide(color: ext.border)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: FormaSpacing.base),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: FormaSpacing.md),
            ],
            Expanded(
              child:
                  center ??
                  (title != null
                      ? Text(
                          title!,
                          style: typo.title16.copyWith(color: ext.textPrimary),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox.shrink()),
            ),
            for (final action in actions) ...[
              const SizedBox(width: FormaSpacing.xs),
              action,
            ],
          ],
        ),
      ),
    );
  }
}
