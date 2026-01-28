import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/entities/document.dart';

class ExportService {
  Future<String> exportToPdf(Document document) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  document.title,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  document.content,
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${document.id}.pdf');
      await file.writeAsBytes(await pdf.save());

      return file.path;
    } catch (e) {
      throw Exception('Erro ao exportar PDF: $e');
    }
  }

  Future<String> exportToMarkdown(Document document) async {
    try {
      final markdown = '''# ${document.title}

${document.content}

---
*Criado em: ${document.createdAt}*
*Modificado em: ${document.modifiedAt}*
''';

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${document.id}.md');
      await file.writeAsString(markdown);

      return file.path;
    } catch (e) {
      throw Exception('Erro ao exportar Markdown: $e');
    }
  }

  Future<String> exportToText(Document document) async {
    try {
      final text = '''${document.title}

${document.content}

---
Criado em: ${document.createdAt}
Modificado em: ${document.modifiedAt}
''';

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${document.id}.txt');
      await file.writeAsString(text);

      return file.path;
    } catch (e) {
      throw Exception('Erro ao exportar TXT: $e');
    }
  }

  Future<String> exportToJson(Document document) async {
    try {
      final json = '''{
  "id": "${document.id}",
  "title": "${document.title}",
  "content": "${document.content}",
  "createdAt": "${document.createdAt}",
  "modifiedAt": "${document.modifiedAt}",
  "pageCount": ${document.pageCount}
}''';

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/${document.id}.json');
      await file.writeAsString(json);

      return file.path;
    } catch (e) {
      throw Exception('Erro ao exportar JSON: $e');
    }
  }
}
