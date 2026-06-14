import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Visual variant for [FormaAppHeader].
enum FormaHeaderVariant {
  /// Shows a back button as the leading widget.
  withBack,

  /// Title only, no leading widget.
  titleOnly,

  /// Custom leading widget provided via the [FormaAppHeader.leading] param.
  custom,
}

/// An application header bar following Forma Design System specs.
///
/// Supports a back-button variant, title-only, or a fully custom leading widget.
class FormaAppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a [FormaAppHeader].
  const FormaAppHeader({
    super.key,
    required this.title,
    this.variant = FormaHeaderVariant.withBack,
    this.onBack,
    this.leading,
    this.trailing,
  });

  /// The title displayed centered in the header.
  final String? title;

  /// The visual variant of the header.
  final FormaHeaderVariant variant;

  /// Called when the back button is tapped. Only used when
  /// [variant] is [FormaHeaderVariant.withBack].
  final VoidCallback? onBack;

  /// Custom leading widget. Only used when
  /// [variant] is [FormaHeaderVariant.custom].
  final Widget? leading;

  /// Optional trailing widget displayed on the right side.
  final Widget? trailing;

  static const double _kHeaderHeight = 62;

  @override
  Size get preferredSize => const Size.fromHeight(_kHeaderHeight);

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: _kHeaderHeight + topPadding,
      padding: EdgeInsets.only(top: topPadding),
      decoration: BoxDecoration(
        color: ext.cardBackground,
        border: Border(bottom: BorderSide(color: ext.border, width: 0.5)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Leading
          if (variant == FormaHeaderVariant.withBack)
            Positioned(
              left: 4,
              child: Semantics(
                label: 'Back',
                button: true,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: ext.textPrimary),
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
          if (variant == FormaHeaderVariant.custom && leading != null)
            Positioned(left: 4, child: leading!),

          // Title
          if (title != null)
            Center(
              child: Text(
                title!,
                style: FormaTypography.title18.copyWith(color: ext.textPrimary),
              ),
            ),

          // Trailing
          if (trailing != null) Positioned(right: 4, child: trailing!),
        ],
      ),
    );
  }
}
