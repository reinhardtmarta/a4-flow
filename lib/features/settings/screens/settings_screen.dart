import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/config/app_config.dart';
import '../../../app/localization/app_localizations.dart';
import '../../../app/providers/app_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late String selectedLanguage;
  late bool darkMode;
  late String selectedUnit;

  @override
  void initState() {
    super.initState();
    selectedLanguage = AppConfig.getLanguage();
    darkMode = AppConfig.getDarkMode();
    selectedUnit = AppConfig.getUnit();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // General Settings
            _buildSectionHeader(context, loc.generalSettings),
            _buildLanguageSelector(context, loc),
            _buildThemeToggle(context, loc),
            _buildUnitSelector(context, loc),

            const Divider(height: 32),

            // About
            _buildSectionHeader(context, loc.about),
            _buildAboutTile(context, loc),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(loc.language),
          subtitle: Text(_getLanguageName(selectedLanguage)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showLanguageDialog(context, loc),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(loc.theme),
          subtitle: Text(darkMode ? loc.darkMode : loc.lightMode),
          trailing: Switch(
            value: darkMode,
            onChanged: (value) async {
              setState(() => darkMode = value);
              await AppConfig.setDarkMode(value);
              ref.read(themeModeProvider.notifier).state =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildUnitSelector(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(loc.unit),
          subtitle: Text(selectedUnit.toUpperCase()),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showUnitDialog(context, loc),
        ),
      ),
    );
  }

  Widget _buildAboutTile(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: ListTile(
          title: Text(loc.appName),
          subtitle: Text('${loc.version}: ${AppConfig.appVersion}'),
          trailing: const Icon(Icons.info_outline),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.language),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AppConfig.supportedLanguages.map((lang) {
                return RadioListTile<String>(
                  title: Text(_getLanguageName(lang)),
                  value: lang,
                  groupValue: selectedLanguage,
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() => selectedLanguage = value);
                      await AppConfig.setLanguage(value);
                      if (mounted) Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showUnitDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(loc.unit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ['mm', 'cm', 'pt'].map((unit) {
                return RadioListTile<String>(
                  title: Text(unit.toUpperCase()),
                  value: unit,
                  groupValue: selectedUnit,
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() => selectedUnit = value);
                      await AppConfig.setUnit(value);
                      if (mounted) Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  String _getLanguageName(String code) {
    const names = {
      'pt_BR': 'Português (Brasil)',
      'en_US': 'English (United States)',
      'es_ES': 'Español',
      'fr_FR': 'Français',
      'de_DE': 'Deutsch',
      'it_IT': 'Italiano',
      'zh_CN': '中文 (简体)',
      'ru_RU': 'Русский',
    };
    return names[code] ?? code;
  }
}
