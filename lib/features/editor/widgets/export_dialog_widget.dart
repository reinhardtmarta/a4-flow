import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../data/services/advanced_export_service.dart';
import '../../../domain/entities/document.dart';

class ExportDialogWidget extends StatefulWidget {
  final Document document;

  const ExportDialogWidget({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  State<ExportDialogWidget> createState() => _ExportDialogWidgetState();
}

class _ExportDialogWidgetState extends State<ExportDialogWidget> {
  final _exportService = AdvancedExportService();
  bool _isExporting = false;
  String? _selectedFormat;

  final List<Map<String, String>> _exportFormats = [
    {'format': 'PDF', 'extension': '.pdf', 'icon': '📄'},
    {'format': 'PNG', 'extension': '.png', 'icon': '🖼️'},
    {'format': 'Markdown', 'extension': '.md', 'icon': '📝'},
    {'format': 'JSON', 'extension': '.json', 'icon': '⚙️'},
    {'format': 'LaTeX', 'extension': '.tex', 'icon': '∑'},
    {'format': 'TXT', 'extension': '.txt', 'icon': '📋'},
    {'format': 'Projeto', 'extension': '.a4flow', 'icon': '📦'},
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(loc.export),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.selectExportFormat,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              children: _exportFormats.map((format) {
                final isSelected = _selectedFormat == format['format'];
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedFormat = format['format']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          format['icon']!,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          format['format']!,
                          style: theme.textTheme.labelSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isExporting ? null : () => Navigator.pop(context),
          child: Text(loc.cancel),
        ),
        ElevatedButton(
          onPressed: _isExporting || _selectedFormat == null
              ? null
              : () => _export(context, loc),
          child: _isExporting
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(loc.export),
        ),
      ],
    );
  }

  Future<void> _export(BuildContext context, AppLocalizations loc) async {
    setState(() => _isExporting = true);

    try {
      String? filePath;

      switch (_selectedFormat) {
        case 'PDF':
          filePath = await _exportService.exportToPdf(widget.document);
          break;
        case 'PNG':
          filePath = await _exportService.exportToPng(widget.document);
          break;
        case 'Markdown':
          filePath = await _exportService.exportToMarkdown(widget.document);
          break;
        case 'JSON':
          filePath = await _exportService.exportToJson(widget.document);
          break;
        case 'LaTeX':
          filePath = await _exportService.exportToLatex(widget.document);
          break;
        case 'TXT':
          filePath = await _exportService.exportToTxt(widget.document);
          break;
        case 'Projeto':
          filePath = await _exportService.exportAsProject(widget.document);
          break;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${loc.export} ${loc.successful}: $filePath'),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${loc.errorOccurred}: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}
