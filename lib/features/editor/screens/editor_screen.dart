import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/providers/app_providers.dart';
import '../widgets/canvas_widget.dart';
import '../widgets/mode_toolbar.dart';
import '../widgets/mode_settings_panel.dart';
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

    return WillPopScope(
      onWillPop: () async {
        // TODO: Save document before leaving
        return true;
      },
      child: Scaffold(
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
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(loc.save),
                  onTap: () {
                    // TODO: Save document
                  },
                ),
                PopupMenuItem(
                  child: Text(loc.export),
                  onTap: () {
                    // TODO: Show export dialog
                  },
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  child: Text(loc.settings),
                  onTap: () {
                    // TODO: Show editor settings
                  },
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            // Mode settings panel (shows settings for current mode)
            ModeSettingsPanel(mode: currentMode),

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
      ),
    );
  }
}
