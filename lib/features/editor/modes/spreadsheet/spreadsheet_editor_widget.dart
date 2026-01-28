import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

class SpreadsheetEditorWidget extends StatefulWidget {
  final String documentId;

  const SpreadsheetEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<SpreadsheetEditorWidget> createState() =>
      _SpreadsheetEditorWidgetState();
}

class _SpreadsheetEditorWidgetState extends State<SpreadsheetEditorWidget> {
  late List<List<String>> _cells;
  int _rows = 10;
  int _columns = 5;
  int? _selectedRow;
  int? _selectedColumn;

  @override
  void initState() {
    super.initState();
    _initializeCells();
  }

  void _initializeCells() {
    _cells = List.generate(
      _rows,
      (row) => List.generate(_columns, (col) => ''),
    );
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
            // Controls
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _rows++;
                      _cells.add(List.generate(_columns, (col) => ''));
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: Text(loc.addRow),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _columns++;
                      for (var row in _cells) {
                        row.add('');
                      }
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: Text(loc.addColumn),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Spreadsheet grid
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
                children: List.generate(
                  _rows,
                  (row) => TableRow(
                    children: List.generate(
                      _columns,
                      (col) => _buildCell(context, row, col),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(BuildContext context, int row, int col) {
    final isSelected = _selectedRow == row && _selectedColumn == col;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRow = row;
          _selectedColumn = col;
        });
      },
      child: Container(
        color: isSelected
            ? theme.colorScheme.primary.withOpacity(0.2)
            : Colors.transparent,
        padding: const EdgeInsets.all(8),
        child: TextField(
          initialValue: _cells[row][col],
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            _cells[row][col] = value;
          },
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}
