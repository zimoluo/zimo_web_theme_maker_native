import 'package:flutter/material.dart';

import 'services/settings_service.dart';
import 'services/theme_service.dart';
import 'settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData _themeData = ThemeData.light();

  @override
  void initState() {
    super.initState();
    // Initialize settings and theme
    _initializeSettingsAndTheme();
  }

  Future<void> _initializeSettingsAndTheme() async {
    // Initialize settings service
    SettingsService settingsService = SettingsService();
    await settingsService.initializeSettings();

    // Get current theme key
    String currentThemeKey = await settingsService.getThemeKey();

    // Load and apply theme
    ThemeService themeService = ThemeService();
    ThemeData themeData = await themeService.loadAndApplyTheme(currentThemeKey);

    // Set state with the new theme data
    setState(() {
      _themeData = themeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name Here'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the SettingsPanel
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPanel()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Your App!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: const Text('Press Me'),
            ),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 100,
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Text(
                  'Box',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
