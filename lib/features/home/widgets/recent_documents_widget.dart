import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';

class RecentDocumentsWidget extends StatelessWidget {
  const RecentDocumentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // TODO: Fetch recent documents from local storage
    final recentDocuments = <Map<String, String>>[];

    if (recentDocuments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                size: 48,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                loc.noRecentDocuments,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentDocuments.length,
      itemBuilder: (context, index) {
        final doc = recentDocuments[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.description),
            title: Text(doc['name'] ?? loc.untitled),
            subtitle: Text(doc['date'] ?? ''),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(loc.delete),
                  onTap: () {
                    // TODO: Delete document
                  },
                ),
              ],
            ),
            onTap: () {
              // TODO: Open document
            },
          ),
        );
      },
    );
  }
}
