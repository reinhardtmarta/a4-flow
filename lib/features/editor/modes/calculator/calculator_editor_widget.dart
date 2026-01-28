import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../../../../app/localization/app_localizations.dart';

class CalculatorEditorWidget extends StatefulWidget {
  final String documentId;

  const CalculatorEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<CalculatorEditorWidget> createState() =>
      _CalculatorEditorWidgetState();
}

class _CalculatorEditorWidgetState extends State<CalculatorEditorWidget> {
  String _display = '0';
  String _expression = '';
  List<String> _history = [];
  bool _isDegrees = true;

  void _appendNumber(String number) {
    setState(() {
      if (_display == '0') {
        _display = number;
      } else {
        _display += number;
      }
    });
  }

  void _appendOperator(String operator) {
    setState(() {
      _expression = _display + operator;
      _display = '0';
    });
  }

  void _calculate() {
    try {
      final parser = Parser();
      final expr = parser.parse(_expression + _display);
      final result = expr.evaluate(EvaluationType.REAL, ContextModel());
      setState(() {
        _history.add('$_expression$_display = $result');
        _display = result.toString();
        _expression = '';
      });
    } catch (e) {
      setState(() {
        _display = 'Erro';
      });
    }
  }

  void _clear() {
    setState(() {
      _display = '0';
      _expression = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _display,
                textAlign: TextAlign.right,
                style: theme.textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),

            // Mode toggle
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: true,
                        label: Text(loc.degrees),
                      ),
                      ButtonSegment(
                        value: false,
                        label: Text(loc.radians),
                      ),
                    ],
                    selected: {_isDegrees},
                    onSelectionChanged: (selected) {
                      setState(() {
                        _isDegrees = selected.first;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Calculator buttons
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              children: [
                _buildCalcButton('7', () => _appendNumber('7')),
                _buildCalcButton('8', () => _appendNumber('8')),
                _buildCalcButton('9', () => _appendNumber('9')),
                _buildCalcButton('÷', () => _appendOperator('/')),
                _buildCalcButton('4', () => _appendNumber('4')),
                _buildCalcButton('5', () => _appendNumber('5')),
                _buildCalcButton('6', () => _appendNumber('6')),
                _buildCalcButton('×', () => _appendOperator('*')),
                _buildCalcButton('1', () => _appendNumber('1')),
                _buildCalcButton('2', () => _appendNumber('2')),
                _buildCalcButton('3', () => _appendNumber('3')),
                _buildCalcButton('-', () => _appendOperator('-')),
                _buildCalcButton('0', () => _appendNumber('0')),
                _buildCalcButton('.', () => _appendNumber('.')),
                _buildCalcButton('=', _calculate, isOperator: true),
                _buildCalcButton('C', _clear, isOperator: true),
              ],
            ),
            const SizedBox(height: 16),

            // Scientific functions
            Wrap(
              spacing: 8,
              children: [
                _buildFunctionButton('sin', () => _appendNumber('sin(')),
                _buildFunctionButton('cos', () => _appendNumber('cos(')),
                _buildFunctionButton('tan', () => _appendNumber('tan(')),
                _buildFunctionButton('√', () => _appendNumber('sqrt(')),
                _buildFunctionButton('π', () => _appendNumber('3.14159')),
                _buildFunctionButton('e', () => _appendNumber('2.71828')),
              ],
            ),
            const SizedBox(height: 16),

            // History
            if (_history.isNotEmpty) ...[
              Text(
                loc.history,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                constraints: const BoxConstraints(maxHeight: 150),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _history[index],
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCalcButton(
    String label,
    VoidCallback onPressed, {
    bool isOperator = false,
  }) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOperator
            ? theme.colorScheme.primary
            : theme.colorScheme.surface,
        foregroundColor: isOperator
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSurface,
      ),
      child: Text(label),
    );
  }

  Widget _buildFunctionButton(String label, VoidCallback onPressed) {
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
