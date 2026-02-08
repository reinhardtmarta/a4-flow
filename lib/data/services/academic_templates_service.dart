class AcademicTemplate {
  final String name;
  final String formatStyle;
  final String titleFormat;
  final String subtitleFormat;
  final String bodyFormat;
  final String footerFormat;
  final String citationFormat;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final String fontFamily;
  final double fontSize;
  final double lineHeight;

  AcademicTemplate({
    required this.name,
    required this.formatStyle,
    required this.titleFormat,
    required this.subtitleFormat,
    required this.bodyFormat,
    required this.footerFormat,
    required this.citationFormat,
    this.marginTop = 30,
    this.marginBottom = 20,
    this.marginLeft = 30,
    this.marginRight = 30,
    this.fontFamily = 'Times New Roman',
    this.fontSize = 12,
    this.lineHeight = 1.5,
  });

  factory AcademicTemplate.abnt() {
    return AcademicTemplate(
      name: 'ABNT (NBR 14724)',
      formatStyle: 'abnt',
      titleFormat: '''
      {title}
      {subtitle}
      {author}
      {institution}
      {city}, {year}
      ''',
      subtitleFormat: '{text}',
      bodyFormat: '{text}',
      footerFormat: '{page}',
      citationFormat: 'ABNT',
      marginTop: 30,
      marginBottom: 20,
      marginLeft: 30,
      marginRight: 30,
      fontFamily: 'Times New Roman',
      fontSize: 12,
      lineHeight: 1.5,
    );
  }

  factory AcademicTemplate.apa() {
    return AcademicTemplate(
      name: 'APA (7th Edition)',
      formatStyle: 'apa',
      titleFormat: '''
      {title}
      {author}
      {institution}
      {date}
      ''',
      subtitleFormat: '{text}',
      bodyFormat: '{text}',
      footerFormat: '{author} - {page}',
      citationFormat: 'APA',
      marginTop: 25,
      marginBottom: 25,
      marginLeft: 25,
      marginRight: 25,
      fontFamily: 'Times New Roman',
      fontSize: 12,
      lineHeight: 2.0,
    );
  }

  factory AcademicTemplate.ieee() {
    return AcademicTemplate(
      name: 'IEEE',
      formatStyle: 'ieee',
      titleFormat: '''
      {title}
      {author}
      {date}
      ''',
      subtitleFormat: '{text}',
      bodyFormat: '{text}',
      footerFormat: '[{page}]',
      citationFormat: 'VANCOUVER',
      marginTop: 20,
      marginBottom: 20,
      marginLeft: 20,
      marginRight: 20,
      fontFamily: 'Times New Roman',
      fontSize: 10,
      lineHeight: 1.0,
    );
  }

  factory AcademicTemplate.mla() {
    return AcademicTemplate(
      name: 'MLA (9th Edition)',
      formatStyle: 'mla',
      titleFormat: '''
      {author}
      {institution}
      {date}

      {title}
      ''',
      subtitleFormat: '{text}',
      bodyFormat: '{text}',
      footerFormat: '{author} {page}',
      citationFormat: 'MLA',
      marginTop: 25,
      marginBottom: 25,
      marginLeft: 25,
      marginRight: 25,
      fontFamily: 'Times New Roman',
      fontSize: 12,
      lineHeight: 2.0,
    );
  }

  String renderTitle({
    required String title,
    String? subtitle,
    String? author,
    String? institution,
    String? city,
    String? year,
  }) {
    return titleFormat
        .replaceAll('{title}', title)
        .replaceAll('{subtitle}', subtitle ?? '')
        .replaceAll('{author}', author ?? '')
        .replaceAll('{institution}', institution ?? '')
        .replaceAll('{city}', city ?? '')
        .replaceAll('{year}', year ?? '');
  }

  String renderBody(String text) {
    return bodyFormat.replaceAll('{text}', text);
  }

  String renderFooter({required int pageNumber, String? author}) {
    return footerFormat
        .replaceAll('{page}', pageNumber.toString())
        .replaceAll('{author}', author ?? '');
  }
}

class AcademicTemplatesService {
  static final _templates = {
    'abnt': AcademicTemplate.abnt(),
    'apa': AcademicTemplate.apa(),
    'ieee': AcademicTemplate.ieee(),
    'mla': AcademicTemplate.mla(),
  };

  static AcademicTemplate getTemplate(String name) {
    return _templates[name.toLowerCase()] ?? AcademicTemplate.abnt();
  }

  static List<AcademicTemplate> getAllTemplates() {
    return _templates.values.toList();
  }

  static String getTemplateName(String style) {
    return _templates[style]?.name ?? 'ABNT (NBR 14724)';
  }

  static List<String> getAvailableTemplates() {
    return _templates.keys.toList();
  }

  static String formatReference(String style, String text) {
    final template = getTemplate(style);
    return template.renderBody(text);
  }

  static String createDocumentStructure(String templateStyle) {
    final template = getTemplate(templateStyle);

    return '''
# Documento Acadêmico

**Estilo:** ${template.name}
**Margem superior:** ${template.marginTop}mm
**Margem inferior:** ${template.marginBottom}mm
**Margem esquerda:** ${template.marginLeft}mm
**Margem direita:** ${template.marginRight}mm
**Espaçamento de linhas:** ${template.lineHeight}x
**Fonte:** ${template.fontFamily} ${template.fontSize}pt

## Instruções

- Digite seu título aqui
- Adicione sua introdução
- Desenvolva seus pontos principais
- Conclua com um resumo
- Adicione referências bibliográficas

''';
  }
}
