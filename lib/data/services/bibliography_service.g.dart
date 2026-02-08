part of 'bibliography_service.dart';

BibliographicEntry _$BibliographicEntryFromJson(Map<String, dynamic> json) =>
    BibliographicEntry(
      id: json['id'] as String?,
      type: json['type'] as String,
      title: json['title'] as String,
      authors: List<String>.from(json['authors'] as Iterable<dynamic>),
      doi: json['doi'] as String?,
      isbn: json['isbn'] as String?,
      url: json['url'] as String?,
      year: (json['year'] as num?)?.toInt(),
      publisher: json['publisher'] as String?,
      journal: json['journal'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
      issue: (json['issue'] as num?)?.toInt(),
      pages: json['pages'] as String?,
      customFields:
          Map<String, String>.from(json['customFields'] as Map<String, dynamic>? ?? {}),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$BibliographicEntryToJson(BibliographicEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'authors': instance.authors,
      'doi': instance.doi,
      'isbn': instance.isbn,
      'url': instance.url,
      'year': instance.year,
      'publisher': instance.publisher,
      'journal': instance.journal,
      'volume': instance.volume,
      'issue': instance.issue,
      'pages': instance.pages,
      'customFields': instance.customFields,
      'createdAt': instance.createdAt.toIso8601String(),
    };
