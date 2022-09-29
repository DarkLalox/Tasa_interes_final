import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesis_1/app/domain/repositories/preferences_repository.dart';

const darkModeKey = 'dark-mode';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _prefererences;

  PreferencesRepositoryImpl(this._prefererences);
  @override
  bool get isDarkMode => _prefererences.getBool(darkModeKey) ?? false;

  @override
  Future<void> darkMode(bool enable) {
    return _prefererences.setBool(darkModeKey, enable);
  }
}
