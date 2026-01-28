import '../../domain/entities/history_action.dart';

class UndoRedoService {
  static const int maxHistorySize = 50;

  final List<HistoryAction> _undoStack = [];
  final List<HistoryAction> _redoStack = [];

  List<HistoryAction> get undoStack => List.unmodifiable(_undoStack);
  List<HistoryAction> get redoStack => List.unmodifiable(_redoStack);

  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  void addAction(HistoryAction action) {
    _undoStack.add(action);
    _redoStack.clear();

    if (_undoStack.length > maxHistorySize) {
      _undoStack.removeAt(0);
    }
  }

  HistoryAction? undo() {
    if (_undoStack.isEmpty) return null;
    final action = _undoStack.removeLast();
    _redoStack.add(action);
    return action;
  }

  HistoryAction? redo() {
    if (_redoStack.isEmpty) return null;
    final action = _redoStack.removeLast();
    _undoStack.add(action);
    return action;
  }

  void clear() {
    _undoStack.clear();
    _redoStack.clear();
  }

  void clearRedo() {
    _redoStack.clear();
  }

  int get undoCount => _undoStack.length;
  int get redoCount => _redoStack.length;

  String getLastActionDescription() {
    if (_undoStack.isEmpty) return 'Nada para desfazer';
    return _undoStack.last.description;
  }

  String getNextRedoDescription() {
    if (_redoStack.isEmpty) return 'Nada para refazer';
    return _redoStack.last.description;
  }
}
