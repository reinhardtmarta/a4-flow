import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';

class NewDocumentCard extends StatelessWidget {
  final VoidCallback onNewDocument;
  final VoidCallback onOpenDocument;

  const NewDocumentCard({
    Key? key,
    required this.onNewDocument,
    required this.onOpenDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.createNewDocument,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onNewDocument,
                    icon: const Icon(Icons.add),
                    label: Text(loc.newDocument),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onOpenDocument,
                    icon: const Icon(Icons.folder_open),
                    label: Text(loc.openFromFile),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
