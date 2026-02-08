import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';
import '../../../../data/services/advanced_drawing_service.dart';

class DrawingModeWidget extends StatefulWidget {
  final String documentId;

  const DrawingModeWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<DrawingModeWidget> createState() => _DrawingModeWidgetState();
}

class _DrawingModeWidgetState extends State<DrawingModeWidget> {
  late AdvancedDrawingService _drawingService;
  Color _currentColor = Colors.black;
  double _currentWidth = 2.0;
  bool _isDrawing = false;

  @override
  void initState() {
    super.initState();
    _drawingService = AdvancedDrawingService();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Toolbar
        Container(
          padding: const EdgeInsets.all(8),
          color: theme.colorScheme.surface,
          child: Row(
            children: [
              // Color picker
              GestureDetector(
                onTap: _showColorPicker,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _currentColor,
                    border: Border.all(color: theme.colorScheme.outline),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Brush width slider
              Expanded(
                child: Slider(
                  value: _currentWidth,
                  min: 0.5,
                  max: 20,
                  divisions: 39,
                  label: _currentWidth.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() => _currentWidth = value);
                  },
                ),
              ),
              const SizedBox(width: 8),

              // Undo button
              IconButton(
                icon: const Icon(Icons.undo),
                onPressed: _drawingService.undoStroke,
                tooltip: 'Desfazer',
              ),

              // Redo button
              IconButton(
                icon: const Icon(Icons.redo),
                onPressed: _drawingService.redoStroke,
                tooltip: 'Refazer',
              ),

              // Clear button
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _showClearConfirmation(context),
                tooltip: 'Limpar',
              ),
            ],
          ),
        ),

        // Canvas
        Expanded(
          child: GestureDetector(
            onPanStart: (details) {
              _drawingService.startStroke(
                details.localPosition,
                _currentColor,
                _currentWidth,
                pressure: details.pressure,
              );
              setState(() => _isDrawing = true);
            },
            onPanUpdate: (details) {
              _drawingService.addPoint(
                details.localPosition,
                pressure: details.pressure,
              );
              setState(() {});
            },
            onPanEnd: (details) {
              _drawingService.endStroke();
              setState(() => _isDrawing = false);
            },
            child: CustomPaint(
              painter: DrawingPainter(_drawingService.strokes),
              size: Size.infinite,
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecionar cor'),
          content: GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              Colors.black,
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.orange,
              Colors.purple,
              Colors.pink,
              Colors.cyan,
              Colors.amber,
              Colors.indigo,
              Colors.lime,
            ]
                .map((color) => GestureDetector(
                      onTap: () {
                        setState(() => _currentColor = color);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                          border: color == _currentColor
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  void _showClearConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar desenho'),
        content: const Text('Tem certeza que deseja limpar todo o desenho?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _drawingService.clearAll();
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingStroke> strokes;

  DrawingPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke.points.isEmpty) continue;

      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.width
        ..strokeCap = stroke.strokeCap
        ..strokeJoin = stroke.strokeJoin
        ..style = PaintingStyle.stroke;

      final path = Path();
      path.moveTo(stroke.points[0].offset.dx, stroke.points[0].offset.dy);

      for (int i = 1; i < stroke.points.length; i++) {
        path.lineTo(stroke.points[i].offset.dx, stroke.points[i].offset.dy);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) {
    return oldDelegate.strokes.length != strokes.length;
  }
}
