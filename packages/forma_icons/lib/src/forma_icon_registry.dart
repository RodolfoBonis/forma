import 'package:flutter/material.dart';

import 'forma_icon_data.dart';
import 'forma_icon_key.dart';

/// Resolves a [FormaIconKey] to a concrete [FormaIconData].
///
/// Ships Material defaults for every key. A brand provides overrides (typically
/// SVGs) by constructing a registry with [FormaIconRegistry.withOverrides] and
/// exposing it through a [FormaIconScope].
@immutable
class FormaIconRegistry {
  /// Creates a registry backed only by the Material defaults.
  const FormaIconRegistry() : _overrides = const {};

  /// Creates a registry where [overrides] take precedence over the defaults.
  const FormaIconRegistry.withOverrides(
    Map<FormaIconKey, FormaIconData> overrides,
  ) : _overrides = overrides;

  final Map<FormaIconKey, FormaIconData> _overrides;

  /// Material glyph used when a key has no brand override.
  static const Map<FormaIconKey, FormaIconData> defaults = {
    FormaIconKey.home: MaterialFormaIcon(Icons.home_rounded),
    FormaIconKey.calendar: MaterialFormaIcon(Icons.calendar_today_rounded),
    FormaIconKey.settings: MaterialFormaIcon(Icons.settings_rounded),
    FormaIconKey.person: MaterialFormaIcon(Icons.person_rounded),
    FormaIconKey.search: MaterialFormaIcon(Icons.search_rounded),
    FormaIconKey.notification: MaterialFormaIcon(
      Icons.notifications_none_rounded,
    ),
    FormaIconKey.confirm: MaterialFormaIcon(Icons.check_rounded),
    FormaIconKey.close: MaterialFormaIcon(Icons.close_rounded),
    FormaIconKey.back: MaterialFormaIcon(Icons.arrow_back_ios_new_rounded),
    FormaIconKey.forward: MaterialFormaIcon(Icons.arrow_forward_ios_rounded),
    FormaIconKey.chevronDown: MaterialFormaIcon(
      Icons.keyboard_arrow_down_rounded,
    ),
    FormaIconKey.chevronUp: MaterialFormaIcon(Icons.keyboard_arrow_up_rounded),
    FormaIconKey.add: MaterialFormaIcon(Icons.add_rounded),
    FormaIconKey.edit: MaterialFormaIcon(Icons.edit_rounded),
    FormaIconKey.delete: MaterialFormaIcon(Icons.delete_outline_rounded),
    FormaIconKey.more: MaterialFormaIcon(Icons.more_horiz_rounded),
    FormaIconKey.time: MaterialFormaIcon(Icons.access_time_rounded),
    FormaIconKey.visibility: MaterialFormaIcon(Icons.visibility_rounded),
    FormaIconKey.visibilityOff: MaterialFormaIcon(Icons.visibility_off_rounded),
    FormaIconKey.success: MaterialFormaIcon(Icons.check_circle_rounded),
    FormaIconKey.warning: MaterialFormaIcon(Icons.warning_amber_rounded),
    FormaIconKey.error: MaterialFormaIcon(Icons.error_outline_rounded),
    FormaIconKey.info: MaterialFormaIcon(Icons.info_outline_rounded),
  };

  /// The [FormaIconData] for [key]: a brand override when present, otherwise
  /// the Material default.
  FormaIconData resolve(FormaIconKey key) => _overrides[key] ?? defaults[key]!;
}

/// Provides a [FormaIconRegistry] to the widget subtree.
///
/// Wrap the app (or a branded subtree) so [FormaIcon] picks up brand SVG
/// overrides. Without a scope, [FormaIconScope.of] returns the Material
/// defaults.
class FormaIconScope extends InheritedWidget {
  /// Provides [registry] to [child] and its descendants.
  const FormaIconScope({
    required this.registry,
    required super.child,
    super.key,
  });

  /// The registry exposed to descendants.
  final FormaIconRegistry registry;

  /// The nearest registry, or a default Material-only registry when none.
  static FormaIconRegistry of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FormaIconScope>();
    return scope?.registry ?? const FormaIconRegistry();
  }

  @override
  bool updateShouldNotify(FormaIconScope oldWidget) =>
      registry != oldWidget.registry;
}
