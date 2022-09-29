import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:tesis_1/app/domain/repositories/preferences_repository.dart';

class ThemeController extends SimpleNotifier {
  late ThemeMode _mode;

  ThemeController() {
    _mode = _preferences.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
  final PreferencesRepository _preferences = Get.find();
  ThemeMode get mode => _mode;
  bool get isDark => _mode == ThemeMode.dark;

  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff1b1b1b),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
      ),
      scaffoldBackgroundColor: const Color(0xff1b1b1b),
      primaryColorDark: Colors.red,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.red,
      ),
      colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark, primarySwatch: Colors.red),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
    );
  }

  void toggle() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
      _preferences.darkMode(true);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      _mode = ThemeMode.light;
      _preferences.darkMode(false);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notify();
  }
}

final themeProvider = SimpleProvider(
  (_) => ThemeController(),
  autoDispose: false,
);
