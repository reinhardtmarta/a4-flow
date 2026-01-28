import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/config/app_config.dart';
import '../../../app/providers/document_providers.dart';
import '../../../domain/entities/document.dart';
import '../widgets/recent_documents_widget.dart';
import '../widgets/new_document_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final termsAccepted = AppConfig.getTermsAccepted();
    final adWarningShown = AppConfig.getAdWarningShown();

    if (!termsAccepted) {
      if (mounted) {
        _showTermsDialog();
      }
    } else if (!adWarningShown) {
      if (mounted) {
        _showAdWarningDialog();
      }
    }
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final loc = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(loc.termsOfService),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.allLocalStorage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  loc.noCloudSync,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  loc.noDataCollection,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  loc.appDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(loc.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                await AppConfig.setTermsAccepted(true);
                if (mounted) {
                  Navigator.pop(context);
                  _showAdWarningDialog();
                }
              },
              child: Text(loc.confirm),
            ),
          ],
        );
      },
    );
  }

  void _showAdWarningDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final loc = AppLocalizations.of(context);
        return AlertDialog(
          title: Text(loc.adWarning),
          content: Text(
            loc.adSupportedApp,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await AppConfig.setAdWarningShown(true);
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text(loc.confirm),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appName),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed('settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // New Document Card
              NewDocumentCard(
                onNewDocument: () {
                  final docId = DateTime.now().millisecondsSinceEpoch.toString();
                  context.pushNamed('editor', pathParameters: {'documentId': docId});
                },
                onOpenDocument: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(loc.loading)),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Recent Documents
              Text(
                loc.recentDocuments,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const RecentDocumentsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
