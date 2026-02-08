import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DrawingPoint {
  final Offset offset;
  final double pressure;
  final DateTime timestamp;

  DrawingPoint({
    required this.offset,
    required this.pressure,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class DrawingStroke {
  final String id;
  final List<DrawingPoint> points;
  final Color color;
  final double width;
  final BlendMode blendMode;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;
  final DateTime createdAt;

  DrawingStroke({
    String? id,
    required this.points,
    required this.color,
    this.width = 2.0,
    this.blendMode = BlendMode.srcOver,
    this.strokeCap = StrokeCap.round,
    this.strokeJoin = StrokeJoin.round,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  DrawingStroke copyWith({
    List<DrawingPoint>? points,
    Color? color,
    double? width,
    BlendMode? blendMode,
  }) {
    return DrawingStroke(
      id: id,
      points: points ?? this.points,
      color: color ?? this.color,
      width: width ?? this.width,
      blendMode: blendMode ?? this.blendMode,
      strokeCap: strokeCap,
      strokeJoin: strokeJoin,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points
          .map((p) => {
                'x': p.offset.dx,
                'y': p.offset.dy,
                'pressure': p.pressure,
                'timestamp': p.timestamp.toIso8601String(),
              })
          .toList(),
      'color': color.value,
      'width': width,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory DrawingStroke.fromJson(Map<String, dynamic> json) {
    return DrawingStroke(
      id: json['id'],
      points: (json['points'] as List)
          .map((p) => DrawingPoint(
                offset: Offset(p['x'], p['y']),
                pressure: p['pressure'] ?? 1.0,
                timestamp: DateTime.parse(p['timestamp'] ?? DateTime.now().toIso8601String()),
              ))
          .toList(),
      color: Color(json['color']),
      width: json['width']?.toDouble() ?? 2.0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class AdvancedDrawingService {
  final List<DrawingStroke> _strokes = [];
  final List<DrawingStroke> _undoStack = [];
  DrawingStroke? _currentStroke;

  List<DrawingStroke> get strokes => List.unmodifiable(_strokes);
  int get strokeCount => _strokes.length;

  void startStroke(Offset position, Color color, double width, {double pressure = 1.0}) {
    _currentStroke = DrawingStroke(
      points: [DrawingPoint(offset: position, pressure: pressure)],
      color: color,
      width: width,
    );
  }

  void addPoint(Offset position, {double pressure = 1.0}) {
    if (_currentStroke != null) {
      _currentStroke = _currentStroke!.copyWith(
        points: [
          ..._currentStroke!.points,
          DrawingPoint(offset: position, pressure: pressure),
        ],
      );
    }
  }

  void endStroke() {
    if (_currentStroke != null && _currentStroke!.points.isNotEmpty) {
      _strokes.add(_currentStroke!);
      _undoStack.clear();
      _currentStroke = null;
    }
  }

  void undoStroke() {
    if (_strokes.isNotEmpty) {
      _undoStack.add(_strokes.removeLast());
    }
  }

  void redoStroke() {
    if (_undoStack.isNotEmpty) {
      _strokes.add(_undoStack.removeLast());
    }
  }

  void clearAll() {
    _strokes.clear();
    _undoStack.clear();
    _currentStroke = null;
  }

  void removeStroke(String strokeId) {
    _strokes.removeWhere((s) => s.id == strokeId);
  }

  DrawingStroke? getStroke(String strokeId) {
    try {
      return _strokes.firstWhere((s) => s.id == strokeId);
    } catch (e) {
      return null;
    }
  }

  List<DrawingStroke> getStrokesInArea(Rect area) {
    return _strokes.where((stroke) {
      return stroke.points.any((point) => area.contains(point.offset));
    }).toList();
  }

  void smoothStroke(String strokeId) {
    final strokeIndex = _strokes.indexWhere((s) => s.id == strokeId);
    if (strokeIndex < 0) return;

    final stroke = _strokes[strokeIndex];
    if (stroke.points.length < 3) return;

    final smoothedPoints = <DrawingPoint>[];
    for (int i = 0; i < stroke.points.length; i++) {
      if (i == 0 || i == stroke.points.length - 1) {
        smoothedPoints.add(stroke.points[i]);
      } else {
        final prev = stroke.points[i - 1];
        final curr = stroke.points[i];
        final next = stroke.points[i + 1];

        final smoothedOffset = Offset(
          (prev.offset.dx + curr.offset.dx + next.offset.dx) / 3,
          (prev.offset.dy + curr.offset.dy + next.offset.dy) / 3,
        );

        smoothedPoints.add(DrawingPoint(
          offset: smoothedOffset,
          pressure: (prev.pressure + curr.pressure + next.pressure) / 3,
        ));
      }
    }

    _strokes[strokeIndex] = stroke.copyWith(points: smoothedPoints);
  }

  void changeStrokeColor(String strokeId, Color newColor) {
    final strokeIndex = _strokes.indexWhere((s) => s.id == strokeId);
    if (strokeIndex >= 0) {
      _strokes[strokeIndex] = _strokes[strokeIndex].copyWith(color: newColor);
    }
  }

  void changeStrokeWidth(String strokeId, double newWidth) {
    final strokeIndex = _strokes.indexWhere((s) => s.id == strokeId);
    if (strokeIndex >= 0) {
      _strokes[strokeIndex] = _strokes[strokeIndex].copyWith(width: newWidth);
    }
  }

  List<Map<String, dynamic>> exportAsJson() {
    return _strokes.map((s) => s.toJson()).toList();
  }

  void importFromJson(List<Map<String, dynamic>> data) {
    _strokes.clear();
    for (final item in data) {
      _strokes.add(DrawingStroke.fromJson(item));
    }
  }
}
