import 'package:flutter/material.dart';
import '../../../../app/localization/app_localizations.dart';

class SymbolsEditorWidget extends StatefulWidget {
  final String documentId;

  const SymbolsEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  @override
  State<SymbolsEditorWidget> createState() =>
      _SymbolsEditorWidgetState();
}

class _SymbolsEditorWidgetState extends State<SymbolsEditorWidget> {
  String _searchQuery = '';
  String _selectedCategory = 'greek';
  List<String> _favorites = [];

  final Map<String, List<String>> _symbols = {
    'greek': ['α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ', 'ι', 'κ', 'λ', 'μ', 'ν', 'ξ', 'ο', 'π', 'ρ', 'σ', 'τ', 'υ', 'φ', 'χ', 'ψ', 'ω'],
    'operators': ['+', '-', '×', '÷', '=', '≠', '<', '>', '≤', '≥', '±', '∓', '∑', '∏', '∫', '∂', '∇', '√', '∛', '∜'],
    'arrows': ['→', '←', '↑', '↓', '↔', '↕', '⇒', '⇐', '⇑', '⇓', '⇔', '⇕', '↗', '↘', '↙', '↖'],
    'sets': ['∈', '∉', '⊂', '⊃', '⊆', '⊇', '∪', '∩', '∅', '∀', '∃', '∄', '⊕', '⊗', '⊥', '∥'],
    'logic': ['∧', '∨', '¬', '⊢', '⊨', '⟹', '⟺', '∵', '∴'],
    'relations': ['≈', '≡', '≢', '≤', '≥', '≪', '≫', '∝', '∞', '⊥', '∠', '⟂'],
  };

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final filteredSymbols = _symbols[_selectedCategory]!
        .where((s) => s.contains(_searchQuery.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: loc.search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _symbols.keys.map((category) {
                  final isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = category);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Symbols grid
            GridView.count(
              crossAxisCount: 6,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: filteredSymbols.map((symbol) {
                final isFavorite = _favorites.contains(symbol);
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Símbolo: $symbol')),
                    );
                  },
                  onLongPress: () {
                    setState(() {
                      if (isFavorite) {
                        _favorites.remove(symbol);
                      } else {
                        _favorites.add(symbol);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isFavorite
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                        width: isFavorite ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isFavorite
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            symbol,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        if (isFavorite)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.favorite,
                              size: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            if (_favorites.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                loc.favorites,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _favorites.map((symbol) {
                  return Chip(
                    label: Text(symbol),
                    onDeleted: () {
                      setState(() => _favorites.remove(symbol));
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
