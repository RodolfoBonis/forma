import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../model/gallery_node.dart';
import '../model/gallery_theme.dart';
import '../model/use_case.dart';

/// Holds the gallery's global selection and addon state (selected use case,
/// theme, device viewport, and text scale) and notifies the shell on change.
class GalleryState extends ChangeNotifier {
  /// Creates the state with the available [themes].
  GalleryState({required this.themes});

  /// Themes selectable from the toolbar.
  final List<GalleryTheme> themes;

  int _themeIndex = 0;
  DeviceModel? _device;
  double _textScale = 1;
  GalleryComponent? _component;
  UseCase? _useCase;

  /// Currently selected theme.
  GalleryTheme get theme => themes[_themeIndex];

  /// Index of the selected theme.
  int get themeIndex => _themeIndex;

  /// Selected device viewport, or null for "fit".
  DeviceModel? get device => _device;

  /// Text scale applied to the preview only.
  double get textScale => _textScale;

  /// Selected component, or null when nothing is selected yet.
  GalleryComponent? get component => _component;

  /// Selected use case within [component].
  UseCase? get useCase => _useCase;

  /// Selects a [useCase] of [component] and resets nothing else.
  void select(GalleryComponent component, UseCase useCase) {
    if (_component == component && _useCase == useCase) return;
    _component = component;
    _useCase = useCase;
    notifyListeners();
  }

  /// Switches the active theme by [index].
  void setThemeIndex(int index) {
    if (index == _themeIndex) return;
    _themeIndex = index;
    notifyListeners();
  }

  /// Sets the preview viewport (null = fit).
  void setDevice(DeviceModel? device) {
    if (device == _device) return;
    _device = device;
    notifyListeners();
  }

  /// Sets the preview text scale factor.
  void setTextScale(double value) {
    if (value == _textScale) return;
    _textScale = value;
    notifyListeners();
  }
}

/// Provides [GalleryState] to the widget tree and rebuilds dependents on change.
class GalleryScope extends InheritedNotifier<GalleryState> {
  /// Creates a scope exposing [state].
  const GalleryScope({
    required GalleryState state,
    required super.child,
    super.key,
  }) : super(notifier: state);

  /// The nearest [GalleryState]; subscribes the caller to changes.
  static GalleryState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<GalleryScope>();
    assert(scope != null, 'GalleryScope not found in context');
    return scope!.notifier!;
  }
}
