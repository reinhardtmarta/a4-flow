import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

enum DrawingTool {
  pen,
  line,
  rectangle,
  circle,
  triangle,
  eraser,
  text,
}

class DrawingEditorWidget extends StatefulWidget {
  final String documentId;

  const DrawingEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<DrawingEditorWidget> createState() =>
      _DrawingEditorWidgetState();
}

class _DrawingEditorWidgetState extends State<DrawingEditorWidget> {
  DrawingTool _selectedTool = DrawingTool.pen;
  Color _selectedColor = Colors.black;
  double _strokeWidth = 2.0;
  bool _snapToGrid = false;
  int _currentLayer = 1;
  List<String> _layers = ['Layer 1', 'Layer 2', 'Layer 3'];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tool selector
            Text(
              loc.tools,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _buildToolButton(
                  loc.pen,
                  Icons.edit,
                  DrawingTool.pen,
                ),
                _buildToolButton(
                  loc.line,
                  Icons.remove,
                  DrawingTool.line,
                ),
                _buildToolButton(
                  loc.rectangle,
                  Icons.rectangle_outlined,
                  DrawingTool.rectangle,
                ),
                _buildToolButton(
                  loc.circle,
                  Icons.circle_outlined,
                  DrawingTool.circle,
                ),
                _buildToolButton(
                  loc.triangle,
                  Icons.change_history,
                  DrawingTool.triangle,
                ),
                _buildToolButton(
                  loc.eraser,
                  Icons.cleaning_services,
                  DrawingTool.eraser,
                ),
                _buildToolButton(
                  loc.text,
                  Icons.text_fields,
                  DrawingTool.text,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Stroke width slider
            Text(
              loc.strokeWidth,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _strokeWidth,
                    min: 1.0,
                    max: 20.0,
                    onChanged: (value) {
                      setState(() => _strokeWidth = value);
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Text('${_strokeWidth.toStringAsFixed(1)}'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Color picker
            Text(
              loc.strokeColor,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showColorPicker(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        border: Border.all(color: theme.colorScheme.outline),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(loc.selectColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Grid snap toggle
            CheckboxListTile(
              title: Text(loc.snapToGrid),
              value: _snapToGrid,
              onChanged: (value) {
                setState(() => _snapToGrid = value ?? false);
              },
            ),
            const SizedBox(height: 16),

            // Layers
            Text(
              loc.layers,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: List.generate(
                  _layers.length,
                  (index) {
                    final isSelected = _currentLayer == index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _currentLayer = index + 1);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                          border: Border(
                            bottom: BorderSide(
                              color: theme.colorScheme.outline,
                              width: index < _layers.length - 1 ? 1 : 0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.layers,
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _layers[index],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : null,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: theme.colorScheme.primary,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Canvas preview
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  loc.drawingMode,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolButton(
    String label,
    IconData icon,
    DrawingTool tool,
  ) {
    final isSelected = _selectedTool == tool;
    final theme = Theme.of(context);

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedTool = tool);
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.outline,
        width: isSelected ? 2 : 1,
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecionar Cor'),
          content: GridView.count(
            crossAxisCount: 5,
            children: [
              Colors.black,
              Colors.white,
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.orange,
              Colors.purple,
              Colors.pink,
              Colors.cyan,
              Colors.grey,
              Colors.amber,
              Colors.indigo,
              Colors.lime,
              Colors.teal,
            ]
                .map((color) => GestureDetector(
                      onTap: () {
                        setState(() => _selectedColor = color);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
