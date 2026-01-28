import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

class ArticleModeWidget extends StatefulWidget {
  final String documentId;

  const ArticleModeWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<ArticleModeWidget> createState() => _ArticleModeWidgetState();
}

class _ArticleModeWidgetState extends State<ArticleModeWidget> {
  late TextEditingController _textController;
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Formatting toolbar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFormatButton(
                    icon: Icons.format_bold,
                    isActive: _isBold,
                    onPressed: () {
                      setState(() => _isBold = !_isBold);
                    },
                    tooltip: loc.bold,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_italic,
                    isActive: _isItalic,
                    onPressed: () {
                      setState(() => _isItalic = !_isItalic);
                    },
                    tooltip: loc.italic,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_underlined,
                    isActive: _isUnderline,
                    onPressed: () {
                      setState(() => _isUnderline = !_isUnderline);
                    },
                    tooltip: loc.underline,
                  ),
                  const VerticalDivider(),
                  _buildFormatButton(
                    icon: Icons.format_color_text,
                    onPressed: () {
                      // TODO: Show color picker
                    },
                    tooltip: loc.textColor,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_left,
                    onPressed: () {
                      // TODO: Align left
                    },
                    tooltip: loc.alignLeft,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_center,
                    onPressed: () {
                      // TODO: Align center
                    },
                    tooltip: loc.alignCenter,
                  ),
                  _buildFormatButton(
                    icon: Icons.format_align_right,
                    onPressed: () {
                      // TODO: Align right
                    },
                    tooltip: loc.alignRight,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Text editor
            TextField(
              controller: _textController,
              maxLines: null,
              minLines: 10,
              decoration: InputDecoration(
                hintText: loc.articleMode,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              style: TextStyle(
                fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
                fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
                decoration: _isUnderline
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    bool isActive = false,
  }) {
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
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isActive
                  ? Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              size: 20,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
