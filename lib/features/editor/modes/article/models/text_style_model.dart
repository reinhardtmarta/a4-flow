import 'package:flutter/material.dart';

enum TextStyleType {
  title,
  abstract,
  section,
  subsection,
  paragraph,
  equation,
  figure,
  table,
  reference,
  normal,
}

enum TextAlignment {
  left,
  center,
  right,
  justify,
}

class TextStyleModel {
  final TextStyleType type;
  final bool bold;
  final bool italic;
  final bool underline;
  final bool strikethrough;
  final bool superscript;
  final bool subscript;
  final Color textColor;
  final Color backgroundColor;
  final TextAlignment alignment;
  final double fontSize;
  final String fontFamily;
  final double lineHeight;
  final double letterSpacing;

  const TextStyleModel({
    this.type = TextStyleType.normal,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.strikethrough = false,
    this.superscript = false,
    this.subscript = false,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.transparent,
    this.alignment = TextAlignment.left,
    this.fontSize = 14.0,
    this.fontFamily = 'Roboto',
    this.lineHeight = 1.5,
    this.letterSpacing = 0.0,
  });

  TextStyleModel copyWith({
    TextStyleType? type,
    bool? bold,
    bool? italic,
    bool? underline,
    bool? strikethrough,
    bool? superscript,
    bool? subscript,
    Color? textColor,
    Color? backgroundColor,
    TextAlignment? alignment,
    double? fontSize,
    String? fontFamily,
    double? lineHeight,
    double? letterSpacing,
  }) {
    return TextStyleModel(
      type: type ?? this.type,
      bold: bold ?? this.bold,
      italic: italic ?? this.italic,
      underline: underline ?? this.underline,
      strikethrough: strikethrough ?? this.strikethrough,
      superscript: superscript ?? this.superscript,
      subscript: subscript ?? this.subscript,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      alignment: alignment ?? this.alignment,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
    );
  }

  TextStyle toFlutterTextStyle() {
    return TextStyle(
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      decoration: _getDecoration(),
      color: textColor,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontFamily: fontFamily,
      height: lineHeight,
      letterSpacing: letterSpacing,
    );
  }

  TextDecoration _getDecoration() {
    final decorations = <TextDecoration>[];
    if (underline) decorations.add(TextDecoration.underline);
    if (strikethrough) decorations.add(TextDecoration.lineThrough);
    return decorations.isEmpty
        ? TextDecoration.none
        : TextDecoration.combine(decorations);
  }

  static TextStyleModel fromType(TextStyleType type) {
    switch (type) {
      case TextStyleType.title:
        return TextStyleModel(
          type: type,
          bold: true,
          fontSize: 28.0,
          alignment: TextAlignment.center,
        );
      case TextStyleType.abstract:
        return TextStyleModel(
          type: type,
          italic: true,
          fontSize: 12.0,
        );
      case TextStyleType.section:
        return TextStyleModel(
          type: type,
          bold: true,
          fontSize: 18.0,
        );
      case TextStyleType.subsection:
        return TextStyleModel(
          type: type,
          bold: true,
          fontSize: 16.0,
        );
      case TextStyleType.equation:
        return TextStyleModel(
          type: type,
          fontSize: 14.0,
          fontFamily: 'RobotoMono',
        );
      case TextStyleType.figure:
      case TextStyleType.table:
      case TextStyleType.reference:
        return TextStyleModel(
          type: type,
          fontSize: 12.0,
          italic: true,
        );
      default:
        return const TextStyleModel();
    }
  }
}
