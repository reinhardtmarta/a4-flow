import 'package:flutter/material.dart';
import '../../../app/localization/app_localizations.dart';

class EditorToolbar extends StatelessWidget {
  const EditorToolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            _buildToolButton(
              icon: Icons.add,
              tooltip: loc.insertImage,
              onPressed: () {},
            ),
            _buildToolButton(
              icon: Icons.table_chart,
              tooltip: loc.insertTable,
              onPressed: () {},
            ),
            _buildToolButton(
              icon: Icons.bar_chart,
              tooltip: loc.insertChart,
              onPressed: () {},
            ),
            _buildToolButton(
              icon: Icons.shapes,
              tooltip: loc.insertShape,
              onPressed: () {},
            ),
            const VerticalDivider(),
            _buildToolButton(
              icon: Icons.zoom_in,
              tooltip: loc.zoomIn,
              onPressed: () {},
            ),
            _buildToolButton(
              icon: Icons.zoom_out,
              tooltip: loc.zoomOut,
              onPressed: () {},
            ),
            _buildToolButton(
              icon: Icons.fit_screen,
              tooltip: loc.fitToScreen,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        iconSize: 20,
      ),
    );
  }
}
