import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/providers/app_providers.dart';

class ModeSettingsPanel extends StatelessWidget {
  final EditorMode mode;

  const ModeSettingsPanel({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Icon(
              Icons.settings,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            _buildModeSettings(context, loc),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSettings(BuildContext context, AppLocalizations loc) {
    switch (mode) {
      case EditorMode.article:
        return _buildArticleSettings(context, loc);
      case EditorMode.spreadsheet:
        return _buildSpreadsheetSettings(context, loc);
      case EditorMode.drawing:
        return _buildDrawingSettings(context, loc);
      case EditorMode.calculator:
        return _buildCalculatorSettings(context, loc);
      case EditorMode.symbols:
        return _buildSymbolsSettings(context, loc);
      case EditorMode.latex:
        return _buildLatexSettings(context, loc);
    }
  }

  Widget _buildArticleSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.columns, Icons.view_column),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.margins, Icons.crop_square),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.spacing, Icons.space_bar),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.font, Icons.text_fields),
      ],
    );
  }

  Widget _buildSpreadsheetSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.rows, Icons.grid_on),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.columns, Icons.grid_on),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.theme, Icons.palette),
      ],
    );
  }

  Widget _buildDrawingSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.strokeWidth, Icons.line_weight),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.strokeColor, Icons.color_lens),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.snapToGrid, Icons.grid_on),
      ],
    );
  }

  Widget _buildCalculatorSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.precision, Icons.precision_manufacturing),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.degrees, Icons.rotate_right),
      ],
    );
  }

  Widget _buildSymbolsSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.symbolSize, Icons.text_fields),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.symbolColor, Icons.color_lens),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.favorites, Icons.favorite),
      ],
    );
  }

  Widget _buildLatexSettings(BuildContext context, AppLocalizations loc) {
    return Row(
      children: [
        _buildSettingButton(context, loc.previewFont, Icons.text_fields),
        const SizedBox(width: 12),
        _buildSettingButton(context, loc.packages, Icons.extension),
      ],
    );
  }

  Widget _buildSettingButton(
    BuildContext context,
    String label,
    IconData icon,
  ) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // TODO: Open settings dialog
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
