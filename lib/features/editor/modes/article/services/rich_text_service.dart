import 'package:flutter/material.dart';
import '../models/text_style_model.dart';

class RichTextService {
  static TextSpan buildRichText(
    String text,
    TextStyleModel style,
  ) {
    return TextSpan(
      text: text,
      style: style.toFlutterTextStyle(),
    );
  }

  static List<TextSpan> buildParagraph(
    String text,
    List<({int start, int end, TextStyleModel style})> styleRanges,
  ) {
    if (styleRanges.isEmpty) {
      return [TextSpan(text: text)];
    }

    final spans = <TextSpan>[];
    int currentIndex = 0;

    // Sort ranges by start position
    final sortedRanges = [...styleRanges]
        ..sort((a, b) => a.start.compareTo(b.start));

    for (final range in sortedRanges) {
      // Add text before this range
      if (currentIndex < range.start) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, range.start),
        ));
      }

      // Add styled text
      spans.add(TextSpan(
        text: text.substring(range.start, range.end),
        style: range.style.toFlutterTextStyle(),
      ));

      currentIndex = range.end;
    }

    // Add remaining text
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
      ));
    }

    return spans;
  }

  static String stripFormatting(String text) {
    return text
        .replaceAll(RegExp(r'\*\*'), '')
        .replaceAll(RegExp(r'__'), '')
        .replaceAll(RegExp(r'~~'), '')
        .replaceAll(RegExp(r'\*'), '')
        .replaceAll(RegExp(r'_'), '');
  }

  static String applyBold(String text, bool apply) {
    if (apply) {
      return '**$text**';
    }
    return text.replaceAll(RegExp(r'\*\*'), '');
  }

  static String applyItalic(String text, bool apply) {
    if (apply) {
      return '_${text}_';
    }
    return text.replaceAll(RegExp(r'_'), '');
  }

  static String applyStrikethrough(String text, bool apply) {
    if (apply) {
      return '~~$text~~';
    }
    return text.replaceAll(RegExp(r'~~'), '');
  }

  static String applyUnderline(String text, bool apply) {
    if (apply) {
      return '__${text}__';
    }
    return text.replaceAll(RegExp(r'__'), '');
  }

  static String applySuperscript(String text) {
    return '^{$text}';
  }

  static String applySubscript(String text) {
    return '_{$text}';
  }
}
