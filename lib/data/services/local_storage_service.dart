import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/document_model.dart';

class LocalStorageService {
  static const String documentsFolder = 'a4flow_documents';
  static const String projectExtension = '.a4flow';

  Future<Directory> _getDocumentsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final docsDir = Directory('${appDir.path}/$documentsFolder');
    
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    
    return docsDir;
  }

  Future<String> saveDocument(DocumentModel document) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final fileName = '${document.id}$projectExtension';
      final file = File('${docsDir.path}/$fileName');
      
      final json = jsonEncode(document.toJson());
      await file.writeAsString(json);
      
      return file.path;
    } catch (e) {
      throw Exception('Erro ao salvar documento: $e');
    }
  }

  Future<DocumentModel?> loadDocument(String documentId) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final fileName = '$documentId$projectExtension';
      final file = File('${docsDir.path}/$fileName');
      
      if (!await file.exists()) {
        return null;
      }
      
      final json = await file.readAsString();
      final data = jsonDecode(json) as Map<String, dynamic>;
      
      return DocumentModel.fromJson(data);
    } catch (e) {
      throw Exception('Erro ao carregar documento: $e');
    }
  }

  Future<List<DocumentModel>> listRecentDocuments({int limit = 10}) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final files = docsDir.listSync();
      
      final documents = <DocumentModel>[];
      
      for (final file in files) {
        if (file is File && file.path.endsWith(projectExtension)) {
          try {
            final json = await file.readAsString();
            final data = jsonDecode(json) as Map<String, dynamic>;
            documents.add(DocumentModel.fromJson(data));
          } catch (_) {
            // Skip corrupted files
          }
        }
      }
      
      // Sort by modified date (newest first)
      documents.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));
      
      return documents.take(limit).toList();
    } catch (e) {
      throw Exception('Erro ao listar documentos: $e');
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final fileName = '$documentId$projectExtension';
      final file = File('${docsDir.path}/$fileName');
      
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Erro ao deletar documento: $e');
    }
  }

  Future<bool> documentExists(String documentId) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final fileName = '$documentId$projectExtension';
      final file = File('${docsDir.path}/$fileName');
      
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  Future<void> exportDocument(String documentId, String exportPath) async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final fileName = '$documentId$projectExtension';
      final sourceFile = File('${docsDir.path}/$fileName');
      
      if (await sourceFile.exists()) {
        await sourceFile.copy(exportPath);
      } else {
        throw Exception('Documento não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao exportar documento: $e');
    }
  }

  Future<String> importDocument(String sourcePath) async {
    try {
      final sourceFile = File(sourcePath);
      
      if (!await sourceFile.exists()) {
        throw Exception('Arquivo de origem não encontrado');
      }
      
      final json = await sourceFile.readAsString();
      final data = jsonDecode(json) as Map<String, dynamic>;
      final document = DocumentModel.fromJson(data);
      
      await saveDocument(document);
      
      return document.id;
    } catch (e) {
      throw Exception('Erro ao importar documento: $e');
    }
  }

  Future<int> getDocumentCount() async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final files = docsDir.listSync();
      
      return files
          .whereType<File>()
          .where((f) => f.path.endsWith(projectExtension))
          .length;
    } catch (e) {
      return 0;
    }
  }

  Future<void> clearAllDocuments() async {
    try {
      final docsDir = await _getDocumentsDirectory();
      final files = docsDir.listSync();
      
      for (final file in files) {
        if (file is File && file.path.endsWith(projectExtension)) {
          await file.delete();
        }
      }
    } catch (e) {
      throw Exception('Erro ao limpar documentos: $e');
    }
  }
}
