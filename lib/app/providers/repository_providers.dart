import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/document_repository.dart';
import '../../data/services/local_storage_service.dart';

// Local Storage Service Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// Document Repository Provider
final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final storageService = ref.watch(localStorageServiceProvider);
  return DocumentRepository(storageService);
});
