import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/component_docs.dart';

/// Right-panel "Docs" tab: description, an API/props table, and a copyable
/// "how to use" code snippet.
class DocsView extends StatelessWidget {
  /// Creates a docs view for [docs] (null shows an empty state).
  const DocsView({required this.docs, super.key});

  /// The component documentation, if authored.
  final ComponentDocs? docs;

  @override
  Widget build(BuildContext context) {
    final docs = this.docs;
    if (docs == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No docs yet for this component.',
            style: TextStyle(color: Color(0xFF8A8F98), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          docs.description,
          style: const TextStyle(fontSize: 13, height: 1.5),
        ),
        if (docs.props.isNotEmpty) ...[
          const SizedBox(height: 24),
          const _SectionTitle('Props'),
          const SizedBox(height: 8),
          _PropsTable(props: docs.props),
        ],
        const SizedBox(height: 24),
        const _SectionTitle('Usage'),
        const SizedBox(height: 8),
        _CodeBlock(
          code: '${docs.importPath}\n\n${docs.codeSnippet ?? '// TODO'}',
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }
}

class _PropsTable extends StatelessWidget {
  const _PropsTable({required this.props});

  final List<PropDoc> props;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x1F000000)),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < props.length; i++)
            Container(
              color: i.isEven ? const Color(0x08000000) : null,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: _PropRow(prop: props[i]),
            ),
        ],
      ),
    );
  }
}

class _PropRow extends StatelessWidget {
  const _PropRow({required this.prop});

  final PropDoc prop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                prop.name,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              prop.type,
              style: const TextStyle(fontSize: 11.5, color: Color(0xFF1565C0)),
            ),
            if (prop.required) ...[
              const SizedBox(width: 6),
              const Text(
                'required',
                style: TextStyle(fontSize: 10, color: Color(0xFFB71C1C)),
              ),
            ] else if (prop.defaultValue != null) ...[
              const SizedBox(width: 6),
              Text(
                '= ${prop.defaultValue}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A8F98)),
              ),
            ],
          ],
        ),
        if (prop.description.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            prop.description,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5A5F68)),
          ),
        ],
      ],
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C20),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: _CopyButton(code: code),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.5,
                color: Color(0xFFE6E6E6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatefulWidget {
  const _CopyButton({required this.code});

  final String code;

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) return;
    setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: _copy,
      icon: Icon(
        _copied ? Icons.check : Icons.copy,
        size: 14,
        color: const Color(0xFFB7BCC4),
      ),
      label: Text(
        _copied ? 'Copied' : 'Copy',
        style: const TextStyle(fontSize: 12, color: Color(0xFFB7BCC4)),
      ),
    );
  }
}
