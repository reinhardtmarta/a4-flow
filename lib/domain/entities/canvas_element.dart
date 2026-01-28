import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ElementType {
  text,
  image,
  shape,
  drawing,
  table,
  chart,
  equation,
  formula,
}

class CanvasElement extends Equatable {
  final String id;
  final ElementType type;
  final Offset position;
  final Size size;
  final double rotation;
  final Map<String, dynamic> properties;
  final int layerIndex;
  final bool isSelected;
  final DateTime createdAt;
  final DateTime modifiedAt;

  const CanvasElement({
    required this.id,
    required this.type,
    required this.position,
    required this.size,
    this.rotation = 0.0,
    this.properties = const {},
    this.layerIndex = 0,
    this.isSelected = false,
    required this.createdAt,
    required this.modifiedAt,
  });

  CanvasElement copyWith({
    String? id,
    ElementType? type,
    Offset? position,
    Size? size,
    double? rotation,
    Map<String, dynamic>? properties,
    int? layerIndex,
    bool? isSelected,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return CanvasElement(
      id: id ?? this.id,
      type: type ?? this.type,
      position: position ?? this.position,
      size: size ?? this.size,
      rotation: rotation ?? this.rotation,
      properties: properties ?? this.properties,
      layerIndex: layerIndex ?? this.layerIndex,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    position,
    size,
    rotation,
    properties,
    layerIndex,
    isSelected,
    createdAt,
    modifiedAt,
  ];
}
