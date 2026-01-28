import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

class SymbolsModeWidget extends StatelessWidget {
  final String documentId;

  const SymbolsModeWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.functions, size: 64, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(loc.symbolsMode, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text('Coming soon...', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
