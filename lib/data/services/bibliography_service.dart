import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'bibliography_service.g.dart';

@JsonSerializable()
class BibliographicEntry {
  final String id;
  final String type;
  final String title;
  final List<String> authors;
  final String? doi;
  final String? isbn;
  final String? url;
  final int? year;
  final String? publisher;
  final String? journal;
  final int? volume;
  final int? issue;
  final String? pages;
  final Map<String, String> customFields;
  final DateTime createdAt;

  BibliographicEntry({
    String? id,
    required this.type,
    required this.title,
    required this.authors,
    this.doi,
    this.isbn,
    this.url,
    this.year,
    this.publisher,
    this.journal,
    this.volume,
    this.issue,
    this.pages,
    this.customFields = const {},
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  factory BibliographicEntry.fromJson(Map<String, dynamic> json) =>
      _$BibliographicEntryFromJson(json);

  Map<String, dynamic> toJson() => _$BibliographicEntryToJson(this);

  String formatABNT() {
    final authorsStr = _formatAuthorsABNT(authors);
    final titleStr = title;
    final yearStr = year != null ? year.toString() : 'S.d.';

    switch (type.toUpperCase()) {
      case 'BOOK':
        return '$authorsStr. $titleStr. $publisher, $yearStr.';
      case 'JOURNAL':
        return '$authorsStr. $titleStr. $journal, v. $volume, n. $issue, p. $pages, $yearStr.';
      case 'CONFERENCE':
        return '$authorsStr. $titleStr. In: $publisher, $yearStr.';
      case 'WEBSITE':
        return '$authorsStr. $titleStr. Disponível em: <$url>. Acesso em: ${DateTime.now().day} de ${_getMonthName(DateTime.now().month)} de ${DateTime.now().year}.';
      default:
        return '$authorsStr. $titleStr. $yearStr.';
    }
  }

  String formatAPA() {
    final authorsStr = _formatAuthorsAPA(authors);
    final titleStr = title;
    final yearStr = year != null ? '($year)' : '(s.d.)';

    switch (type.toUpperCase()) {
      case 'BOOK':
        return '$authorsStr $yearStr. $titleStr. $publisher.';
      case 'JOURNAL':
        return '$authorsStr $yearStr. $titleStr. $journal, $volume($issue), $pages.';
      case 'CONFERENCE':
        return '$authorsStr $yearStr. $titleStr. In: $publisher.';
      case 'WEBSITE':
        return '$authorsStr $yearStr. $titleStr. Retrieved from $url';
      default:
        return '$authorsStr $yearStr. $titleStr.';
    }
  }

  String formatVancouver() {
    final authorsStr = _formatAuthorsVancouver(authors);
    final titleStr = title;
    final yearStr = year ?? 0;

    switch (type.toUpperCase()) {
      case 'BOOK':
        return '$authorsStr. $titleStr. $publisher; $yearStr.';
      case 'JOURNAL':
        return '$authorsStr. $titleStr. $journal. $yearStr;$volume($issue):$pages.';
      case 'WEBSITE':
        return '$authorsStr. $titleStr. [Internet]. Available from: $url';
      default:
        return '$authorsStr. $titleStr. $yearStr.';
    }
  }

  String _formatAuthorsABNT(List<String> authors) {
    if (authors.isEmpty) return 'Autor desconhecido';
    if (authors.length == 1) return authors[0].toUpperCase();
    if (authors.length == 2) return '${authors[0]} e ${authors[1]}'.toUpperCase();
    return '${authors[0]} et al.'.toUpperCase();
  }

  String _formatAuthorsAPA(List<String> authors) {
    if (authors.isEmpty) return 'Unknown Author';
    if (authors.length == 1) return authors[0];
    if (authors.length == 2) return '${authors[0]} & ${authors[1]}';
    return '${authors[0]} et al.';
  }

  String _formatAuthorsVancouver(List<String> authors) {
    if (authors.isEmpty) return 'Unknown Author';
    if (authors.length <= 6) return authors.join(', ');
    return authors.sublist(0, 3).join(', ') + ' et al.';
  }

  String _getMonthName(int month) {
    const months = [
      'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
      'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
    ];
    return months[month - 1];
  }
}

class BibliographyService {
  final List<BibliographicEntry> _entries = [];

  void addEntry(BibliographicEntry entry) {
    _entries.add(entry);
  }

  void removeEntry(String entryId) {
    _entries.removeWhere((e) => e.id == entryId);
  }

  BibliographicEntry? getEntry(String entryId) {
    try {
      return _entries.firstWhere((e) => e.id == entryId);
    } catch (e) {
      return null;
    }
  }

  List<BibliographicEntry> getAllEntries() => List.unmodifiable(_entries);

  String generateCitation(String entryId, String format) {
    final entry = getEntry(entryId);
    if (entry == null) return '';

    switch (format.toUpperCase()) {
      case 'ABNT':
        return entry.formatABNT();
      case 'APA':
        return entry.formatAPA();
      case 'VANCOUVER':
        return entry.formatVancouver();
      default:
        return entry.formatABNT();
    }
  }

  String generateBibliography(String format) {
    if (_entries.isEmpty) return '';

    final sortedEntries = List.of(_entries);
    sortedEntries.sort((a, b) => a.title.compareTo(b.title));

    final citations = sortedEntries
        .map((entry) => generateCitation(entry.id, format))
        .toList();

    return citations.join('\n\n');
  }

  List<BibliographicEntry> search(String query) {
    final lowerQuery = query.toLowerCase();
    return _entries
        .where((e) =>
            e.title.toLowerCase().contains(lowerQuery) ||
            e.authors.any((a) => a.toLowerCase().contains(lowerQuery)) ||
            (e.doi?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  void updateEntry(String entryId, BibliographicEntry updated) {
    final index = _entries.indexWhere((e) => e.id == entryId);
    if (index >= 0) {
      _entries[index] = updated;
    }
  }
}
