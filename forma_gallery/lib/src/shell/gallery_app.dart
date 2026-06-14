import 'package:flutter/material.dart';

import '../knobs/knobs_controller.dart';
import '../model/gallery_node.dart';
import '../model/gallery_theme.dart';
import '../model/use_case.dart';
import '../preview/preview_canvas.dart';
import '../state/gallery_state.dart';
import 'preview_toolbar.dart';
import 'right_panel.dart';
import 'sidebar_nav.dart';

/// Root of the gallery: hosts the shell's own [MaterialApp] (independent of the
/// preview theme) and provides [GalleryState] to the tree.
class GalleryApp extends StatefulWidget {
  /// Creates the gallery over [root] with selectable [themes].
  const GalleryApp({required this.root, required this.themes, super.key});

  /// Root navigation nodes.
  final List<GalleryNode> root;

  /// Themes selectable from the toolbar.
  final List<GalleryTheme> themes;

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  late final GalleryState _state = GalleryState(themes: widget.themes);

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forma Gallery',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F9BFF),
          brightness: Brightness.dark,
        ),
      ),
      home: GalleryScope(
        state: _state,
        child: _GalleryHome(root: widget.root),
      ),
    );
  }
}

/// The shell scaffold: owns the [KnobsController] (recreated per selection) and
/// lays out the sidebar, preview, and inspector responsively.
class _GalleryHome extends StatefulWidget {
  const _GalleryHome({required this.root});

  final List<GalleryNode> root;

  @override
  State<_GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<_GalleryHome> {
  KnobsController _controller = KnobsController();
  UseCase? _useCase;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final useCase = GalleryScope.of(context).useCase;
    if (useCase != _useCase) {
      _useCase = useCase;
      final old = _controller;
      _controller = KnobsController();
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = GalleryScope.of(context);
    final useCase = state.useCase;
    final docs = state.component?.docs;

    final preview = useCase == null
        ? const _EmptyPreview()
        : PreviewCanvas(useCase: useCase, controller: _controller);

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 1100;

        if (wide) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(width: 264, child: SidebarNav(nodes: widget.root)),
                Expanded(
                  child: Column(
                    children: [
                      const PreviewToolbar(),
                      Expanded(child: preview),
                    ],
                  ),
                ),
                SizedBox(
                  width: 340,
                  child: RightPanel(controller: _controller, docs: docs),
                ),
              ],
            ),
          );
        }

        // Narrow: sidebar in a drawer, inspector below the preview.
        return Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: SidebarNav(
              nodes: widget.root,
              onSelected: () => Navigator.of(context).maybePop(),
            ),
          ),
          body: Column(
            children: [
              PreviewToolbar(
                onMenu: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              Expanded(flex: 3, child: preview),
              const Divider(height: 1),
              Expanded(
                flex: 2,
                child: RightPanel(controller: _controller, docs: docs),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF15171C),
      child: Center(
        child: Text(
          'Select a component from the sidebar.',
          style: TextStyle(color: Color(0xFF8A8F98), fontSize: 14),
        ),
      ),
    );
  }
}
