import 'package:flutter/material.dart';

import 'main.dart';
import 'services/settings_service.dart';

class SettingsPanel extends StatelessWidget {
  final SettingsService settingsService = SettingsService();

  SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTileTheme(
            textColor: Theme.of(context).colorScheme.primary,
            iconColor: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Midnight Theme'),
                  onTap: () => _setThemeAndReload(context, 'midnight'),
                ),
                ListTile(
                  title: const Text('Penumbra Theme'),
                  onTap: () => _setThemeAndReload(context, 'penumbra'),
                ),
                ListTile(
                  title: const Text('Bright Theme'),
                  onTap: () => _setThemeAndReload(context, 'bright'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setThemeAndReload(BuildContext context, String themeKey) async {
    // Set the selected theme key
    await settingsService.setThemeKey(themeKey);

    // Reload the app to apply the new theme
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const MyApp()),
    );
  }
}
