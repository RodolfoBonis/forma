import 'package:flutter/material.dart';

import '../model/device_model.dart';
import '../state/gallery_state.dart';

/// Top toolbar over the preview: theme switcher, device viewport, text scale.
class PreviewToolbar extends StatelessWidget {
  /// Creates the toolbar.
  const PreviewToolbar({this.onMenu, super.key});

  /// Optional menu callback (shown on narrow layouts to open the nav drawer).
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    final state = GalleryScope.of(context);

    return Material(
      color: const Color(0xFF1A1C20),
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              if (onMenu != null)
                IconButton(
                  onPressed: onMenu,
                  icon: const Icon(Icons.menu, color: Colors.white70),
                  tooltip: 'Menu',
                ),
              _Label(state.component?.name ?? 'Forma Gallery'),
              const Spacer(),
              _ThemeDropdown(state: state),
              const SizedBox(width: 12),
              _DeviceDropdown(state: state),
              const SizedBox(width: 12),
              _TextScaleControl(state: state),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _ThemeDropdown extends StatelessWidget {
  const _ThemeDropdown({required this.state});

  final GalleryState state;

  @override
  Widget build(BuildContext context) {
    return _ToolbarBox(
      icon: Icons.palette_outlined,
      child: DropdownButton<int>(
        value: state.themeIndex,
        underline: const SizedBox.shrink(),
        dropdownColor: const Color(0xFF26282E),
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
        isDense: true,
        items: [
          for (var i = 0; i < state.themes.length; i++)
            DropdownMenuItem(value: i, child: Text(state.themes[i].name)),
        ],
        onChanged: (i) => i == null ? null : state.setThemeIndex(i),
      ),
    );
  }
}

class _DeviceDropdown extends StatelessWidget {
  const _DeviceDropdown({required this.state});

  final GalleryState state;

  @override
  Widget build(BuildContext context) {
    return _ToolbarBox(
      icon: Icons.devices_outlined,
      child: DropdownButton<DeviceModel?>(
        value: state.device,
        underline: const SizedBox.shrink(),
        dropdownColor: const Color(0xFF26282E),
        style: const TextStyle(color: Colors.white, fontSize: 12.5),
        isDense: true,
        items: [
          const DropdownMenuItem<DeviceModel?>(child: Text('Fit')),
          for (final device in kGalleryDevices)
            DropdownMenuItem<DeviceModel?>(
              value: device,
              child: Text(device.name),
            ),
        ],
        onChanged: state.setDevice,
      ),
    );
  }
}

class _TextScaleControl extends StatelessWidget {
  const _TextScaleControl({required this.state});

  final GalleryState state;

  @override
  Widget build(BuildContext context) {
    return _ToolbarBox(
      icon: Icons.format_size,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 110,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
              ),
              child: Slider(
                value: state.textScale,
                min: 1,
                max: 2,
                divisions: 5,
                onChanged: state.setTextScale,
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: Text(
              '${state.textScale.toStringAsFixed(1)}×',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolbarBox extends StatelessWidget {
  const _ToolbarBox({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF26282E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 6),
          child,
        ],
      ),
    );
  }
}
