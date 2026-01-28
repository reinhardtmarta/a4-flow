import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../../data/repositories/document_repository.dart';
import 'repository_providers.dart';

// Recent documents provider
final recentDocumentsProvider = FutureProvider<List<Document>>((ref) async {
  final repository = ref.watch(documentRepositoryProvider);
  return await repository.getRecentDocuments(limit: 10);
});

// Current document provider
final currentDocumentProvider = StateProvider<Document?>((ref) {
  return null;
});

// Document count provider
final documentCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(documentRepositoryProvider);
  return await repository.getDocumentCount();
});

// Load specific document provider
final loadDocumentProvider = FutureProvider.family<Document?, String>((ref, documentId) async {
  final repository = ref.watch(documentRepositoryProvider);
  return await repository.getDocument(documentId);
});

// Document exists provider
final documentExistsProvider = FutureProvider.family<bool, String>((ref, documentId) async {
  final repository = ref.watch(documentRepositoryProvider);
  return await repository.documentExists(documentId);
});
