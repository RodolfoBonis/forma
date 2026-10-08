import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Scrim opacity (black 45%) shared by Forma overlays.
const Color _kScrim = Color(0x73000000);

/// A right-edge side sheet (drawer) for desktop detail / form flows.
///
/// [FormaSideSheet.show] slides a full-height panel in from the right with a
/// 45% black scrim. `Esc` and (when [barrierDismissible]) a scrim tap dismiss
/// it. Pair it with [FormaSideSheetScaffold] for a sticky header/footer layout.
class FormaSideSheet {
  const FormaSideSheet._();

  /// Presents a side sheet built by [builder] and returns its pop value.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget Function(BuildContext) builder,
    double width = 560,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible
          ? MaterialLocalizations.of(context).modalBarrierDismissLabel
          : 'Dismiss',
      barrierColor: _kScrim,
      transitionDuration: FormaDurations.fade,
      pageBuilder: (context, _, _) {
        final ext = Theme.of(context).extension<FormaThemeExtension>()!;
        return Align(
          alignment: Alignment.centerRight,
          child: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.escape): () =>
                  Navigator.of(context).maybePop(),
            },
            child: Focus(
              autofocus: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: width),
                child: SizedBox(
                  width: width,
                  height: double.infinity,
                  child: Material(
                    color: ext.cardBackground,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: ext.border)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 32,
                            offset: Offset(-8, 0),
                          ),
                        ],
                      ),
                      child: builder(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }
}

/// A sticky-header / scrolling-body layout for content inside a
/// [FormaSideSheet].
///
/// The header shows the [title] ([FormaTypographyExtension.title18]), an
/// optional muted [subtitle], trailing [headerActions] and a close button. The
/// [body] scrolls; an optional [footer] sticks to the bottom. Both header and
/// footer are separated by a 1px [FormaThemeExtension.border].
class FormaSideSheetScaffold extends StatelessWidget {
  /// Creates a [FormaSideSheetScaffold].
  const FormaSideSheetScaffold({
    required this.title,
    required this.body,
    this.subtitle,
    this.headerActions = const [],
    this.footer,
    super.key,
  });

  /// Header title.
  final String title;

  /// Scrolling body content.
  final Widget body;

  /// Optional muted subtitle under the [title].
  final String? subtitle;

  /// Trailing header action widgets, before the close button.
  final List<Widget> headerActions;

  /// Optional sticky footer (e.g. a save/cancel action row).
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ext.border)),
          ),
          padding: const EdgeInsets.fromLTRB(
            FormaSpacing.xl,
            FormaSpacing.base,
            FormaSpacing.md,
            FormaSpacing.base,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: typo.title18.copyWith(color: ext.textPrimary),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: FormaSpacing.xs),
                      Text(
                        subtitle!,
                        style: typo.body14.copyWith(color: ext.textMuted),
                      ),
                    ],
                  ],
                ),
              ),
              for (final action in headerActions) ...[
                const SizedBox(width: FormaSpacing.xs),
                action,
              ],
              const SizedBox(width: FormaSpacing.xs),
              Semantics(
                button: true,
                label: 'Fechar',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    color: ext.textMuted,
                    visualDensity: VisualDensity.compact,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(FormaSpacing.xl),
            child: body,
          ),
        ),
        if (footer != null)
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: ext.border)),
            ),
            padding: const EdgeInsets.all(FormaSpacing.base),
            child: footer,
          ),
      ],
    );
  }
}
