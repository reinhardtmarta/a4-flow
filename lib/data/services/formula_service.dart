import 'package:math_expressions/math_expressions.dart';

class FormulaService {
  static const List<String> supportedFunctions = [
    'SUM', 'AVG', 'AVERAGE', 'COUNT', 'MIN', 'MAX',
    'SQRT', 'ABS', 'SIN', 'COS', 'TAN', 'LOG', 'LN',
    'EXP', 'POW', 'CEIL', 'FLOOR', 'ROUND', 'STDEV', 'VAR'
  ];

  static double? evaluateFormula(String formula, Map<String, double> variables) {
    try {
      final processed = _preprocessFormula(formula);
      final parser = Parser();
      final expr = parser.parse(processed);

      final evaluator = ContextModel();
      for (final entry in variables.entries) {
        evaluator.bindVariable(Variable(entry.key), Number(entry.value));
      }

      final result = expr.evaluate(EvaluationType.REAL, evaluator);
      return (result as Number).value;
    } catch (e) {
      return null;
    }
  }

  static double? evaluateRangeFormula(
    String formula,
    List<List<String>> grid,
    String rangeNotation,
  ) {
    try {
      final values = _parseRange(grid, rangeNotation);
      if (values.isEmpty) return null;

      switch (formula.toUpperCase()) {
        case 'SUM':
          return values.reduce((a, b) => a + b);
        case 'AVG':
        case 'AVERAGE':
          return values.reduce((a, b) => a + b) / values.length;
        case 'COUNT':
          return values.length.toDouble();
        case 'MIN':
          return values.reduce((a, b) => a < b ? a : b);
        case 'MAX':
          return values.reduce((a, b) => a > b ? a : b);
        case 'STDEV':
          return _calculateStandardDeviation(values);
        case 'VAR':
          return _calculateVariance(values);
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static String _preprocessFormula(String formula) {
    String processed = formula.toLowerCase();
    processed = processed.replaceAll('×', '*');
    processed = processed.replaceAll('÷', '/');
    processed = processed.replaceAll('^', '**');
    return processed;
  }

  static List<double> _parseRange(List<List<String>> grid, String range) {
    final values = <double>[];
    final parts = range.split(':');

    if (parts.length == 2) {
      final startCell = _parseCell(parts[0]);
      final endCell = _parseCell(parts[1]);

      if (startCell != null && endCell != null) {
        for (int row = startCell['row']!; row <= endCell['row']!; row++) {
          for (int col = startCell['col']!; col <= endCell['col']!; col++) {
            if (row < grid.length && col < grid[row].length) {
              final value = double.tryParse(grid[row][col]);
              if (value != null) {
                values.add(value);
              }
            }
          }
        }
      }
    }

    return values;
  }

  static Map<String, int>? _parseCell(String cellRef) {
    cellRef = cellRef.trim().toUpperCase();

    int col = 0;
    int row = 0;
    int i = 0;

    while (i < cellRef.length && cellRef[i].compareTo('A') >= 0 && cellRef[i].compareTo('Z') <= 0) {
      col = col * 26 + (cellRef[i].codeUnitAt(0) - 'A'.codeUnitAt(0) + 1);
      i++;
    }

    if (i < cellRef.length) {
      row = int.tryParse(cellRef.substring(i)) ?? 0;
      if (row > 0) {
        return {'row': row - 1, 'col': col - 1};
      }
    }

    return null;
  }

  static double _calculateStandardDeviation(List<double> values) {
    if (values.length < 2) return 0;
    final variance = _calculateVariance(values);
    return variance.isFinite ? variance.toDouble().sqrt() : 0;
  }

  static double _calculateVariance(List<double> values) {
    if (values.length < 2) return 0;
    final mean = values.reduce((a, b) => a + b) / values.length;
    final sumSquaredDiffs = values
        .map((x) => (x - mean) * (x - mean))
        .reduce((a, b) => a + b);
    return sumSquaredDiffs / (values.length - 1);
  }

  static bool isFormula(String text) {
    return text.startsWith('=');
  }

  static String extractFormula(String text) {
    if (isFormula(text)) {
      return text.substring(1).trim();
    }
    return text;
  }
}
