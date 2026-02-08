import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final undoRedoService = ref.read(undoRedoServiceProvider);
      final isCtrlPressed = HardwareKeyboard.instance.isControlPressed;
      final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

      if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyZ) {
        if (isShiftPressed) {
          undoRedoService.redo();
        } else {
          undoRedoService.undo();
        }
        setState(() {});
      } else if (isCtrlPressed && event.logicalKey == LogicalKeyboardKey.keyY) {
        undoRedoService.redo();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final currentMode = ref.watch(currentEditorModeProvider);
    final undoRedoService = ref.watch(undoRedoServiceProvider);

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(loc.appName),
            actions: [
              Tooltip(
                message: '${loc.undo} (Ctrl+Z)',
                child: IconButton(
                  icon: const Icon(Icons.undo),
                  onPressed: undoRedoService.canUndo
                      ? () {
                          undoRedoService.undo();
                          setState(() {});
                        }
                      : null,
                  tooltip: loc.undo,
                ),
              ),
              Tooltip(
                message: '${loc.redo} (Ctrl+Y)',
                child: IconButton(
                  icon: const Icon(Icons.redo),
                  onPressed: undoRedoService.canRedo
                      ? () {
                          undoRedoService.redo();
                          setState(() {});
                        }
                      : null,
                  tooltip: loc.redo,
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(loc.save),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.save)),
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: Text(loc.export),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.export)),
                      );
                    },
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    child: Text(loc.settings),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.settings)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              ModeSettingsPanel(mode: currentMode),
              Expanded(
                child: CanvasWidget(documentId: widget.documentId),
              ),
              ModeToolbar(
                currentMode: currentMode,
                onModeChanged: (mode) {
                  ref.read(currentEditorModeProvider.notifier).state = mode;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
