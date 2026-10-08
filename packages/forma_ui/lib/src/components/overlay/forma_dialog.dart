import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:forma_foundation/forma_foundation.dart';

import '../buttons/forma_button.dart';

/// Scrim opacity (black 45%) shared by Forma overlays.
const Color _kScrim = Color(0x73000000);

/// A centered modal dialog with a header, body and footer actions.
///
/// Use [FormaDialog.show] to present it with a scale + fade transition and a
/// 45% black scrim. The header shows an optional [icon], the [title]
/// ([FormaTypographyExtension.title18]), an optional muted [description] and a
/// close button. [actions] are right-aligned in the footer with an 8px gap.
/// `Esc` dismisses the dialog (handled by the barrier / a [CallbackShortcuts]).
class FormaDialog extends StatelessWidget {
  /// Creates a [FormaDialog]. Prefer [FormaDialog.show] to present it.
  const FormaDialog({
    required this.title,
    required this.child,
    this.description,
    this.actions = const [],
    this.width = 480,
    this.icon,
    this.scrollable = true,
    super.key,
  });

  /// Header title.
  final String title;

  /// Dialog body content.
  final Widget child;

  /// Optional muted subtitle under the [title].
  final String? description;

  /// Footer actions, right-aligned.
  final List<Widget> actions;

  /// Dialog width in logical pixels.
  final double width;

  /// Optional leading header icon.
  final Widget? icon;

  /// Whether the body scrolls when it overflows.
  final bool scrollable;

  /// Presents a [FormaDialog] with a scale + fade transition.
  ///
  /// Returns the value the dialog is popped with. `Esc` and (when
  /// [barrierDismissible]) a scrim tap both dismiss it with `null`.
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    String? description,
    List<Widget> actions = const [],
    double width = 480,
    Widget? icon,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierDismissible
          ? MaterialLocalizations.of(context).modalBarrierDismissLabel
          : null,
      barrierColor: _kScrim,
      transitionDuration: FormaDurations.fade,
      pageBuilder: (context, _, _) {
        return FormaDialog(
          title: title,
          description: description,
          actions: actions,
          width: width,
          icon: icon,
          child: child,
        );
      },
      transitionBuilder: (context, animation, _, dialog) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
            child: dialog,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final shape = context.formaShape;

    final body = Padding(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.xl,
        FormaSpacing.base,
        FormaSpacing.xl,
        FormaSpacing.xl,
      ),
      child: DefaultTextStyle.merge(
        style: typo.body14.copyWith(color: ext.textMuted),
        child: child,
      ),
    );

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () =>
            Navigator.of(context).maybePop(),
      },
      child: Focus(
        autofocus: true,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width),
            child: Material(
              color: ext.resolvedSurfaceElevated,
              borderRadius: BorderRadius.all(
                Radius.circular(shape.dialogRadius),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(shape.dialogRadius),
                  ),
                  border: Border.all(color: ext.border),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 32,
                      offset: Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DialogHeader(
                      title: title,
                      description: description,
                      icon: icon,
                    ),
                    Flexible(
                      child: scrollable
                          ? SingleChildScrollView(child: body)
                          : body,
                    ),
                    if (actions.isNotEmpty) _DialogFooter(actions: actions),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  const _DialogHeader({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String? description;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.xl,
        FormaSpacing.lg,
        FormaSpacing.md,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            IconTheme.merge(
              data: IconThemeData(color: ext.primaryColor, size: 22),
              child: icon!,
            ),
            const SizedBox(width: FormaSpacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: typo.title18.copyWith(color: ext.textPrimary),
                ),
                if (description != null) ...[
                  const SizedBox(height: FormaSpacing.xs),
                  Text(
                    description!,
                    style: typo.body14.copyWith(color: ext.textMuted),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: FormaSpacing.sm),
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
    );
  }
}

class _DialogFooter extends StatelessWidget {
  const _DialogFooter({required this.actions});

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        FormaSpacing.xl,
        0,
        FormaSpacing.xl,
        FormaSpacing.xl,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (var i = 0; i < actions.length; i++) ...[
            if (i > 0) const SizedBox(width: FormaSpacing.sm),
            actions[i],
          ],
        ],
      ),
    );
  }
}

/// A convenience confirm/cancel dialog built on [FormaDialog].
///
/// [FormaConfirmDialog.show] resolves to `true` when the user confirms and
/// `false` when they cancel or dismiss (scrim tap / `Esc`). When [destructive]
/// is true the confirm button uses the danger style.
class FormaConfirmDialog {
  const FormaConfirmDialog._();

  /// Shows the confirm dialog and returns the user's choice.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool destructive = false,
  }) async {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;

    final result = await FormaDialog.show<bool>(
      context,
      title: title,
      width: 420,
      child: Text(message, style: typo.body14.copyWith(color: ext.textMuted)),
      actions: [
        Builder(
          builder: (ctx) => FormaButton.secondary(
            label: cancelLabel,
            small: true,
            onPressed: () => Navigator.of(ctx).pop(false),
          ),
        ),
        Builder(
          builder: (ctx) => FormaButton(
            label: confirmLabel,
            small: true,
            variant: destructive
                ? FormaButtonVariant.danger
                : FormaButtonVariant.primary,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ),
      ],
    );

    return result ?? false;
  }
}
