import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../../data/services/undo_redo_service.dart';

// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final isDark = AppConfig.getDarkMode();
  return isDark ? ThemeMode.dark : ThemeMode.light;
});

// Locale provider
final localeProvider = StateProvider<Locale>((ref) {
  final languageCode = AppConfig.getLanguage();
  final parts = languageCode.split('_');
  return Locale(parts[0], parts.length > 1 ? parts[1] : null);
});

// Current editor mode provider
enum EditorMode {
  article,
  spreadsheet,
  drawing,
  calculator,
  symbols,
  latex,
}

final currentEditorModeProvider = StateProvider<EditorMode>((ref) {
  return EditorMode.article;
});

// Undo/Redo service provider
final undoRedoServiceProvider = Provider<UndoRedoService>((ref) {
  return UndoRedoService();
});

// Undo/Redo history provider
final undoRedoHistoryProvider = StateProvider<({List<dynamic> undoStack, List<dynamic> redoStack})>((ref) {
  return (undoStack: [], redoStack: []);
});

// Canvas zoom level provider
final canvasZoomProvider = StateProvider<double>((ref) {
  return 1.0;
});

// Canvas pan offset provider
final canvasPanProvider = StateProvider<Offset>((ref) {
  return Offset.zero;
});

// Current document provider
final currentDocumentProvider = StateProvider<String?>((ref) {
  return null;
});

// Selected object provider
final selectedObjectProvider = StateProvider<String?>((ref) {
  return null;
});
