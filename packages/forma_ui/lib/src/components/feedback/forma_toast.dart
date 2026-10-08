import 'dart:async';

import 'package:flutter/material.dart';

import 'package:forma_foundation/forma_foundation.dart';

/// Visual variant for a [FormaToast].
enum FormaToastVariant {
  /// Neutral / informational.
  info,

  /// Positive confirmation.
  success,

  /// Non-blocking caution.
  warning,

  /// Failure / destructive outcome.
  error,
}

/// Transient, overlay-based notifications stacked at the top-right.
///
/// [FormaToast.show] inserts a toast into the root [Overlay] so it floats above
/// dialogs and routes. Toasts stack vertically with a 16px margin, slide + fade
/// in, auto-dismiss after [duration], and can be closed early. Each
/// [OverlayState] owns one host entry; the host is removed when its last toast
/// leaves, and every auto-dismiss [Timer] is cancelled on removal so tests
/// never leak timers.
class FormaToast {
  const FormaToast._();

  static final Map<OverlayState, GlobalKey<_ToastStackState>> _hostKeys = {};
  static final Map<OverlayState, OverlayEntry> _hostEntries = {};

  /// Shows a toast with [message] and optional [description]/[actionLabel].
  static void show(
    BuildContext context, {
    required String message,
    String? description,
    FormaToastVariant variant = FormaToastVariant.info,
    Duration duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    final key = _obtainHost(overlay);

    final data = _ToastData(
      message: message,
      description: description,
      variant: variant,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );

    void push() => key.currentState?.push(data);

    if (key.currentState == null) {
      // Host was just inserted this frame; wait for it to build.
      WidgetsBinding.instance.addPostFrameCallback((_) => push());
    } else {
      push();
    }
  }

  static GlobalKey<_ToastStackState> _obtainHost(OverlayState overlay) {
    final existing = _hostKeys[overlay];
    if (existing != null) return existing;

    final key = GlobalKey<_ToastStackState>();
    final entry = OverlayEntry(
      builder: (_) => _ToastStack(
        key: key,
        onEmpty: () {
          _hostEntries.remove(overlay)?.remove();
          _hostKeys.remove(overlay);
        },
      ),
    );
    _hostKeys[overlay] = key;
    _hostEntries[overlay] = entry;
    overlay.insert(entry);
    return key;
  }
}

class _ToastData {
  _ToastData({
    required this.message,
    required this.description,
    required this.variant,
    required this.duration,
    required this.actionLabel,
    required this.onAction,
  });

  final String message;
  final String? description;
  final FormaToastVariant variant;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Key key = UniqueKey();
}

class _ToastStack extends StatefulWidget {
  const _ToastStack({required this.onEmpty, super.key});

  final VoidCallback onEmpty;

  @override
  State<_ToastStack> createState() => _ToastStackState();
}

class _ToastStackState extends State<_ToastStack> {
  final List<_ToastData> _toasts = [];

  void push(_ToastData data) {
    setState(() => _toasts.add(data));
  }

  void _remove(_ToastData data) {
    if (!mounted) return;
    setState(() => _toasts.remove(data));
    if (_toasts.isEmpty) widget.onEmpty();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: FormaSpacing.base,
      right: FormaSpacing.base,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final toast in _toasts)
              Padding(
                key: toast.key,
                padding: const EdgeInsets.only(bottom: FormaSpacing.sm),
                child: _ToastCard(
                  data: toast,
                  onDismissed: () => _remove(toast),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToastCard extends StatefulWidget {
  const _ToastCard({required this.data, required this.onDismissed});

  final _ToastData data;
  final VoidCallback onDismissed;

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _curve;
  Timer? _timer;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: FormaDurations.fade,
    );
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
    _timer = Timer(widget.data.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (_dismissing) return;
    _dismissing = true;
    _timer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ext = Theme.of(context).extension<FormaThemeExtension>()!;
    final typo = context.formaTypography;
    final (icon, accent) = _resolve(ext);

    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(_curve),
        child: Semantics(
          liveRegion: true,
          container: true,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(FormaSpacing.md),
              decoration: BoxDecoration(
                color: ext.resolvedSurfaceElevated,
                borderRadius: const BorderRadius.all(
                  Radius.circular(FormaRadius.small),
                ),
                border: Border.all(color: ext.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 20, color: accent),
                  const SizedBox(width: FormaSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.data.message,
                          style: typo.body14Medium.copyWith(
                            color: ext.textPrimary,
                          ),
                        ),
                        if (widget.data.description != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.data.description!,
                            style: typo.body13.copyWith(color: ext.textMuted),
                          ),
                        ],
                        if (widget.data.actionLabel != null) ...[
                          const SizedBox(height: FormaSpacing.sm),
                          _ToastAction(
                            label: widget.data.actionLabel!,
                            color: accent,
                            onTap: () {
                              widget.data.onAction?.call();
                              _dismiss();
                            },
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
                      child: GestureDetector(
                        onTap: _dismiss,
                        child: Icon(Icons.close, size: 16, color: ext.textHint),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  (IconData, Color) _resolve(FormaThemeExtension ext) {
    return switch (widget.data.variant) {
      FormaToastVariant.info => (Icons.info_outline, ext.infoText),
      FormaToastVariant.success => (
        Icons.check_circle_outline,
        ext.successColor,
      ),
      FormaToastVariant.warning => (
        Icons.warning_amber_rounded,
        ext.warningColor,
      ),
      FormaToastVariant.error => (Icons.error_outline, ext.errorColor),
    };
  }
}

class _ToastAction extends StatelessWidget {
  const _ToastAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final typo = context.formaTypography;

    return Semantics(
      button: true,
      label: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(label, style: typo.body13Bold.copyWith(color: color)),
        ),
      ),
    );
  }
}
