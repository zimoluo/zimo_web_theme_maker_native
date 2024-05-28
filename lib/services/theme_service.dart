import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeService {
  Future<ThemeData> loadAndApplyTheme(String themeKey) async {
    // Load JSON file based on themeKey
    String filePath = 'assets/themes/$themeKey.json';
    String jsonString = await rootBundle.loadString(filePath);

    // Parse JSON string to Map
    Map<String, dynamic> themeData = json.decode(jsonString);

    List<int> primaryColorValues =
        (themeData['palette']['primary'] as List<dynamic>).cast<int>();
    List<int> secondColorValues =
        (themeData['palette']['pastel'] as List<dynamic>).cast<int>();
    List<int> lightColorValues =
        (themeData['palette']['light'] as List<dynamic>).cast<int>();

    // Construct colors using _parseColor method
    Color primaryColor = _parseColor(primaryColorValues);
    Color pastelColor = _parseColor(secondColorValues);
    Color lightColor = _parseColor(lightColorValues);

    // Construct ThemeData
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _createMaterialColor(primaryColor),
        accentColor: pastelColor,
      ),
      scaffoldBackgroundColor: lightColor,
      appBarTheme: AppBarTheme(
          backgroundColor: lightColor, foregroundColor: primaryColor),
      useMaterial3: true,
    );
  }

  Color _parseColor(List<int> colorList) {
    return Color.fromRGBO(colorList[0], colorList[1], colorList[2], 1.0);
  }

  MaterialColor _createMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1),
    });
  }
}
