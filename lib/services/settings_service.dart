import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _themeKey = 'themeKey';
  static const String _defaultThemeKey = 'midnight';

  Future<String> getDefaultThemeKey() async {
    return _defaultThemeKey;
  }

  Future<String> getThemeKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? _defaultThemeKey;
  }

  Future<void> setThemeKey(String themeKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeKey);
  }

  Future<void> initializeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_themeKey)) {
      await prefs.setString(_themeKey, _defaultThemeKey);
    }
  }
}
