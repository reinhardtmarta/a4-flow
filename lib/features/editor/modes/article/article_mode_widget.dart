import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';
import '../../../../data/services/bibliography_service.dart';
import '../../../../data/services/academic_templates_service.dart';

class ArticleModeWidget extends StatefulWidget {
  final String documentId;

  const ArticleModeWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<ArticleModeWidget> createState() => _ArticleModeWidgetState();
}

class _ArticleModeWidgetState extends State<ArticleModeWidget> {
  late TextEditingController _textController;
  late BibliographyService _bibliographyService;
  late List<String> _templates;
  String _selectedTemplate = 'abnt';
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;
  bool _showBibliography = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _bibliographyService = BibliographyService();
    _templates = AcademicTemplatesService.getAvailableTemplates();
    _loadSampleBibliography();
  }

  void _loadSampleBibliography() {
    _bibliographyService.addEntry(
      BibliographicEntry(
        type: 'BOOK',
        title: 'Introdução ao Flutter',
        authors: ['John Doe', 'Jane Smith'],
        publisher: 'Tech Press',
        year: 2023,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _showBibliographyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gerenciar Referências'),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Add new entry
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Título da obra',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Add new entry
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // List of entries
              Expanded(
                child: ListView.builder(
                  itemCount: _bibliographyService.getAllEntries().length,
                  itemBuilder: (context, index) {
                    final entry = _bibliographyService.getAllEntries()[index];
                    return ListTile(
                      title: Text(entry.title),
                      subtitle: Text(entry.authors.join(', ')),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _bibliographyService.removeEntry(entry.id);
                          setState(() {});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showTemplateSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Formato Acadêmico'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _templates
              .map(
                (template) => ListTile(
                  title: Text(
                    AcademicTemplatesService.getTemplateName(template),
                  ),
                  onTap: () {
                    setState(() => _selectedTemplate = template);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Template selector
            Row(
              children: [
                Text('Formato: ', style: theme.textTheme.labelMedium),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _showTemplateSelector,
                  child: Text(
                    AcademicTemplatesService.getTemplateName(_selectedTemplate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Formatting toolbar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFormatButton(
                    icon: Icons.format_bold,
                    isActive: _isBold,
                    onPressed: () {
                      setState(() => _isBold = !_isBold);
                    },
                    tooltip: loc.bold,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_italic,
                    isActive: _isItalic,
                    onPressed: () {
                      setState(() => _isItalic = !_isItalic);
                    },
                    tooltip: loc.italic,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_underlined,
                    isActive: _isUnderline,
                    onPressed: () {
                      setState(() => _isUnderline = !_isUnderline);
                    },
                    tooltip: loc.underline,
                  ),
                  const VerticalDivider(),
                  _buildFormatButton(
                    icon: Icons.library_books,
                    onPressed: _showBibliographyDialog,
                    tooltip: 'Gerenciar referências',
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_left,
                    onPressed: () {},
                    tooltip: loc.alignLeft,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_center,
                    onPressed: () {},
                    tooltip: loc.alignCenter,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_right,
                    onPressed: () {},
                    tooltip: loc.alignRight,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Text editor
            TextField(
              controller: _textController,
              maxLines: null,
              minLines: 15,
              decoration: InputDecoration(
                hintText: loc.articleMode,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: TextStyle(
                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                decoration: _isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
            const SizedBox(height: 16),

            // Bibliography section
            if (_showBibliography)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Referências Bibliográficas',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _bibliographyService.generateBibliography(_selectedTemplate.toUpperCase()),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    bool isActive = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isActive
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
