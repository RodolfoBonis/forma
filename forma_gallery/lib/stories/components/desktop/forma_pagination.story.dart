import 'package:flutter/material.dart';
import 'package:forma_core/forma_core.dart';
import 'package:forma_gallery/forma_gallery.dart';

/// FormaPagination component — compact desktop pager with summary + ellipsis.
GalleryComponent formaPaginationComponent() {
  return GalleryComponent(
    'FormaPagination',
    docs: const ComponentDocs(
      description:
          'Pagination control: optional "Mostrando x–y de N" summary on the '
          'left and prev/next + numbered page buttons with ellipsis collapsing '
          'on the right. 1-based pages.',
      props: [
        PropDoc('page', 'int', required: true, description: '1-based page.'),
        PropDoc('totalPages', 'int', required: true),
        PropDoc('onPageChanged', 'ValueChanged<int>', required: true),
        PropDoc('total', 'int?', description: 'Total items (for the summary).'),
        PropDoc('pageSize', 'int?'),
      ],
      codeSnippet: '''
FormaPagination(
  page: page,
  totalPages: 12,
  total: 235,
  pageSize: 20,
  onPageChanged: (p) => load(p),
)''',
    ),
    useCases: [
      UseCase('Playground', (context, k) {
        final totalPages = k.int.slider(
          label: 'Total pages',
          initialValue: 12,
          min: 1,
          max: 30,
        );
        final withSummary = k.boolean(label: 'Summary', initialValue: true);
        return _PaginationDemo(
          totalPages: totalPages,
          withSummary: withSummary,
        );
      }),
    ],
  );
}

class _PaginationDemo extends StatefulWidget {
  const _PaginationDemo({required this.totalPages, required this.withSummary});

  final int totalPages;
  final bool withSummary;

  @override
  State<_PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<_PaginationDemo> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    final page = _page.clamp(1, widget.totalPages);
    const pageSize = 20;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: FormaPagination(
        page: page,
        totalPages: widget.totalPages,
        total: widget.withSummary ? widget.totalPages * pageSize : null,
        pageSize: widget.withSummary ? pageSize : null,
        onPageChanged: (p) => setState(() => _page = p),
      ),
    );
  }
}
