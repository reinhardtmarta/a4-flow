import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/providers/app_providers.dart';
import '../widgets/canvas_widget.dart';
import '../widgets/mode_toolbar.dart';
import '../widgets/editor_toolbar.dart';

class EditorScreen extends ConsumerStatefulWidget {
  final String documentId;

  const EditorScreen({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final currentMode = ref.watch(currentEditorModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              // TODO: Implement undo
            },
            tooltip: loc.undo,
          ),
          IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              // TODO: Implement redo
            },
            tooltip: loc.redo,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Show menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Main canvas area
          Expanded(
            child: CanvasWidget(documentId: widget.documentId),
          ),

          // Mode toolbar at bottom
          ModeToolbar(
            currentMode: currentMode,
            onModeChanged: (mode) {
              ref.read(currentEditorModeProvider.notifier).state = mode;
            },
          ),
        ],
      ),
    );
  }
}
