import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

class LatexEditorWidget extends StatefulWidget {
  final String documentId;

  const LatexEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<LatexEditorWidget> createState() =>
      _LatexEditorWidgetState();
}

class _LatexEditorWidgetState extends State<LatexEditorWidget> {
  late TextEditingController _codeController;
  String _previewText = '';
  bool _showPreview = true;

  final List<String> _commonPackages = [
    'amsmath',
    'amssymb',
    'geometry',
    'graphicx',
    'tikz',
    'listings',
  ];

  final List<String> _templates = [
    r'\frac{a}{b}',
    r'\sqrt{x}',
    r'\int_{a}^{b} f(x) dx',
    r'\sum_{i=1}^{n} x_i',
    r'\begin{matrix} a & b \\ c & d \end{matrix}',
  ];

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toolbar
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _previewText = _codeController.text;
                    });
                  },
                  icon: const Icon(Icons.preview),
                  label: Text(loc.render),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    _codeController.clear();
                  },
                  icon: const Icon(Icons.clear),
                  label: Text(loc.clear),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Templates
            Text(
              loc.templates,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _templates.map((template) {
                return ActionChip(
                  label: Text(template),
                  onPressed: () {
                    _codeController.text += '\n$template';
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Code editor
            TextField(
              controller: _codeController,
              maxLines: null,
              minLines: 10,
              decoration: InputDecoration(
                hintText: 'LaTeX code...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              style: const TextStyle(fontFamily: 'RobotoMono', fontSize: 12),
            ),
            const SizedBox(height: 16),

            // Packages
            Text(
              loc.packages,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _commonPackages.map((pkg) {
                return FilterChip(
                  label: Text(pkg),
                  onSelected: (selected) {
                    if (selected) {
                      _codeController.text =
                          '\\usepackage{$pkg}\n${_codeController.text}';
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Preview
            if (_showPreview && _previewText.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.surface,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.preview,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: theme.colorScheme.outline),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _previewText,
                        style: const TextStyle(fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
