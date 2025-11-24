import 'package:laba_4_resume/data/services/local_storage_service.dart';

class ThemeService {
  static const String _themeKey = 'isDarkMode';
  final LocalStorageService _localStorage;

  ThemeService(this._localStorage);

  Future<bool> loadThemeMode() async {
    return await _localStorage.getBool(_themeKey) ?? false;
  }

  Future<void> saveThemeMode(bool isDarkMode) async {
    await _localStorage.setBool(_themeKey, isDarkMode);
  }
}