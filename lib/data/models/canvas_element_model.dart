import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/canvas_element.dart';

part 'canvas_element_model.g.dart';

@JsonSerializable()
class CanvasElementModel {
  final String id;
  final String type;
  final double positionX;
  final double positionY;
  final double width;
  final double height;
  final double rotation;
  final Map<String, dynamic> properties;
  final int layerIndex;
  final bool isSelected;
  final DateTime createdAt;
  final DateTime modifiedAt;

  CanvasElementModel({
    required this.id,
    required this.type,
    required this.positionX,
    required this.positionY,
    required this.width,
    required this.height,
    this.rotation = 0.0,
    this.properties = const {},
    this.layerIndex = 0,
    this.isSelected = false,
    required this.createdAt,
    required this.modifiedAt,
  });

  factory CanvasElementModel.fromJson(Map<String, dynamic> json) =>
      _$CanvasElementModelFromJson(json);

  Map<String, dynamic> toJson() => _$CanvasElementModelToJson(this);

  factory CanvasElementModel.fromEntity(CanvasElement entity) {
    return CanvasElementModel(
      id: entity.id,
      type: entity.type.toString(),
      positionX: entity.position.dx,
      positionY: entity.position.dy,
      width: entity.size.width,
      height: entity.size.height,
      rotation: entity.rotation,
      properties: entity.properties,
      layerIndex: entity.layerIndex,
      isSelected: entity.isSelected,
      createdAt: entity.createdAt,
      modifiedAt: entity.modifiedAt,
    );
  }

  CanvasElement toEntity() {
    final typeString = type.replaceFirst('ElementType.', '');
    final elementType = ElementType.values.firstWhere(
      (e) => e.toString() == 'ElementType.$typeString',
      orElse: () => ElementType.text,
    );

    return CanvasElement(
      id: id,
      type: elementType,
      position: Offset(positionX, positionY),
      size: Size(width, height),
      rotation: rotation,
      properties: properties,
      layerIndex: layerIndex,
      isSelected: isSelected,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
    );
  }

  CanvasElementModel copyWith({
    String? id,
    String? type,
    double? positionX,
    double? positionY,
    double? width,
    double? height,
    double? rotation,
    Map<String, dynamic>? properties,
    int? layerIndex,
    bool? isSelected,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return CanvasElementModel(
      id: id ?? this.id,
      type: type ?? this.type,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      width: width ?? this.width,
      height: height ?? this.height,
      rotation: rotation ?? this.rotation,
      properties: properties ?? this.properties,
      layerIndex: layerIndex ?? this.layerIndex,
      isSelected: isSelected ?? this.isSelected,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }
}
