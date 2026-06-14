import 'package:flutter/material.dart';

import '../knobs/knobs_controller.dart';
import '../model/use_case.dart';
import '../state/gallery_state.dart';
import 'device_frame.dart';
import 'use_case_host.dart';

/// The center canvas: renders the selected use case inside a theme-scoped,
/// viewport-scoped preview.
///
/// The preview is wrapped in its own [MaterialApp] so components that push
/// routes, show bottom sheets, or use [ScaffoldMessenger] work in isolation.
/// Theme, text scale, and device viewport apply **only** to this subtree — the
/// surrounding shell keeps its own theme and [MediaQuery].
class PreviewCanvas extends StatelessWidget {
  /// Creates the canvas for [useCase] driven by [controller].
  const PreviewCanvas({
    required this.useCase,
    required this.controller,
    super.key,
  });

  /// The selected use case.
  final UseCase useCase;

  /// The knob controller for this use case.
  final KnobsController controller;

  @override
  Widget build(BuildContext context) {
    final state = GalleryScope.of(context);
    final device = state.device;

    final app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: state.theme.data,
      home: Scaffold(
        body: UseCaseHost(useCase: useCase, controller: controller),
      ),
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(
            textScaler: TextScaler.linear(state.textScale),
            size: device?.logicalSize ?? mq.size,
            devicePixelRatio: device?.devicePixelRatio ?? mq.devicePixelRatio,
            padding: device?.safeArea ?? mq.padding,
            viewPadding: device?.safeArea ?? mq.viewPadding,
          ),
          child: child!,
        );
      },
    );

    final canvasColor = state.theme.isDark
        ? const Color(0xFF15171C)
        : const Color(0xFFF1F2F4);

    return ColoredBox(
      color: canvasColor,
      child: device == null
          ? app
          : Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: DeviceFrame(device: device, child: app),
              ),
            ),
    );
  }
}
