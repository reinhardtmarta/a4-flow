import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/providers/app_providers.dart';

class ModeToolbar extends StatelessWidget {
  final EditorMode currentMode;
  final Function(EditorMode) onModeChanged;

  const ModeToolbar({
    Key? key,
    required this.currentMode,
    required this.onModeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildModeButton(
              context,
              icon: Icons.article,
              label: loc.articleMode,
              mode: EditorMode.article,
            ),
            _buildModeButton(
              context,
              icon: Icons.table_chart,
              label: loc.spreadsheetMode,
              mode: EditorMode.spreadsheet,
            ),
            _buildModeButton(
              context,
              icon: Icons.brush,
              label: loc.drawingMode,
              mode: EditorMode.drawing,
            ),
            _buildModeButton(
              context,
              icon: Icons.calculate,
              label: loc.calculatorMode,
              mode: EditorMode.calculator,
            ),
            _buildModeButton(
              context,
              icon: Icons.functions,
              label: loc.symbolsMode,
              mode: EditorMode.symbols,
            ),
            _buildModeButton(
              context,
              icon: Icons.code,
              label: loc.latexMode,
              mode: EditorMode.latex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required EditorMode mode,
  }) {
    final isSelected = currentMode == mode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onModeChanged(mode),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    )
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
