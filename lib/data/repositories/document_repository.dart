import '../models/document_model.dart';
import '../services/local_storage_service.dart';
import '../../domain/entities/document.dart';

class DocumentRepository {
  final LocalStorageService _storageService;

  DocumentRepository(this._storageService);

  Future<String> saveDocument(Document document) async {
    final model = DocumentModel.fromEntity(document);
    return await _storageService.saveDocument(model);
  }

  Future<Document?> getDocument(String documentId) async {
    final model = await _storageService.loadDocument(documentId);
    return model?.toEntity();
  }

  Future<List<Document>> getRecentDocuments({int limit = 10}) async {
    final models = await _storageService.listRecentDocuments(limit: limit);
    return models.map((m) => m.toEntity()).toList();
  }

  Future<void> deleteDocument(String documentId) async {
    await _storageService.deleteDocument(documentId);
  }

  Future<bool> documentExists(String documentId) async {
    return await _storageService.documentExists(documentId);
  }

  Future<void> exportDocument(String documentId, String exportPath) async {
    await _storageService.exportDocument(documentId, exportPath);
  }

  Future<String> importDocument(String sourcePath) async {
    return await _storageService.importDocument(sourcePath);
  }

  Future<int> getDocumentCount() async {
    return await _storageService.getDocumentCount();
  }

  Future<void> clearAllDocuments() async {
    await _storageService.clearAllDocuments();
  }
}
