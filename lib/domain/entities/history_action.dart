import 'package:equatable/equatable.dart';

enum ActionType {
  create,
  delete,
  modify,
  move,
  resize,
  rotate,
  changeProperties,
  grouping,
  layerChange,
}

class HistoryAction extends Equatable {
  final String id;
  final ActionType type;
  final String description;
  final Map<String, dynamic> previousState;
  final Map<String, dynamic> newState;
  final DateTime timestamp;

  const HistoryAction({
    required this.id,
    required this.type,
    required this.description,
    required this.previousState,
    required this.newState,
    required this.timestamp,
  });

  HistoryAction copyWith({
    String? id,
    ActionType? type,
    String? description,
    Map<String, dynamic>? previousState,
    Map<String, dynamic>? newState,
    DateTime? timestamp,
  }) {
    return HistoryAction(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      previousState: previousState ?? this.previousState,
      newState: newState ?? this.newState,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    description,
    previousState,
    newState,
    timestamp,
  ];
}
