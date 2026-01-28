import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';
import 'models/text_style_model.dart';
import 'services/rich_text_service.dart';

class ArticleEditorWidget extends StatefulWidget {
  final String documentId;

  const ArticleEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<ArticleEditorWidget> createState() => _ArticleEditorWidgetState();
}

class _ArticleEditorWidgetState extends State<ArticleEditorWidget> {
  late TextEditingController _textController;
  TextStyleModel _currentStyle = const TextStyleModel();
  TextStyleType _selectedStyleType = TextStyleType.normal;
  Color _selectedTextColor = Colors.black;
  Color _selectedBackgroundColor = Colors.transparent;
  TextAlignment _selectedAlignment = TextAlignment.left;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Style selector
            _buildStyleSelector(context, loc),
            const SizedBox(height: 12),

            // Formatting toolbar
            _buildFormattingToolbar(context, loc),
            const SizedBox(height: 12),

            // Alignment toolbar
            _buildAlignmentToolbar(context, loc),
            const SizedBox(height: 16),

            // Color pickers
            _buildColorPickers(context, loc),
            const SizedBox(height: 16),

            // Text editor
            TextField(
              controller: _textController,
              maxLines: null,
              minLines: 15,
              decoration: InputDecoration(
                hintText: loc.articleMode,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              style: _currentStyle.toFlutterTextStyle(),
              textAlign: _getTextAlign(),
            ),

            const SizedBox(height: 16),

            // Character count
            Text(
              '${_textController.text.length} caracteres',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyleSelector(BuildContext context, AppLocalizations loc) {
    return Wrap(
      spacing: 8,
      children: [
        _buildStyleButton(
          context,
          loc.title,
          TextStyleType.title,
        ),
        _buildStyleButton(
          context,
          loc.section,
          TextStyleType.section,
        ),
        _buildStyleButton(
          context,
          loc.subsection,
          TextStyleType.subsection,
        ),
        _buildStyleButton(
          context,
          loc.paragraph,
          TextStyleType.paragraph,
        ),
        _buildStyleButton(
          context,
          loc.equation,
          TextStyleType.equation,
        ),
      ],
    );
  }

  Widget _buildStyleButton(
    BuildContext context,
    String label,
    TextStyleType type,
  ) {
    final isSelected = _selectedStyleType == type;
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStyleType = type;
          _currentStyle = TextStyleModel.fromType(type);
        });
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.outline,
        width: isSelected ? 2 : 1,
      ),
    );
  }

  Widget _buildFormattingToolbar(BuildContext context, AppLocalizations loc) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFormatButton(
            icon: Icons.format_bold,
            tooltip: loc.bold,
            isActive: _currentStyle.bold,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  bold: !_currentStyle.bold,
                );
              });
            },
          ),
          _buildFormatButton(
            icon: Icons.format_italic,
            tooltip: loc.italic,
            isActive: _currentStyle.italic,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  italic: !_currentStyle.italic,
                );
              });
            },
          ),
          _buildFormatButton(
            icon: Icons.format_underlined,
            tooltip: loc.underline,
            isActive: _currentStyle.underline,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  underline: !_currentStyle.underline,
                );
              });
            },
          ),
          _buildFormatButton(
            icon: Icons.strikethrough_s,
            tooltip: loc.strikethrough,
            isActive: _currentStyle.strikethrough,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  strikethrough: !_currentStyle.strikethrough,
                );
              });
            },
          ),
          const VerticalDivider(),
          _buildFormatButton(
            icon: Icons.superscript,
            tooltip: loc.superscript,
            isActive: _currentStyle.superscript,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  superscript: !_currentStyle.superscript,
                );
              });
            },
          ),
          _buildFormatButton(
            icon: Icons.subscript,
            tooltip: loc.subscript,
            isActive: _currentStyle.subscript,
            onPressed: () {
              setState(() {
                _currentStyle = _currentStyle.copyWith(
                  subscript: !_currentStyle.subscript,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentToolbar(BuildContext context, AppLocalizations loc) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAlignmentButton(
            icon: Icons.format_align_left,
            tooltip: loc.alignLeft,
            alignment: TextAlignment.left,
          ),
          _buildAlignmentButton(
            icon: Icons.format_align_center,
            tooltip: loc.alignCenter,
            alignment: TextAlignment.center,
          ),
          _buildAlignmentButton(
            icon: Icons.format_align_right,
            tooltip: loc.alignRight,
            alignment: TextAlignment.right,
          ),
          _buildAlignmentButton(
            icon: Icons.format_align_justify,
            tooltip: loc.alignJustify,
            alignment: TextAlignment.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildColorPickers(BuildContext context, AppLocalizations loc) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Text color picker
        Expanded(
          child: GestureDetector(
            onTap: () => _showColorPicker(
              context,
              loc.textColor,
              (color) {
                setState(() {
                  _selectedTextColor = color;
                  _currentStyle = _currentStyle.copyWith(
                    textColor: color,
                  );
                });
              },
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.format_color_text, size: 20),
                  const SizedBox(width: 8),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedTextColor,
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(loc.textColor),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Background color picker
        Expanded(
          child: GestureDetector(
            onTap: () => _showColorPicker(
              context,
              loc.backgroundColor,
              (color) {
                setState(() {
                  _selectedBackgroundColor = color;
                  _currentStyle = _currentStyle.copyWith(
                    backgroundColor: color,
                  );
                });
              },
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.format_color_fill, size: 20),
                  const SizedBox(width: 8),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedBackgroundColor,
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(loc.backgroundColor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isActive
                  ? theme.colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isActive
                  ? Border.all(
                      color: theme.colorScheme.primary,
                      width: 1,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlignmentButton({
    required IconData icon,
    required String tooltip,
    required TextAlignment alignment,
  }) {
    final isSelected = _selectedAlignment == alignment;
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedAlignment = alignment;
              _currentStyle = _currentStyle.copyWith(
                alignment: alignment,
              );
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(
                      color: theme.colorScheme.primary,
                      width: 1,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  void _showColorPicker(
    BuildContext context,
    String title,
    Function(Color) onColorSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: GridView.count(
            crossAxisCount: 5,
            children: [
              Colors.black,
              Colors.white,
              Colors.red,
              Colors.green,
              Colors.blue,
              Colors.yellow,
              Colors.orange,
              Colors.purple,
              Colors.pink,
              Colors.cyan,
              Colors.grey,
              Colors.amber,
              Colors.indigo,
              Colors.lime,
              Colors.teal,
            ]
                .map((color) => GestureDetector(
                      onTap: () {
                        onColorSelected(color);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  TextAlign _getTextAlign() {
    switch (_selectedAlignment) {
      case TextAlignment.left:
        return TextAlign.left;
      case TextAlignment.center:
        return TextAlign.center;
      case TextAlignment.right:
        return TextAlign.right;
      case TextAlignment.justify:
        return TextAlign.justify;
    }
  }
}
