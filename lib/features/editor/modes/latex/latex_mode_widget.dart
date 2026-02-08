import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../../../app/localization/app_localizations.dart';

class LatexModeWidget extends StatefulWidget {
  final String documentId;

  const LatexModeWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<LatexModeWidget> createState() => _LatexModeWidgetState();
}

class _LatexModeWidgetState extends State<LatexModeWidget> {
  late TextEditingController _latexController;
  String _previewContent = '';
  bool _showPreview = true;
  List<String> _recentExpressions = [];

  @override
  void initState() {
    super.initState();
    _latexController = TextEditingController();
    _loadRecentExpressions();
  }

  @override
  void dispose() {
    _latexController.dispose();
    super.dispose();
  }

  void _loadRecentExpressions() {
    _recentExpressions = [
      r'\alpha + \beta = \gamma',
      r'E = mc^2',
      r'\sqrt{x^2 + y^2}',
      r'\frac{a}{b}',
      r'\int_0^\infty e^{-x} dx',
    ];
  }

  void _insertExpression(String expression) {
    _latexController.text = expression;
    _updatePreview(expression);
  }

  void _updatePreview(String latex) {
    setState(() {
      _previewContent = latex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        // Toolbar
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => _updatePreview(_latexController.text),
                tooltip: 'Atualizar preview',
              ),
              IconButton(
                icon: Icon(_showPreview ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() => _showPreview = !_showPreview);
                },
                tooltip: _showPreview ? 'Ocultar preview' : 'Mostrar preview',
              ),
              const VerticalDivider(),
              PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Fração'),
                    onTap: () => _insertExpression(r'\frac{numerador}{denominador}'),
                  ),
                  PopupMenuItem(
                    child: const Text('Raiz quadrada'),
                    onTap: () => _insertExpression(r'\sqrt{x}'),
                  ),
                  PopupMenuItem(
                    child: const Text('Integral'),
                    onTap: () => _insertExpression(r'\int_0^\infty f(x) dx'),
                  ),
                  PopupMenuItem(
                    child: const Text('Somatória'),
                    onTap: () => _insertExpression(r'\sum_{i=0}^n'),
                  ),
                  PopupMenuItem(
                    child: const Text('Produtória'),
                    onTap: () => _insertExpression(r'\prod_{i=1}^n'),
                  ),
                  PopupMenuItem(
                    child: const Text('Matriz'),
                    onTap: () => _insertExpression(
                      r'\begin{matrix} a & b \\ c & d \end{matrix}',
                    ),
                  ),
                ],
                child: const Tooltip(
                  message: 'Inserir símbolo',
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Tooltip(
                message: 'Expressões recentes',
                child: PopupMenuButton<String>(
                  itemBuilder: (context) =>
                      _recentExpressions
                          .map(
                            (expr) => PopupMenuItem(
                              onTap: () => _insertExpression(expr),
                              child: Text(expr),
                            ),
                          )
                          .toList(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.history),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),

        // Editor and Preview
        Expanded(
          child: Row(
            children: [
              // LaTeX Editor
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Código LaTeX',
                        style: theme.textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: TextField(
                          controller: _latexController,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            hintText: r'Insira seu código LaTeX aqui (ex: E = mc^2)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(
                            fontFamily: 'RobotoMono',
                            fontSize: 12,
                          ),
                          onChanged: _updatePreview,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Divider
              if (_showPreview)
                MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      // Resize functionality would go here
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                      child: Container(
                        width: 2,
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ),
                ),

              // Preview Panel
              if (_showPreview)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Preview',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.outline,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: _buildPreview(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    try {
      if (_previewContent.isEmpty) {
        return Center(
          child: Text(
            'Digite uma expressão LaTeX',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Center(
          child: Math.tex(
            _previewContent,
            textStyle: const TextStyle(fontSize: 28),
            onErrorFallback: (error) {
              return Text(
                'Erro ao renderizar: $error',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              );
            },
          ),
        ),
      );
    } catch (e) {
      return Text(
        'Erro: $e',
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
