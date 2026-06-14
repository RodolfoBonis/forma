import 'package:flutter/material.dart';

import '../controls/controls_panel.dart';
import '../docs/docs_view.dart';
import '../knobs/knobs_controller.dart';
import '../model/component_docs.dart';

/// Right-hand inspector with two tabs: live "Controls" and "Docs".
class RightPanel extends StatelessWidget {
  /// Creates the inspector for [controller] and [docs].
  const RightPanel({required this.controller, required this.docs, super.key});

  /// The knob controller backing the Controls tab.
  final KnobsController controller;

  /// The component docs backing the Docs tab.
  final ComponentDocs? docs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            const SafeArea(
              bottom: false,
              left: false,
              child: TabBar(
                tabs: [
                  Tab(text: 'Controls'),
                  Tab(text: 'Docs'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ControlsPanel(controller: controller),
                  DocsView(docs: docs),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
