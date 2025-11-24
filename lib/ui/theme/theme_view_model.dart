import 'package:flutter/material.dart';
import 'package:laba_4_resume/data/services/theme_service.dart';

class ThemeViewModel extends ChangeNotifier {
  final ThemeService _themeService;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeViewModel(this._themeService) {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> _loadTheme() async {
    final bool isDark = await _themeService.loadThemeMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    final isCurrentlyDark = isDarkMode;
    _themeMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    await _themeService.saveThemeMode(!isCurrentlyDark);
    notifyListeners();
  }
}