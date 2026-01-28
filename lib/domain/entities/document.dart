import 'package:equatable/equatable.dart';

class Document extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String filePath;
  final int pageCount;
  final Map<String, dynamic> metadata;

  const Document({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.modifiedAt,
    required this.filePath,
    this.pageCount = 1,
    this.metadata = const {},
  });

  Document copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? filePath,
    int? pageCount,
    Map<String, dynamic>? metadata,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      filePath: filePath ?? this.filePath,
      pageCount: pageCount ?? this.pageCount,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    createdAt,
    modifiedAt,
    filePath,
    pageCount,
    metadata,
  ];
}
