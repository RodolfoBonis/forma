import 'package:flutter/material.dart';

import '../model/device_model.dart';

/// Renders [child] inside a simple device bezel sized to [device].
///
/// Intentionally lightweight (a rounded, bordered container) — no external
/// device-frame package. The size shown is the device's logical size; the
/// preview's [MediaQuery] carries the matching pixel ratio and safe area.
class DeviceFrame extends StatelessWidget {
  /// Creates a frame for [device] wrapping [child].
  const DeviceFrame({required this.device, required this.child, super.key});

  /// The device whose logical size constrains the frame.
  final DeviceModel device;

  /// The preview content (already themed and MediaQuery-scoped).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1C20),
            borderRadius: BorderRadius.circular(36),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: device.logicalSize.width,
              height: device.logicalSize.height,
              child: child,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${device.name} · '
          '${device.logicalSize.width.toInt()}×${device.logicalSize.height.toInt()}',
          style: const TextStyle(fontSize: 11, color: Color(0xFF8A8F98)),
        ),
      ],
    );
  }
}
