import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/document.dart';
import 'canvas_element_model.dart';

part 'document_model.g.dart';

@JsonSerializable()
class DocumentModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String filePath;
  final int pageCount;
  final List<CanvasElementModel> elements;
  final Map<String, dynamic> metadata;

  DocumentModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
    required this.filePath,
    this.pageCount = 1,
    this.elements = const [],
    this.metadata = const {},
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  factory DocumentModel.fromEntity(Document entity) {
    return DocumentModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      createdAt: entity.createdAt,
      modifiedAt: entity.modifiedAt,
      filePath: entity.filePath,
      pageCount: entity.pageCount,
      metadata: entity.metadata,
    );
  }

  Document toEntity() {
    return Document(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
      filePath: filePath,
      pageCount: pageCount,
      metadata: metadata,
    );
  }

  DocumentModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? filePath,
    int? pageCount,
    List<CanvasElementModel>? elements,
    Map<String, dynamic>? metadata,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      filePath: filePath ?? this.filePath,
      pageCount: pageCount ?? this.pageCount,
      elements: elements ?? this.elements,
      metadata: metadata ?? this.metadata,
    );
  }
}
