import 'package:flutter/widgets.dart';

/// A device preset that constrains the preview canvas to a logical size,
/// pixel ratio, and safe-area padding — the gallery's "viewport" addon.
class DeviceModel {
  /// Creates a device preset.
  const DeviceModel({
    required this.name,
    required this.logicalSize,
    required this.devicePixelRatio,
    this.safeArea = EdgeInsets.zero,
  });

  /// Display name in the device dropdown.
  final String name;

  /// Logical (dp) screen size the preview is constrained to.
  final Size logicalSize;

  /// Device pixel ratio reported to the preview's [MediaQuery].
  final double devicePixelRatio;

  /// Safe-area padding (notch / home indicator) reported to the preview.
  final EdgeInsets safeArea;
}

/// Built-in device presets, replicating the previous Widgetbook viewports.
/// A `null` selection means "fit" (no frame, fills the canvas).
const List<DeviceModel> kGalleryDevices = [
  DeviceModel(
    name: 'iPhone 13',
    logicalSize: Size(390, 844),
    devicePixelRatio: 3,
    safeArea: EdgeInsets.only(top: 47, bottom: 34),
  ),
  DeviceModel(
    name: 'iPad Pro 11"',
    logicalSize: Size(834, 1194),
    devicePixelRatio: 2,
    safeArea: EdgeInsets.only(top: 24, bottom: 20),
  ),
  DeviceModel(
    name: 'Galaxy S20',
    logicalSize: Size(360, 800),
    devicePixelRatio: 4,
    safeArea: EdgeInsets.only(top: 24, bottom: 16),
  ),
];
